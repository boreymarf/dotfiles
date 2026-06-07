from pathlib import Path
import shutil

from src.types import Item


def expand_path(p: str) -> Path:
    return Path(p).expanduser().resolve()


def get_dest(src: Path, base: Path, home: Path) -> Path:
    rel = src.relative_to(home)
    return base / rel


def copy_file(src: Path, dest: Path) -> None:
    dest.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dest)


def copy_dir(src: Path, dest: Path, ignore: str | None = None) -> None:
    dest.mkdir(parents=True, exist_ok=True)
    ignore_func = shutil.ignore_patterns(ignore) if ignore else None
    shutil.copytree(src, dest, ignore=ignore_func, dirs_exist_ok=True)


def copy_item(item: Item, dest_base: Path, home: Path) -> None:
    if isinstance(item, str):
        src = expand_path(item)
        ignore = None
    else:
        src = expand_path(item["path"])
        ignore = item.get("ignore")

    dest = get_dest(src, dest_base, home)

    if src.is_dir():
        copy_dir(src, dest, ignore)
    else:
        copy_file(src, dest)
