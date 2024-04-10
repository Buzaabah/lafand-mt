import csv
import json


def tsv_to_json(tsv_filepath, json_filepath):
    # Read the .tsv file
    with open(tsv_filepath, 'r') as tsvfile:
        # csv.DictReader can read tsv with the delimiter parameter set to '\t'
        reader = csv.DictReader(tsvfile, delimiter='\t')

        # Convert to list to keep all dictionaries
        data = list(reader)

    # Write the JSON output file
    with open(json_filepath, 'w') as jsonfile:
        json.dump(data, jsonfile, indent=4)


# Example usage
tsv_filepath = 'data/Test.tsv'  # This should be the path to your .tsv file
json_filepath = 'data/Test.json'  # This will be the new .json file's path

if __name__ == "__main__":
    tsv_to_json(tsv_filepath, json_filepath)
