function Test-Prime ( [int]$Number ) {
  $Result = $true

  $AllClearMsg = "No errors {="
  $ErrorParams = @{
    Message     = $AllClearMsg
    ErrorAction = "Continue"
  }

  $NumberModulo1 = $Number % 1
  if ( $NumberModulo1 -ne 0 ) {
    $ErrorParams.Message = "Input number cannot have a fractional component"
  }

  if ( $Number -lt 0 ) {
    $ErrorParams.Message = "Input number cannot be less than 0"
  }

  if ( $ErrorParams.Message -ne $AllClearMsg ) {
    $ErrorParams.Message += " ~ must be a non-negative integer"
    $ErrorParams.ErrorAction = "Stop"

    Write-Error @ErrorParams
  }

  if ( $Number -in (0, 1) ) {
    $Result = $false

    Return $Result
  }

  $PrimesList = @(2)

  while ( $Number -lt $PrimesList[-1] ) {
    
  }
} # End function
