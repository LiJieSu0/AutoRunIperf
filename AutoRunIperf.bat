@echo off

if "%~3"=="" (
    echo Please provide three arguments: downloadPort uploadPort iteration_times
    exit /b 1
)

set "DURATION=30"  REM Default duration is 30 seconds
if "%~4"=="-t" (
    if "%~5"=="" (
        echo Error: A test duration must be provided after the "-t" flag.
        exit /b 1
    )
    set "DURATION=%~5"
)

if "%~6"=="" (
    echo Address argument is not provided, default iperf address is "mnblp1.speed.vzwnet.com"
    set "ADDRESS=mnblp1.speed.vzwnet.com"
) else (
    set "ADDRESS=%~6"
)

REM Define the number of iterations
set "ITERATIONS=%3"

echo %1 Download Port
echo %2 Upload Port
echo You set %3 round.

REM Loop to run the iperf3 commands multiple times
for /l %%i in (1, 1, %ITERATIONS%) do (
    echo iperf round %%i is running...
    REM Run the first iperf3 command and save the output to a text file
    start /b cmd /c iperf3.exe -c %ADDRESS% -t %DURATION% -i 1 -p %1 -R > Iperf_DL_%1_Round_%%i.txt 2>&1

    REM Run the second iperf3 command and save the output to a text file
    start /b cmd /c iperf3.exe -c %ADDRESS% -t %DURATION% -i 1 -p %2 > Iperf_UL_%2_Round_%%i.txt 2>&1

    REM Wait for both iperf3 commands to finish
    timeout /t %DURATION% /nobreak > nul

    REM Wait for 5 seconds before starting the next iteration
    timeout /t 5 /nobreak > nul
)

REM Pause to keep the console window open after all iterations are completed
echo iperf is finished
echo If you see the file is empty, wait for the system output. It depends on the file size you want to output.
pause

REM iperf3.exe -c fiosspeed3.west.verizon.net -t 30 -i 1 -p 5201 -R