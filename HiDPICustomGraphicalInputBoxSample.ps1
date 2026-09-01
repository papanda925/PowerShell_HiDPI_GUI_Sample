# Based on Microsoft's "Creating a custom input box" PowerShell sample.
# This version adds DPI scaling and layout containers so controls remain visible.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = [System.Windows.Forms.Form]::new()
$form.Text = 'Data Entry Form'
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.ClientSize = [System.Drawing.Size]::new(480, 180)
$form.MinimumSize = [System.Drawing.Size]::new(400, 190)
$form.AutoScaleDimensions = [System.Drawing.SizeF]::new(96.0, 96.0)
$form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
$form.Topmost = $true

# Use the current Windows dialog font. Point-based fonts scale more naturally
# than a fixed, large pixel font when the display DPI changes.
$uiFont = [System.Drawing.SystemFonts]::MessageBoxFont.Clone()
$form.Font = $uiFont

$layout = [System.Windows.Forms.TableLayoutPanel]::new()
$layout.Dock = [System.Windows.Forms.DockStyle]::Fill
$layout.Padding = [System.Windows.Forms.Padding]::new(12)
$layout.ColumnCount = 1
$layout.RowCount = 3
[void]$layout.RowStyles.Add([System.Windows.Forms.RowStyle]::new([System.Windows.Forms.SizeType]::AutoSize))
[void]$layout.RowStyles.Add([System.Windows.Forms.RowStyle]::new([System.Windows.Forms.SizeType]::Percent, 100))
[void]$layout.RowStyles.Add([System.Windows.Forms.RowStyle]::new([System.Windows.Forms.SizeType]::AutoSize))
$form.Controls.Add($layout)

$label = [System.Windows.Forms.Label]::new()
$label.AutoSize = $true
$label.Margin = [System.Windows.Forms.Padding]::new(3, 3, 3, 10)
$label.Text = 'Please enter the information in the space below:'
$layout.Controls.Add($label, 0, 0)

$textBox = [System.Windows.Forms.TextBox]::new()
$textBox.Dock = [System.Windows.Forms.DockStyle]::Top
$layout.Controls.Add($textBox, 0, 1)

$buttonPanel = [System.Windows.Forms.FlowLayoutPanel]::new()
$buttonPanel.AutoSize = $true
$buttonPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$buttonPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::RightToLeft
$buttonPanel.WrapContents = $false
$layout.Controls.Add($buttonPanel, 0, 2)

$cancelButton = [System.Windows.Forms.Button]::new()
$cancelButton.AutoSize = $true
$cancelButton.MinimumSize = [System.Drawing.Size]::new(80, 30)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$buttonPanel.Controls.Add($cancelButton)

$okButton = [System.Windows.Forms.Button]::new()
$okButton.AutoSize = $true
$okButton.MinimumSize = [System.Drawing.Size]::new(80, 30)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$buttonPanel.Controls.Add($okButton)

$form.AcceptButton = $okButton
$form.CancelButton = $cancelButton
$form.Add_Shown({ $textBox.Select() })

$selectedText = $null
try {
    if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedText = $textBox.Text
    }
}
finally {
    $form.Dispose()
    $uiFont.Dispose()
}

if ($null -ne $selectedText) {
    $selectedText
}
