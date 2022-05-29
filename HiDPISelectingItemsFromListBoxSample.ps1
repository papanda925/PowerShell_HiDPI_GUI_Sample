Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Select a Computer'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

#For High DPI, We Set AutoScaleDimensions and AutoScaleMode
#The reason SizeF is set to 96 is that the standard Windows resolution for the display is 96.
#Maybe you shuld try that All object resets Drawing.Point And Drawing.Size
#In some cases, review the Drawing.Point and Drawing.Size of all objects, depending on the resolution of your display.
$form.AutoScaleDimensions =  New-Object System.Drawing.SizeF(96, 96)
$form.AutoScaleMode  = [System.Windows.Forms.AutoScaleMode]::Dpi


$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,160)
$okButton.Size = New-Object System.Drawing.Size(75,50)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,160)
$cancelButton.Size = New-Object System.Drawing.Size(150,50)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(500,40)
$label.Text = 'Please select a computer:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.ListBox
$listBox.Location = New-Object System.Drawing.Point(10,80)
$listBox.Size = New-Object System.Drawing.Size(260,20)
$listBox.Height = 80
#For High DPI, We Set Font Size
#In Japanese, "Yu Gothic UI" is the best font type. However, this font is for Japan only. Therefore, the default font definition is undefined.
#$Font = New-Object System.Drawing.Font("Yu Gothic UI",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$Font = New-Object System.Drawing.Font("",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$listBox.Font =  $Font 

[void] $listBox.Items.Add('atl-dc-001')
[void] $listBox.Items.Add('atl-dc-002')
[void] $listBox.Items.Add('atl-dc-003')
[void] $listBox.Items.Add('atl-dc-004')
[void] $listBox.Items.Add('atl-dc-005')
[void] $listBox.Items.Add('atl-dc-006')
[void] $listBox.Items.Add('atl-dc-007')

$form.Controls.Add($listBox)

$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItem
    $x
}
