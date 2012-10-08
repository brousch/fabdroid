import time
import android

droid = android.Android()

droid.makeToast("Trying to import fabric ...")
try:
    import fabric
    droid.makeToast("Fabric import succeeded!")
except:
    droid.makeToast("Fabric import failed.")

time.sleep(5)
