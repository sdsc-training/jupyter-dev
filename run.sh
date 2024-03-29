#!/bin/bash
sbatch start_notebook.sh > tmp.txt
JOB_ID=$(<tmp.txt) # get the sbatch job id so we can read the slurm output
JOB_ID=${JOB_ID#*"Submitted batch job "}
echo $JOB_ID
while [ ! -f slurm-"$JOB_ID".out ]
do
  echo "Waiting for batch job"
  sleep 0.2
  clear
done

URL=$(grep "Your notebook is here: " slurm-"$JOB_ID".out) # get the base url

JUPYTER_TOKEN=$(cat slurm-"$JOB_ID".out) # grab the output of the jupyter command to get the jupyter token
JUPYTER_TOKEN=${JUPYTER_TOKEN#*"?token="} # get the token on its own
JUPYTER_TOKEN=$(echo $JUPYTER_TOKEN | cut -d ' ' -f 1) # get the token on its own

URL="$URL?token=$JUPYTER_TOKEN" # build the base url with the jupyter token
echo $URL # print it to the screen so the user can easily copy and paste
rm tmp.txt 
