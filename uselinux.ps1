Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$url = "https://electrolynx.dev/uselinux.png"

try {
    $webClient = New-Object System.Net.WebClient
    $imageBytes = $webClient.DownloadData($url)
    $ms = New-Object System.IO.MemoryStream(,$imageBytes)
    $image = [System.Drawing.Image]::FromStream($ms)
}
catch {
    Write-Error "Impossible de télécharger ou charger l'image : $_"
    exit
}

$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None
$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized
$form.TopMost = $true
$form.BackColor = [System.Drawing.Color]::Black
$form.StartPosition = [System.Windows.Forms.FormStartPosition]::Manual
$form.Bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds


$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Dock = [System.Windows.Forms.DockStyle]::Fill
$pictureBox.Image = $image
$pictureBox.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom 


$form.KeyPreview = $true
$form.Add_KeyDown({
    if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Escape) {
        $form.Close()
    }
})

$form.Controls.Add($pictureBox)
[void]$form.ShowDialog()

$image.Dispose()
$ms.Dispose()
$webClient.Dispose()
