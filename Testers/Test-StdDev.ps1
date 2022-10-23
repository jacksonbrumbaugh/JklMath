<#
.SYNOPSIS
Verifies whether Get-StandardDeviation is performing as expected

.NOTES
Created by Jackson Brumabugh on 2022.10.23
#>
function Test-StdDev {
  $FullFunctionName = "Get-StandardDeviation"
  $Msg = "Testing the " + $FullFunctionName + " function"
  Write-TesterMsg $Msg

  if ( Get-Command $FullFunctionName ) {
    Write-TesterMsg "Function is loaded in this session"
  } else {
    $ErrorDetails = @{
      Message     = "Function has not been loaded into this session"
      ErrorAction = "Stop"
    }
    Write-Error @ErrorDetails
  }

  $FailedKeyword = "failed"
  $SuccessKeyword = "passed "

  Write-TesterMsg "Testing only 1: " -NoNewLine
  $OnlyOneStdDev = Get-StandardDeviation -Data 1
  if ( $OnlyOneStdDev -eq 0 ) {
    Write-TesterMsg $SuccessKeyword -NoNewLine
    Write-TesterMsg (Write-StdDev $OnlyOneStdDev)
  } else {
    Write-TesterMsg $FailedKeyword
  }

  Write-TesterMsg "Testing all 1's: " -NoNewLine
  $AllOnesStdDev = Get-StandardDeviation -Data 1, 1, 1
  if ( $AllOnesStdDev -eq 0 ) {
    Write-TesterMsg $SuccessKeyword -NoNewLine
    Write-TesterMsg (Write-StdDev $AllOnesStdDev)
  } else {
    Write-TesterMsg $FailedKeyword
  }

  Write-TesterMsg "Testing 1 & 3: " -NoNewLine
  $OneAndThreeStdDev = Get-StandardDeviation -Data 1, 3
  if ( $OneAndThreeStdDev -eq 1 ) {
    Write-TesterMsg $SuccessKeyword -NoNewLine
    Write-TesterMsg (Write-StdDev $OneAndThreeStdDev)
  } else {
    Write-TesterMsg $FailedKeyword
  }

  Write-TesterMsg "Testing 1 -> 5: " -NoNewLine
  $OneThruFiveStdDev = Get-StandardDeviation -Data 1, 2, 3, 4, 5
  if ( $OneAndThreeStdDev -eq 1 ) {
    Write-TesterMsg $SuccessKeyword -NoNewLine
    Write-TesterMsg (Write-StdDev $OneThruFiveStdDev)
  } else {
    Write-TesterMsg $FailedKeyword
  }

} # End function

function Write-StdDev ( [string]$StdDev ) {
  $Line = "(StdDev = " + $StdDev + ")"
  Write-Output $Line
} # End function
