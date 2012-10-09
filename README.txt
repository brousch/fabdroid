This is a small project to get Fabric running on Android via the 
android-python27 project.

To use it:
  $ git clone https://github.com/brousch/fabdroid.git
  $ cd fabdroid
  $ make install
  $ make generate_my_python_project.zip
  Copy my_python_project.zip into the res/raw directory of an android-python27 
    template
  Run the program as an Android project via the template

To run it on your Linux or OSX computer:
  $ git clone https://github.com/brousch/fabdroid.git
  $ cd fabdroid
  $ make install
  $ source venv/bin/activate
  $ python fabdroid/hello.py

The program currently fails on line 32 of fabric/network.py. This line is 
trying to import ssh. I'm not sure why it's failing yet.

android-python27: http://code.google.com/p/android-python27/
