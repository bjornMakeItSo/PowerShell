# Configuration
$ip = "192.168.1.20"
$port = "8080"
$username = "Theuser"
$password = "ThePassword"
$magnetLink = "magnet:?xt=urn:btih:f16805a...."

# Create a web session for authentication
$cred = New-Object System.Management.Automation.PSCredential($username, (ConvertTo-SecureString $password -AsPlainText -Force))
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Get token
$tokenUrl = "http://$ip`:$port/gui/token.html"
$response = Invoke-WebRequest -Uri $tokenUrl -Credential $cred -WebSession $session -AllowUnencryptedAuthentication
$token = $response.Content.Split('>')[2].Split('<')[0]

# Send magnet link
$addUrl = "http://$ip`:$port/gui/?token=$token&action=add-url&s=$magnetLink"
$response = Invoke-WebRequest -Uri $addUrl -Credential $cred -WebSession $session -AllowUnencryptedAuthentication

if ($response.StatusCode -eq 200) {
    Write-Host "Magnet link sent successfully!"
} else {
    Write-Host "Failed to send magnet link: $($response.StatusCode)"
}


