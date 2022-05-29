Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

#For High DPI, We Set AutoScaleDimensions and AutoScaleMode
#The reason SizeF is set to 96 is that the standard Windows resolution for the display is 96.
#Maybe you shuld try that All object resets Drawing.Point And Drawing.Size
#In some cases, review the Drawing.Point and Drawing.Size of all objects, depending on the resolution of your display.
$form.AutoScaleDimensions =  New-Object System.Drawing.SizeF(96, 96)
$form.AutoScaleMode  = [System.Windows.Forms.AutoScaleMode]::Dpi


$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,160)
$OKButton.Size = New-Object System.Drawing.Size(75,50)
$OKButton.Text = 'OK'
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,160)
$CancelButton.Size = New-Object System.Drawing.Size(200,50)
$CancelButton.Text = 'Cancel'
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(800,60)
$label.Text = 'Please make a selection from the list below:'
$form.Controls.Add($label)

$listBox = New-Object System.Windows.Forms.Listbox
$listBox.Location = New-Object System.Drawing.Point(75,80)
$listBox.Size = New-Object System.Drawing.Size(260,20)

$listBox.SelectionMode = 'MultiExtended'
#For High DPI, We Set Font Size
#In Japanese, "Yu Gothic UI" is the best font type. However, this font is for Japan only. Therefore, the default font definition is undefined.
#$Font = New-Object System.Drawing.Font("Yu Gothic UI",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$Font = New-Object System.Drawing.Font("",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$listBox.Font =  $Font 

[void] $listBox.Items.Add('Item 1')
[void] $listBox.Items.Add('Item 2')
[void] $listBox.Items.Add('Item 3')
[void] $listBox.Items.Add('Item 4')
[void] $listBox.Items.Add('Item 5')

$listBox.Height = 70
$form.Controls.Add($listBox)
$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $listBox.SelectedItems
    $x
}
