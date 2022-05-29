#This sample is Based on is microsoft sample thit is Graphical Date Picker
#URL:https://docs.microsoft.com/en-us/powershell/scripting/samples/creating-a-graphical-date-picker?view=powershell-7.2
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form -Property @{
    StartPosition = [Windows.Forms.FormStartPosition]::CenterScreen
    Size          = New-Object Drawing.Size 243, 300
    Text          = 'Select a Date'
    Topmost       = $true
}

#For High DPI, We Set AutoScaleDimensions and AutoScaleMode
#The reason SizeF is set to 96 is that the standard Windows resolution for the display is 96.
#Maybe you shuld try that All object resets Drawing.Point And Drawing.Size
#In some cases, review the Drawing.Point and Drawing.Size of all objects, depending on the resolution of your display.
$form.AutoScaleDimensions =  New-Object System.Drawing.SizeF(96, 96)
$form.AutoScaleMode  = [System.Windows.Forms.AutoScaleMode]::Dpi


$calendar = New-Object Windows.Forms.MonthCalendar -Property @{
    ShowTodayCircle   = $false
    MaxSelectionCount = 1
}
$form.Controls.Add($calendar)

$okButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 38, 500
    Size         = New-Object Drawing.Size 75, 50
    Text         = 'OK'
    DialogResult = [Windows.Forms.DialogResult]::OK
}
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object Windows.Forms.Button -Property @{
    Location     = New-Object Drawing.Point 113, 500
    Size         = New-Object Drawing.Size 150, 50
    Text         = 'Cancel'
    DialogResult = [Windows.Forms.DialogResult]::Cancel
}
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$result = $form.ShowDialog()

if ($result -eq [Windows.Forms.DialogResult]::OK) {
    $date = $calendar.SelectionStart
    Write-Host "Date selected: $($date.ToShortDateString())"
}
