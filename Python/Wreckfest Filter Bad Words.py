import os  # these are all pre-installed dependencies
import re
import argparse  # for CLI arguments.

parser = argparse.ArgumentParser(description="Script designed to scan your Wreckfest server log and capture the names and Steam IDs of people who say bad words.")
parser.add_argument('-o', '--output', metavar='filename', help='Output file', required=False)
parser.add_argument('-l', '--log', metavar='filename', help='Log file', required=True)
parser.add_argument('-w', '--words', metavar='word', nargs='*', help='Banned words', required=True)
args = parser.parse_args()

log_file = args.log
output_file_name = args.output or 'output_from_log.txt'
words = args.words

word_counts = {word: 0 for word in words}  # Initialize word counts to zero
flagged_lines = list()
offenders_list = set()  # no duplicates
offenders = dict()

if not os.path.exists(log_file):
    raise FileNotFoundError(f'{log_file} does not exist!')

with open(log_file, 'r', encoding='utf-8') as file:
    lines = file.readlines()

for line in lines:
    for word in words:
        if word in line:
            word_counts[word] += 1
    if any(word in line for word in words):
        flagged_lines.append(line)  # line containing all the specified words. Note: each line ends with \n
        offenders_list.add(line[9:].split(':')[0])  # parses the user who sent the message

for line in lines:
    match = re.search(r"\d{2}:\d{2}:\d{2} Player (.+?) \((\d+)\) connected\.", line)
    if match and any(offender in match.group() for offender in offenders_list):
        name = match.group(1)
        steam_id = match.group(2)
        offenders[name] = steam_id

if os.path.exists(output_file_name):
    print(f"The output file '{output_file_name}' already exists!\nDo you want to overwrite it? y/n")
    choice = input('> ').lower()
    if choice == 'n' or choice == 'no':
        raise FileExistsError(f"{output_file_name} already exists!")

with open(output_file_name, 'w', encoding='utf-8') as offender_file:
    for k, v in offenders.items():
        offender_file.write(f"Steam ID {v}   Name: {k}\n")
    offender_file.write("\nWord Counts:\n")
    print("Word Counts:")
    for word, count in word_counts.items():
        offender_file.write(f"{word}: {count}\n")
        print(f"{word}: {count}")

    offender_file.write("\nFlagged lines:\n")

    for flagged in flagged_lines:
        offender_file.write(flagged)

print(f"Dumped all info in {output_file_name}")
