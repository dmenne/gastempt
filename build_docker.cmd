rem docker rm -f gastempt
rem docker build --no-cache --tag dmenne/gastempt .
docker build --tag dmenne/gastempt .
docker run -d -it  --name gastempt  -p 3839:3838 dmenne/gastempt
