$ErrorActionPreference = 'Stop'

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$sampleFiles = Get-ChildItem -LiteralPath $repositoryRoot -Filter '*.ps1' -File
$failures = [System.Collections.Generic.List[string]]::new()

foreach ($sampleFile in $sampleFiles) {
    $tokens = $null
    $parseErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile(
        $sampleFile.FullName,
        [ref]$tokens,
        [ref]$parseErrors
    )

    foreach ($parseError in $parseErrors) {
        $failures.Add("$($sampleFile.Name): $($parseError.Message)")
    }

    $source = [System.IO.File]::ReadAllText($sampleFile.FullName)
    if ($source -notmatch 'AutoScaleMode\]\:\:Dpi') {
        $failures.Add("$($sampleFile.Name): AutoScaleMode.Dpi is required.")
    }
    if ($source -notmatch 'AutoScaleDimensions\s*=.+96\.0.+96\.0') {
        $failures.Add("$($sampleFile.Name): 96-DPI design dimensions are required.")
    }
    if ($source -notmatch 'TableLayoutPanel') {
        $failures.Add("$($sampleFile.Name): use a layout container instead of only fixed coordinates.")
    }
    if ($source -notmatch '\$form\.Dispose\(\)') {
        $failures.Add("$($sampleFile.Name): dispose the form deterministically.")
    }
    if ($source -match 'Font\("",\s*45') {
        $failures.Add("$($sampleFile.Name): do not use an unnamed 45-pixel font.")
    }
}

$readme = [System.IO.File]::ReadAllText((Join-Path $repositoryRoot 'README.md'))
foreach ($sampleFile in $sampleFiles) {
    if ($readme -notmatch [regex]::Escape($sampleFile.Name)) {
        $failures.Add("README does not list $($sampleFile.Name).")
    }
}

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Host "Validated $($sampleFiles.Count) PowerShell samples."
