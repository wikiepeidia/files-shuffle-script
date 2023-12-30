param (
    [string]$directory = "",
    [string]$fileMask = "*"
)

if ($directory -eq "" -or -not (Test-Path $directory)) {
    Write-Host "Directory not found or not correct."
    Write-Host "Usage: FileNameRandomizer.ps1 -directory {directory} [-fileMask {file mask}]"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  FileNameRandomizer.ps1 -directory 'C:\Users\phamt\OneDrive - caugiay.edu.vn\Máy tính\New folder'"
    Write-Host "  FileNameRandomizer.ps1 -directory '..\testdir' -fileMask '*.txt'"
    Write-Host "  FileNameRandomizer.ps1 -directory 'testdir' -fileMask 'the file*.*'"
    exit
}

function Shuffle-Files {
    param($fileList, $tempDirectory)

    $shuffledFiles = @()

    foreach ($file in $fileList) {
        $randomName = [System.IO.Path]::GetRandomFileName()
        $destinationFile = Join-Path -Path $tempDirectory -ChildPath $randomName

        Move-Item -Path $file.FullName -Destination $destinationFile -Force
        $shuffledFiles += [PSCustomObject]@{ Source = $file.FullName; Destination = $destinationFile }
    }

    $shuffledFiles  # Return the moved file paths with source-to-destination mapping
}

# Get the list of files
$fileList = Get-ChildItem -Path $directory -Filter $fileMask | Where-Object { -not $_.PSIsContainer }

if ($fileList.Count -lt 2) {
    Write-Host "Need at least two files for shuffling."
    exit
}

# Create a temporary directory for shuffling
$tempDirectory = Join-Path -Path $directory -ChildPath "TempShuffle"
New-Item -ItemType Directory -Force -Path $tempDirectory | Out-Null

# Call the function to shuffle files
$shuffledFiles = Shuffle-Files -fileList $fileList -tempDirectory $tempDirectory

# Move shuffled files back to the original directory
$shuffledFiles | ForEach-Object {
    Move-Item -Path $_.Destination -Destination $directory -Force
}

# Remove temporary directory 4S
Remove-Item -Path $tempDirectory -Force -Recur

# Display the shuffled files with source-to-destination mapping
Write-Host "Shuffled Files:"
$shuffledFiles | ForEach-Object {
    Write-Host "$($_.Source) -> $($_.Destination)"
}
