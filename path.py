# ---
# jupyter:
#   jupytext:
#     text_representation:
#       extension: .py
#       format_name: light
#       format_version: '1.5'
#       jupytext_version: 1.13.8
#   kernelspec:
#     display_name: 'Python 3.10.4 (''.venv'': venv)'
#     language: python
#     name: python3
# ---

# This demo imports custom Python package: `package`. Please **install** it first:
#
# ```bash
# pip install -r requirements.txt     # add --user if you are not using virtual environment
# ```

from package.tree import DisplayablePath

# ### Print directory `package/`

DisplayablePath.print_tree()


