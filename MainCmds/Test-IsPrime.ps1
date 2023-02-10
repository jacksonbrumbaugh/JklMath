<#
.SYNOPSIS
Returns a boolean value checking if the input number is prime or not

.NOTES
Created by Jackson Brumbaugh on 2023.02.10
Version Code: 2023Feb10-A
#>
function Test-IsPrime {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory,
      ValueFromPipeline
    )]
    [ValidateRange(0, [int]::MaxValue)]
    [Alias("No")]
    [int]
    $Number
  ) # End block:param

  begin {
    $First25PrimeArray = @(
      2,  3,  5,  7,  11,
      13, 17, 19, 23, 29,
      31, 37, 41, 43, 47,
      53, 59, 61, 67, 71,
      73, 79, 83, 89, 97
    )
  }

  process {
    # Assume the number is not prime until proven prime
    $isPrimeResult = $false

    if ( $Number -lt 100 ) {
      if ( $Number -in $First25PrimeArray ) {
        $isPrimeResult = $true
      } 
    }

    if ( $Number -ge 100 ) {
      Write-Warning "This function has not yet been propertly coded to handle numbers 100 & bigger"
      # Check if any prime less than SqRt($Number) is a factor of the number
      # if ( $Number % <SomePrime> -eq 0 ) then ( $Number is not prime )
    }

    Write-Output $isPrimeResult

  } # End block:process

} # End function
