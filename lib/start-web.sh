
# Breakdown of the Command
# nohup: Prevents the process from being terminated when the terminal session ends 
# (hangs up).
# python3: Invokes the Python 3 interpreter.
# -u: Forces standard input, output, and error streams to be unbuffered. This 
# ensures that output (e.g., error messages) appears in the log file immediately 
# rather than being buffered.
# -m http.server: Runs the built-in simple HTTP server module as a script.
# 8000: Specifies the port number the server will listen on (you can use any 
# available port).
# > server.log: Redirects standard output to a file named server.log.
# 2>&1: Redirects standard error to where standard output is going (the server.
# log file). This captures all output in a single log file.
# &: Runs the command in the background, allowing you to use your terminal 
# immediately. 
# Managing the Server
# Once the command is executed, the server will be running in the background. 
# Check the status/output: You can view the server's output and activity by 
# viewing the server.log file using a command like tail -f server.log.
# Find the process ID (PID): To manage (e.g., stop) the server, you need its 
# process ID. Use the ps aux | grep http.server command.
# Stop the server: Once you have the PID (let's say it's 12345), you can terminate 
# the process using the kill command: kill 12345. 
# Note: The built-in http.server is intended for development and local testing only. It has limited security and performance and should not be used in a production environment. 


nohup python3 -u -m http.server 8000 > server.log 2>&1 &