#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH -p compute
#SBATCH -t 00:30:00
#SBATCH --wait 0

# Find an unused port
MIN_PORT=8000
MAX_PORT=32768
PORT=$MIN_PORT
for ((port=$MIN_PORT; port<=$MAX_PORT;port++))
do
	PORT=$port
	(echo >/dev/tcp/127.0.0.1/$port)> /dev/null 2>&1 && break
done

# get the token
tokenResponse=$(curl https://manage.comet-user-content.sdsc.edu/getlink.cgi)
token=${tokenResponse#*"Your token is "} # strips the token out of the response
token=$(echo "$token" | tr '\n' ' ') # removes the newline char
token=$(echo "$token" | xargs) # remove extra spaces before or after

# redeem the token given the untaken port
url='"https://manage.comet-user-content.sdsc.edu/redeemtoken.cgi?token=$token&port=$PORT"'

# Redeem the token
eval curl $url

# Give the user the start of their url
echo Your notebook is here: https://"$token".comet-user-content.sdsc.edu

# Get the comet node's IP
IP="$(hostname -s).local"
jupyter notebook --ip $IP --port $PORT

