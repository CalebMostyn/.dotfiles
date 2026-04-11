#!/usr/bin/env python3

import subprocess

def read_file(path):
    with open(path, 'r') as file:
        return file.read()

def package_exists(package, packages):
    return package in packages 

def to_list(string):
    return list(filter(None, string.split('\n')))

# remove entries in a that are in b
def remove_duplicates(a, b):
    for val in b:
        if val in a:
            a.remove(val)

# commented lines indicate category
def get_category_map(packages):
    categories = dict()
    last_category = ''
    for package in packages:
        if package.startswith('#'):
            category = (package[1:].strip())
            categories[category] = []
            last_category = category
        else:
            categories[last_category].append(package)
    remove_duplicates(packages, ['# ' + key for key in list(categories.keys())])
    return categories

# prompt for category
def get_package_category(package, map, package_manager, sudo=False):
    categories = list(map.keys())
    print(f'category for package {package}')
    for ii in range(len(categories)):
        print(f'{ii}: {categories[ii]}')
    category = ''
    skip = False
    while not category:
        usr_in = input('enter index, a to add new category, n to omit, or r to remove: ')
        if usr_in == 'a':
            category = input('name of new category?: ')
            map[category] = []
        elif usr_in == 'n':
            skip = True
            break
        elif usr_in == 'r':
            if input('are you sure? [y/N]: ') == 'y':
                cmd = [package_manager, '-R', package]
                if sudo:
                    cmd.insert(0, 'sudo')
                print(' '.join(cmd))
                subprocess.run(cmd)
                skip = True
                break
        else:
            try:
                index = int(usr_in)
                category = categories[index]
            except:
                print('invalid input')

    if not skip:
        map[category].append(package)

def to_remove(package):
    usr_in = ''
    while usr_in != 'y' and usr_in != 'n':
        usr_in = input(f'{package} was removed, remove from conf? (y/n): ')
    return usr_in == 'y'

def write_to_file(map, path):
    with open(path, 'w') as file:
        for category, packages in map.items():
            file.write(f'# {category}\n')
            for package in sorted(packages):
                file.write(f'{package}\n')
            file.write('\n')

# get current packages on machine
curr_packages = subprocess.run(["pacman", "-Qqe"], capture_output=True, text=True).stdout
curr_packages = to_list(curr_packages)
curr_aur_packages = subprocess.run(["pacman", "-Qqm"], capture_output=True, text=True).stdout
curr_aur_packages = to_list(curr_aur_packages)

# -Qe includes aur packages, remove them
remove_duplicates(curr_packages, curr_aur_packages)
# filter out yay itself
remove_duplicates(curr_aur_packages, ['yay', 'yay-debug'])

prev_packages = to_list(read_file('packages.conf'))
prev_aur_packages = to_list(read_file('packages-aur.conf'))

categories = get_category_map(prev_packages)
aur_categories = get_category_map(prev_aur_packages)

# remove deleted packages from conf
for _, packages in categories.items():
    removed = []
    for package in packages:
        if not package_exists(package, curr_packages):
            if to_remove(package):
                removed.append(package)
    remove_duplicates(packages, removed)

for _, packages in aur_categories.items():
    removed = []
    for package in packages:
        if not package_exists(package, curr_aur_packages):
            if to_remove(package):
                removed.append(package)
    remove_duplicates(packages, removed)

# sort new packages based on user selection
for package in curr_packages:
    if not package_exists(package, prev_packages):
        get_package_category(package, categories, 'pacman', True)

for package in curr_aur_packages:
    if not package_exists(package, prev_aur_packages):
        get_package_category(package, aur_categories, 'yay')

# write new changes
write_to_file(categories, 'packages.conf')
write_to_file(aur_categories, 'packages-aur.conf')
