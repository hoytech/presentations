#!/bin/bash
python -m SimpleHTTPServer 9876 &
sleep 1
curl -I localhost:9876
kill $! # stop web server
