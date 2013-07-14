@echo off
start /min launch_server
start /min launch_console
:poll_loop
pause "Press any key to poll the messaging queue..."
start /min poll
::goto poll_loop

