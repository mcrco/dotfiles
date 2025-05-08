import json
import re


def convert_snip(snippet):
    prefix = snippet[0].split(" ")[1]
    body = [line.replace("\\\\", "\\") for line in snippet[1:-1]]
    return {"prefix": prefix, "body": body}


def convert_snipfile(file):
    with open(file, "r") as f:
        contents = f.readlines()

    contents = [line.strip() for line in contents]
    start_indices = [i for i, line in enumerate(contents) if line.startswith("snippet")]
    end_indices = [
        i for i, line in enumerate(contents) if line.startswith("endsnippet")
    ]

    converted_snippets = [
        contents[start : end + 1] for start, end in zip(start_indices, end_indices)
    ]

    json_snips = {}
    for snippet in converted_snippets:
        if "!p" in snippet[1]:
            continue  # exclude python snippets
        if '"' not in snippet[0]:
            continue
        match = re.search(r'"(.*)"', snippet[0])
        if match:
            name = match.group(1).replace('"', "")
            json_snips[name] = convert_snip(snippet)

    filename = file.replace(".snippets", "")
    with open(f"{filename}.json", "w") as f:
        json.dump(json_snips, f, indent=4)


if __name__ == "__main__":
    import sys

    for file in sys.argv[1:]:
        convert_snipfile(file)
