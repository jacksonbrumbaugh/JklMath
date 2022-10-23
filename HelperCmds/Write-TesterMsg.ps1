<#
.SYNOPSIS
Send a message to the host in desired format

.NOTES
Create by Jackson Brumbaugh on 2022.10.23
#>
function Write-TesterMsg ( [string[]]$Message, [switch]$NoNewLine ) {
  foreach ( $Line in $Message ) {
    Write-Host $Line -ForegroundColor Cyan -NoNewline:$NoNewLine
  }
} # End function
