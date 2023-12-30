import os
import random
import argparse

def shuffle_files(directory):
    if not os.path.exists(directory):
        print("Directory not found or not correct.")
        return

    file_list = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    
    if len(file_list) < 2:
        print("Need at least two files for shuffling.")
        return

    for file_name in file_list:
        source_path = os.path.join(directory, file_name)

        # Read content of the file, shuffle lines, and write back to the same file
        with open(source_path, 'r', encoding='utf-8') as source_file:
            lines = source_file.readlines()
            random.shuffle(lines)

        with open(source_path, 'w', encoding='utf-8') as destination_file:
            destination_file.writelines(lines)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Shuffle lines in files in a directory.")
    parser.add_argument("directory", help="The path to the directory containing files.")
    args = parser.parse_args()
    
    shuffle_files(args.directory)
    print("Files shuffled successfully.")
