<#
.SYNOPSIS
Returns some basic statistical analyses (average, max, min, standard dev) of input data

.NOTES
Created by Jackson Brumbaugh on 2023.01.31
Version Code: 23Jan31-B
#>
function Get-StatAnalysis {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory
    )]
    [int[]]
    $Data
  ) # End block:param

  process {
    $QuickAnalysis = $Data | Measure-Object -Average -Maximum -Minimum

    $StandardDeviation = Get-StandardDeviation -Data $Data

    $OutputAnalysis = @{
      Ave    = $QuickAnalysis.Average
      Max    = $QuickAnalysis.Maximum
      Min    = $QuickAnalysis.Minimum
      StdDev = $StandardDeviation
    }

    Write-Output $OutputAnalysis

  } # End block:process

} # End function

foreach ( $ThisAlias in ("Stat", "Analyze") ) {
  Set-Alias -Name $ThisAlias -Value Get-StatAnalysis
  Export-ModuleMember -Alias $ThisAlias
}
