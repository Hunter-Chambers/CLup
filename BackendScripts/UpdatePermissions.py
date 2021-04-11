#!/usr/bin/env python3

import os


_777_directories = ["CustomerFavorites", "Schedule", "StoreSearch"]
_755_directories = ["cronjobs", "pythonScripts"]

for root, dNames, fNames in os.walk(os.getcwd()):
    d = root.split("/")[-1]

    if (d in _777_directories):
        os.chmod(root, 0o777)
    elif(d in _755_directories):
        os.chmod(root, 0o755)
    # end if

    for f in fNames:
        filePath = root + "/" + f

        if (".p" in f):
            os.chmod(filePath, 0o744)
        elif (".json" in f or ".txt" in f):
            os.chmod(filePath, 0o666)
        # end if
    # end for
# end for
