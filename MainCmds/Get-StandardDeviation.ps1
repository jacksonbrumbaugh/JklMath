<#
.SYNOPSIS
Calculates either the population (default) or sample standard deviation of a data set

.NOTES
Created by Jackson Brumabugh on 2022.10.23
VersionCode: 2023Jun21-A
#>
function Get-StandardDeviation {
  [CmdletBinding()]
  param(
    [Parameter(
      Mandatory,
      ValueFromPipeline,
      ValueFromPipelineByPropertyName,
      ValueFromRemainingArguments
    )]
    [Alias("D")]
    [float[]]
    $Data,

    # Flag to use if the data is a sample from a population
    [Parameter(
      ValueFromPipelineByPropertyName
    )]
    [Alias("S", "Sam", "Samp")]
    [switch]
    $Sample

  ) # End block:param

  process {
    $ValidData = foreach ( $Value in $Data ) {
      if ( $Value -eq 0 -or $Value -as [float] ) {
        $Value -as [float]
      } else {
        Write-Warning "Excluding the value $Value as NaN"
      }
    }

    $DataSize = $ValidData.Count

    if ( $DataSize -eq 0 ) {
      Write-Error "All data points given were invalid (NaN)"
      continue
    }

    $Denominator = if ( $Sample ) {
      if ( $DataSize -eq 1 ) {
        $ErrorMsg = "Not enough data points were given to run as a sample analysis. "
        $ErrorMsg += "More than 1 sample data is required. "
        Write-Error $ErrorMsg
        continue
      }

      $DataSize - 1
    } else {
      $DataSize
    }

    $MeasuredData = $ValidData | Measure-Object -Average
    $DataAverage = $MeasuredData | Select-Object -ExpandProperty Average

    $ListOfDiffSquared = foreach ( $Value in $ValidData ) {
      $Difference = $Value - $DataAverage
      $Difference * $Difference
    }

    $MeasuredDiffSquared = $ListOfDiffSquared | Measure-Object -Sum

    $SumOfDiffSquared = $MeasuredDiffSquared | Select-Object -ExpandProperty Sum

    $StdDev = [math]::SqRt( $SumOfDiffSquared / $Denominator )

    Write-Output $StdDev

  } # End block:process

} # End function

$Aliases = ("SD", "StdDev", "Get-StdDev")
foreach ( $Alias in $Aliases ) {
  Set-Alias -Value Get-StandardDeviation -Name $Alias
  Export-ModuleMember -Alias $Alias
}
