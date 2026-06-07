import json
from pathlib import Path

from src.constants import DOTFILES_THEMSELF
from src.types import Item
from src.utility import copy_item


def main():
    home = Path.home()
    dest_base = DOTFILES_THEMSELF

    with open("src/files_to_copy.json") as f:
        items: list[Item] = json.load(f)

    for item in items:
        copy_item(item, dest_base, home)


if __name__ == "__main__":
    main()
