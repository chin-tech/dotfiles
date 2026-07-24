#!/usr/bin/env python

import json
import re
import argparse
import zipfile


def load_file(bh_file: str) -> dict:
    with open(bh_file, 'r') as f:
        return json.load(f)


# groups = load_file("./20250801110257_certificate-htb_groups.json")
# users = load_file("./20250801110257_certificate-htb_users.json")

def get_sid_names(users_dict) -> dict:
    sid_to_names = {}
    for item in users_dict['data']:
        sid = item['ObjectIdentifier']
        name = item['Properties']['name']
        sid_to_names[sid]=name
    return sid_to_names

def get_unique_groups(group_dict: dict, name_map: dict) -> list[dict]:
    groups = []
    for item in group_dict['data']:
        members = item['Members']
        if len(members) < 1:
            continue
        mems = []
        for member in members:
            if member['ObjectType'] != 'User':
                continue
            mems.append(name_map[member['ObjectIdentifier']])
        name = item['Properties']['name']
        if not mems:
            continue
        groups.append({name:mems})
    return groups

def print_groups(groups: dict[str, list]) :
    for dik in groups:
        for k,v in dik.items():
            print(k)
            for member in v:
                mem = re.sub(r'@.*', '', member)
                print(f"  - {mem}")
            print()


def load_from_zip(zip_path: str) -> tuple[dict,dict]:
    user_data, group_data = {} ,{}
    with zipfile.ZipFile(zip_path, 'r') as bh_zip:
        file_list = bh_zip.namelist()
        users_file = None
        groups_file = None
        for name in file_list:
            if name.endswith('_users.json'):
                users_file = name
            if name.endswith('_groups.json'):
                groups_file = name
        if not users_file or not groups_file:
            raise FileNotFoundError('Missing either _users or _groups .json')
        user_content = bh_zip.read(users_file).decode('utf-8')
        groups_content = bh_zip.read(groups_file).decode('utf-8')
        users_data = json.loads(user_content)
        group_data = json.loads(groups_content)
    return users_data, group_data





# name_map = get_sid_names(users)
# group_mems = get_unique_groups(groups, name_map)
# print_groups(group_mems)



def main():
    parser = argparse.ArgumentParser(description="Parse Bloodhound JSON files to list groups and members")
    groups_json = parser.add_mutually_exclusive_group(required=True)
    groups_json.add_argument("-z", "--zip-file", help="Path to bloodhound zip")
    groups_json.add_argument("-f", "--files", nargs=2, metavar=("users_file.json","groups_file.json" ), help="Paths to individual users.json and groups.json")
    args = parser.parse_args()

    if args.zip_file:
        users_json, groups_json = load_from_zip(args.zip_file)
    else:
        users_json = load_file(args.files[0])
        groups_json = load_file(args.files[1])
    name_map = get_sid_names(users_json)
    grp_members = get_unique_groups(groups_json, name_map)
    print_groups(grp_members)
        
# print_groups(get_unique_groups(groups, name_map))

if __name__ == '__main__':
    main()
