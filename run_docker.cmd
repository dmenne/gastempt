docker rm -f gastempt
docker run -d -it  --name gastempt  -p 3839:3838 dmenne/gastempt
