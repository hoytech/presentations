#!/bin/bash
python -m SimpleHTTPServer 9876 &
curl -I localhost:9876
kill $! # stop web server
