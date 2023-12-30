import os
import shutil
import torch
import random
import argparse

def main(directory, file_mask="*.*"):
    if not os.path.exists(directory):
        print(f"Directory {directory} not found.")
        return

    # Get the list of files
    file_list = [file for file in os.listdir(directory) if os.path.isfile(os.path.join(directory, file)) and file_mask in file]

    if len(file_list) < 2:
        print("Need at least two files for shuffling.")
        return

    # Create a temporary directory for shuffling
    temp_directory = os.path.join(directory, "TempShuffle")
    os.makedirs(temp_directory, exist_ok=True)

    # Shuffle file indices
    shuffled_indices = list(range(len(file_list)))
    random.shuffle(shuffled_indices)

    # Perform the shuffle
    for i in range(len(file_list)):
        source_index = shuffled_indices[i]
        destination_index = shuffled_indices[(i + 1) % len(file_list)]

        source_file = os.path.join(directory, file_list[source_index])
        destination_file = os.path.join(temp_directory, file_list[destination_index])

        print(f"{source_file} >> {destination_file}")
        shutil.move(source_file, destination_file)

    # Move shuffled files back to the original directory
    for file in os.listdir(temp_directory):
        source_file = os.path.join(temp_directory, file)
        destination_file = os.path.join(directory, file)
        shutil.move(source_file, destination_file)

    # Remove temporary directory
    shutil.rmtree(temp_directory)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="File Shuffler")
    parser.add_argument("directory", type=str, help="Directory path for shuffling files")
    parser.add_argument("-m", "--file-mask", type=str, default="*.*", help="File mask for filtering files (default: *.*)")

    args = parser.parse_args()

    # Check if GPU is available and use it
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
    print(f"Using device: {device}")
    torch.cuda.empty_cache()  # Clear GPU memory

    main(directory=args.directory, file_mask=args.file_mask)
