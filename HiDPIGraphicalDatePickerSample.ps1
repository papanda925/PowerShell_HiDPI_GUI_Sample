# Based on Microsoft's "Creating a graphical date picker" PowerShell sample.
# This version adds DPI scaling and layout containers so controls remain visible.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = [System.Windows.Forms.Form]::new()
$form.Text = 'Select a Date'
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.ClientSize = [System.Drawing.Size]::new(320, 280)
$form.MinimumSize = [System.Drawing.Size]::new(300, 270)
$form.AutoScaleDimensions = [System.Drawing.SizeF]::new(96.0, 96.0)
$form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
$form.Topmost = $true

$uiFont = [System.Drawing.SystemFonts]::MessageBoxFont.Clone()
$form.Font = $uiFont

$layout = [System.Windows.Forms.TableLayoutPanel]::new()
$layout.Dock = [System.Windows.Forms.DockStyle]::Fill
$layout.Padding = [System.Windows.Forms.Padding]::new(12)
$layout.ColumnCount = 1
$layout.RowCount = 2
[void]$layout.RowStyles.Add([System.Windows.Forms.RowStyle]::new([System.Windows.Forms.SizeType]::Percent, 100))
[void]$layout.RowStyles.Add([System.Windows.Forms.RowStyle]::new([System.Windows.Forms.SizeType]::AutoSize))
$form.Controls.Add($layout)

$calendarPanel = [System.Windows.Forms.FlowLayoutPanel]::new()
$calendarPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$calendarPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::LeftToRight
$calendarPanel.WrapContents = $false
$layout.Controls.Add($calendarPanel, 0, 0)

$calendar = [System.Windows.Forms.MonthCalendar]::new()
$calendar.MaxSelectionCount = 1
$calendar.ShowTodayCircle = $false
$calendarPanel.Controls.Add($calendar)

$buttonPanel = [System.Windows.Forms.FlowLayoutPanel]::new()
$buttonPanel.AutoSize = $true
$buttonPanel.Dock = [System.Windows.Forms.DockStyle]::Fill
$buttonPanel.FlowDirection = [System.Windows.Forms.FlowDirection]::RightToLeft
$buttonPanel.WrapContents = $false
$layout.Controls.Add($buttonPanel, 0, 1)

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

$selectedDate = $null
try {
    if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedDate = $calendar.SelectionStart
    }
}
finally {
    $form.Dispose()
    $uiFont.Dispose()
}

if ($null -ne $selectedDate) {
    $selectedDate
}
