# KDE

Simplest way I've found to store the plethora of complex KDE dotfiles is a python program called `konsave`.

`konsave` provides an interface to save your KDE config, manage different profiles, as well as import and export them.

I have saved a binary export here of my KDE config using such:
```bash
source kde/venv/bin/activate
pip install konsave
# save profile
konsave -s caleb
# export to kde folder, force to overwrite existing file
konsave -e caleb -d kde -f
```
