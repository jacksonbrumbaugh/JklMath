<# RULER..........20........30........40........50........60........70........80........90.......100.......110.......120
.SYNOPSIS
Calculate the resulting cropped size for an image to be a desired ratio (default ratio is 16:9)

.NOTES
Modified: 2024-06-01
By: Jackal Bruit

OG Author: Jackal Bruit

#>
function Find-CropSize {
  param (
    [Parameter(
      Mandatory
    )]
    [Alias( "Height", "Heighth")]
    [double]
    $Length,

    [Parameter(
      Mandatory
    )]
    [double]
    $Width,

    [string]
    $Ratio = "16:9"
  )

  process {
    $RatioNumberArray = $Ratio.split( ":" )

    $LargeRatioNumber = ($RatioNumberArray | Measure-Object -Max).Maximum
    $SmallRatioNumber = ($RatioNumberArray | Measure-Object -Min).Minimum

    $DimensionArray = @(
      $Length,
      $Width
    )

    $LargeDimension = ($DimensionArray | Measure-Object -Max).Maximum
    $SmallDimension = ($DimensionArray | Measure-Object -Min).Minimum

    $LargeProportion = $LargeDimension / $LargeRatioNumber
    $SmallProportion = $SmallDimension / $SmallRatioNumber

    $ScaledDimensionOutput = [PSCustomObject]@{
      Long = 0
      Short = 0
    }

    $Scale = if ( $LargeProportion -lt $SmallProportion ) {
      [math]::Floor( $LargeProportion )
    } else {
      [math]::Floor( $SmallProportion )
    }

    $ScaledDimensionOutput.Long = $LargeRatioNumber * $Scale
    $ScaledDimensionOutput.Short = $SmallRatioNumber * $Scale

    Write-Output $ScaledDimensionOutput

  } # End block:process

} # End function
