docker rm -f gastempt
docker build --no-cache --tag dmenne/gastempt .
rem build --tag dmenne/gastempt .
docker run -d -it  --name gastempt  -p 3839:3838 dmenne/gastempt
