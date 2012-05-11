@echo off
:loop
choice /C y /D y /T 30
call rake messaging:poll_pending_evaluations
goto loop
