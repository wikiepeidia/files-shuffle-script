# Files Shuffle 🔀 Script

This script shuffles all files in a desired folder.

## Usage

This script shuffles files in a single folder. For instance, we have **1.mp3**, **2.mp4**, **3.png**. After shuffling, we will have **1.mp3** with the content from **2.mp4**, and the file has the wrong extension. Similarly, **2.mp4** now is **3.png** content and can't be opened, and so on.

## Benefits

- Easy shuffle files.
- Gain an easy ability to change a game's asset very quickly.
- Make privacies
- And more, based on your usage.

*Notices: Do not use this script to destroy someone's project and throw it publicly.Don't use this script in dangerous areas such as system32... If you get access is denied, then you might need to check for ownership*

## Tutorial and Demonstration

[Watch the Tutorial on YouTube](https://www.youtube.com/watch?v=PlXB3b-kXtk)
<a href="https://www.youtube.com/watch?v=PlXB3b-kXtk">
    <img src="https://img.youtube.com/vi/PlXB3b-kXtk/hqdefault.jpg" width="600" height="400" />
</a>
1. Prepare the script in RELEASE.
2. Put it somewhere if you want.
3. Prepare the folder you want to shuffle.
4. Open either CMD or PowerShell (recommended in where you put the script).
5. Run the command with perspective quotes and the script's path.

## Sources

1. Somewhere on Reddit or Quora (October 2022).
2. Chat GPT (December 12, 2023).
3. Google Bard (December 12, 2023).
4. Bing AI (December 12, 2023).

## RELEASES
[Download Latest Release](https://github.com/wikiepeidia/files-shuffle-script/releases)
### V0

- Build NO: 0.
- Ripped off Reddit/Quora (unknown).
- Slow when lots of files.
- consistencies: 90% (it can sometimes fail to move file)
- file name consisting of $, ! symbols will fail to suffle and cause more bugs.

### V1-ALPHA

- Build number 1.
- Optimized by Chat GPT.
- Shuffle speed improved by ~3-4x.
- Fails to "find files" and copy them to the destination.

### V1-BETA

- Build number 2.
- Optimized by Chat GPT 2nd time.
- Added more DEBUG.
- Still does not work.

### V1-Release Candidate

- Build number 3.
- Optimized by Google Bard and Bing AI because GPT has issues.
- Compared to V1-ALPHA, speed reduced by ~50%.
- STILL DOES NOT WORK.

*This is the end for batch file script; move to PS for more PERF*

### V2-BETA

- Build NO: 4.
- Rewritten in PowerShell.
- Speed improved by ~5-8x compared to V0.
- Does not put shuffled files into the current folder beside 1 file.
- All bugs from V0 has been fixed.

### V2-RELEASE

- Build NO: 5.
- FIXED V2-BETA bugs.
- current BUG: it suffle the folder as well, *make sure there is NO folder inside where you suffle*

### V2.1
- Build NO 6
- FIX V2-RELAEASE bug.

  
*Please run `Set-ExecutionPolicy -ExecutionPolicy bypass` (PS must admin) then press A if you never run PS scripts before.*
*This script is guranteed to run when executed in the same folder as powershell (path is much different than cmd) and make sure that is should be `& '.\file.ps1' "PATH TO FOLDER"`*
*You can apply file masks to avoid shuffling another file that has a different extension. For instance, if you are shuffling in a folder containing **.png** and **.wav** files, you can run `& '.\file.ps1' "PATH TO FOLDER" *.FILEEXTENSION` to do so.*
