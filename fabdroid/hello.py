import sys
import time
import traceback
import android

droid = android.Android()

def error_msg(msg):
    return "{}\n{}".format(msg, traceback.format_exc())


droid.makeToast("Trying to import fabric ...")
try:
    import fabric
    droid.makeToast("Fabric import succeeded!")
except:
    droid.makeToast(error_msg("Fabric import failed."))
    time.sleep(3)
    exit()

droid.makeToast("Trying: from fabric.api import local")
try:
    from fabric.api import local
    droid.makeToast("'from fabric.api import local' succeeded!")
except:
    droid.makeToast(error_msg("'from fabric import local' failed."))
    time.sleep(3)
    exit()

droid.makeToast("Trying to run a local command.")
try:
    local("uname -r")
    droid.makeToast("Fabric local command succeeded!")
except:
    droid.makeToast(error_msg("Fabric local command failed."))
    time.sleep(3)
    exit()

time.sleep(3)
