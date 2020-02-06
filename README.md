git repo for juypyter services:
* reverse proxy
* notebook
* juptyer hub

## To start a notebook as of 11/25/2019
Login to comet
Have conda installed with all your desired packages installed

Run the following: ./run.sh

Wait until the program echos the url, copy and paste this url into the browser.


Current TODOS:
	1. Currently it just runs the notebook from the directory of run.sh; It should be packaged into a bash command and accept as argument the directory the user wishes to start their jupyter notebook from.
