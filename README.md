# Files Shuffle 🔀 Scripts

This script shuffles all files in a folder.

## Usage

This script shuffles files in a single folder. For instance, we have **1.mp3**, **2.mp4**, **3.png**. After shuffling, we will have **1.mp3** with the content from **2.mp4**, and the file has the wrong extension. Similarly, **2.mp4** now is **3.png** content and can't be opened, and so on.

## Benefits

- Easy shuffle files.
- Gain an easy ability to change a game's asset very quickly.
- And more, based on your usage.

*Notices: Do not use this script to destroy someone's project and throw it publicly.*

## Tutorial and Demonstration

[Watch the Tutorial on YouTube](https://www.youtube.com/watch?v=PlXB3b-kXtk)
<a href="https://www.youtube.com/watch?v=PlXB3b-kXtk">
    <img src="https://img.youtube.com/vi/PlXB3b-kXtk/hqdefault.jpg" width="600" height="400" />
</a>
1. Prepare the script in RELEASE.
2. Put it somewhere if you want.
3. Prepare the folder you want to shuffle.
4. Open either CMD or PowerShell (recommended in where you put the script).
5. Run the command with perspective quotes and filenames.

## Sources

1. Somewhere on Reddit or Quora (October 2020).
2. Chat GPT (December 12, 2023).
3. Google Bard (December 12, 2023).
4. Bing AI (December 12, 2023).

## RELEASES

### V0

- Build NO: 0.
- Ripped off Reddit/Quora (unknown).
- Slow when lots of files.

### V1-ALPHA

- Build number 1.
- Optimized by Chat GPT.
- Shuffle speed improved by ~3x.
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
- Speed improved by ~5x compared to V0.
- Does not put shuffled files into the current folder beside 1 file.

### V2-RELEASE

- Build NO: 5.
- FIXED V2-BETA bugs.
- Complete functional and recommended to use.

*Please run `Set-ExecutionPolicy -ExecutionPolicy bypass` (PS must admin) then press A if you never run PS scripts before.*
