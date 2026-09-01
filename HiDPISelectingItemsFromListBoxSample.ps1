# High-DPI-aware Windows Forms sample for selecting one item.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

$form = [System.Windows.Forms.Form]::new()
$form.Text = 'Select a Computer'
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::CenterScreen
$form.ClientSize = [System.Drawing.Size]::new(460, 340)
$form.MinimumSize = [System.Drawing.Size]::new(380, 280)
$form.AutoScaleDimensions = [System.Drawing.SizeF]::new(96.0, 96.0)
$form.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::Dpi
$form.Topmost = $true

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
$label.Text = 'Please select a computer:'
$layout.Controls.Add($label, 0, 0)

$listBox = [System.Windows.Forms.ListBox]::new()
$listBox.Dock = [System.Windows.Forms.DockStyle]::Fill
$listBox.SelectionMode = [System.Windows.Forms.SelectionMode]::One
[void]$listBox.Items.AddRange([object[]](
    'atl-dc-001',
    'atl-dc-002',
    'atl-dc-003',
    'atl-dc-004',
    'atl-dc-005',
    'atl-dc-006',
    'atl-dc-007'
))
$layout.Controls.Add($listBox, 0, 1)

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

$selectedItem = $null
try {
    if ($form.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedItem = $listBox.SelectedItem
    }
}
finally {
    $form.Dispose()
    $uiFont.Dispose()
}

if ($null -ne $selectedItem) {
    $selectedItem
}
