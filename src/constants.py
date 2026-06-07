import os
from pathlib import Path
import sys

HOME = Path(os.path.expanduser("~"))
DOTFILES_THEMSELF = Path(sys.argv[0]).parent / "dotfiles_themself"
