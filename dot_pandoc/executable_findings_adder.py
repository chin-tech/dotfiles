#!/usr/bin/env python3
import sys
from pathlib import Path
from collections import defaultdict
import re

# Global dictionary of domains and their counts
domains = defaultdict(lambda: {
    "low": 0,
    "medium": 0,
    "high": 0,
    "critical": 0
})


# ---------------------------------------------------------------------------
# Extract severity from CVSS text line
# Example line: "CVSS 8.2 (High) CVSS:3.1/AV:N/AC:L/PR:N/UI:R/S:C/C:H/I:L/A:N"
# ---------------------------------------------------------------------------
def check_cvss(text: str) -> str:
    m = re.search(r"CVSS\s+([0-9.]+)", text)
    if not m:
        return "low"  # default fallback
    score = float(m.group(1))
    match score:
        case s if s <= 3.9:
            return "low"
        case s if s <= 6.9:
            return "medium"
        case s if s <= 8.9:
            return "high"
        case _:
            return "critical"


# ---------------------------------------------------------------------------
# Parse markdown file for headings and CVSS scores
# ---------------------------------------------------------------------------
def findings_parser(file: Path):
    curr_domain = None

    with open(file, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()

            # Detect a domain header (### domain.name)
            if line.startswith("### "):
                curr_domain = line.removeprefix("### ").strip()
                print(f"[+] Found domain: {curr_domain}")

            # Detect CVSS lines
            elif line.startswith("CVSS"):
                if not curr_domain:
                    print("[-] CVSS line without domain header, skipping:", line)
                    continue
                severity = check_cvss(line)
                domains[curr_domain][severity] += 1
                print(f"  → {curr_domain}: {severity} +1")


# ---------------------------------------------------------------------------
# Insert data into the file after "Assessment Summary"
# ---------------------------------------------------------------------------
def add_to_file(file: Path):
    with open(file, "r", encoding="utf-8") as f:
        lines = f.readlines()

    # Find insertion point
    goal_index = -1
    for i, line in enumerate(lines):
        if "Assessment Summary" in line:
            goal_index = i + 3  # your offset
            break

    if goal_index == -1:
        print("[-] Could not find 'Assessment Summary' line in file.")
        return

    # Generate text to insert
    insert_text = get_good_str()

    # Rebuild file with inserted text
    new_lines = lines[:goal_index] + [insert_text + "\n"] + lines[goal_index:]

    with open(file, "w", encoding="utf-8") as f:
        f.writelines(new_lines)

    print(f"[+] Added data after line {goal_index}.")


# ---------------------------------------------------------------------------
# Create summary string to insert into file
# ---------------------------------------------------------------------------
def get_good_str() -> str:
    add_string = "CVSS_SUMMARY|"
    for k, v in domains.items():
        add_string += (
            f"{k.strip()} {v['low']}  {v['medium']}  {v['high']} {v['critical']} | "
        )
    return add_string


# ---------------------------------------------------------------------------
# Main entrypoint
# ---------------------------------------------------------------------------
def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <markdown_file>")
        sys.exit(1)

    file = Path(sys.argv[1])
    if not file.exists():
        print(f"[-] File does not exist: {file}")
        sys.exit(1)

    findings_parser(file)

    print("\n=== Domain Summary ===")
    for k, v in domains.items():
        print(f"{k:30} L:{v['low']} M:{v['medium']} H:{v['high']} C:{v['critical']}")

    add_to_file(file)
    print("[+] Done.")


if __name__ == "__main__":
    main()
