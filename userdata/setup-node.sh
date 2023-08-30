#!/bin/bash
#Description: Install Nodejs & Start it on port 3000
#Author: Girish Poonith
#Version: 1.0

# INSTALL NODEJS
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "Node.js installed."

# Create a simple Node.js application
echo "Creating a simple Node.js application..."
echo "const http = require('http');

const server = http.createServer((req, res) => {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, Node.js!');
});

server.listen(3000, '0.0.0.0', () => {
    console.log('Server running at http://0.0.0.0:3000/');
});
" > app.js

# Install required npm packages
npm install http

# Start the Node.js application
node app.js
