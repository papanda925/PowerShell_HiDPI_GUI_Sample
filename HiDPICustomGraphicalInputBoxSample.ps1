#this sample is Based on is microsoft sample thit is Creating a Custom Input Box
#URL:https://docs.microsoft.com/en-us/powershell/scripting/samples/creating-a-custom-input-box?view=powershell-7.2

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

#--- For High DPI, Call SetProcessDPIAware(need P/Invoke) and EnableVisualStyles ---
Add-Type -TypeDefinition @'
using System.Runtime.InteropServices;
public class ProcessDPI {
    [DllImport("user32.dll", SetLastError=true)]
    public static extern bool SetProcessDPIAware();      
}
'@
$null = [ProcessDPI]::SetProcessDPIAware()
[System.Windows.Forms.Application]::EnableVisualStyles()


$form = New-Object System.Windows.Forms.Form

#--- For High DPI, First Call SuspendLayout(),After that, Set AutoScaleDimensions, AutoScaleMode ---
# SuspendLayout() is Very important to correctly size and position all controls!
$form.SuspendLayout()
$form.AutoScaleDimensions =  New-Object System.Drawing.SizeF(96, 96)
$form.AutoScaleMode  = [System.Windows.Forms.AutoScaleMode]::Dpi

$form.Text = 'Data Entry Form'
$form.Size = New-Object System.Drawing.Size(300,200)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(75,120)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(150,120)
$cancelButton.Size = New-Object System.Drawing.Size(75,23)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Please enter the information in the space below:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(260,20)
#For High DPI, Set Font Size 
#In Japanese, "Yu Gothic UI" is the best font type. However, this font is for Japan only. Therefore, the default font definition is undefined.
#$Font = New-Object System.Drawing.Font("Yu Gothic UI",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$Font = New-Object System.Drawing.Font("",45,([System.Drawing.FontStyle]::Regular),[System.Drawing.GraphicsUnit]::Pixel)
$textBox.Font =  $Font 

$form.Controls.Add($textBox)

$form.Topmost = $true

$form.Add_Shown({$textBox.Select()})

#--- For High DPI, Finally, Call ResumeLayout(),before ShowDialog() ---
# ResumeLayout() is Very important to correctly size and position all controls!
$form.ResumeLayout()

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    $x = $textBox.Text
    $x
}

