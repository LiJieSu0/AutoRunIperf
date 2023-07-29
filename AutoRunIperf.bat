@echo off

if "%~3"=="" (
    echo Please provide three arguments: downloadPort uploadPort iteration_times
    exit /b 1
)

if "%~4"=="" (
    echo Argument 4 is not provided, default iperf address is "mnblp1.speed.vzwnet.com"
    set "ADDRESS=mnblp1.speed.vzwnet.com"
) else (
    set "ADDRESS=%~4"
)

REM Define the number of iterations
set "ITERATIONS=%3"

echo %1 Download Port
echo %2 Upload Port

REM Loop to run the iperf3 commands multiple times
for /l %%i in (1, 1, %ITERATIONS%) do (
    echo iperf %%i round is running...
    REM Run the first iperf3 command and save the output to a text file
    start /b cmd /c iperf3.exe -c %ADDRESS% -t 30 -i 1 -p %1 -R > result_DL_%1_%%i.txt 2>&1

    REM Run the second iperf3 command and save the output to a text file
    start /b cmd /c iperf3.exe -c %ADDRESS% -t 30 -i 1 -p %2 > result_UL_%2_%%i.txt 2>&1

    REM Wait for both iperf3 commands to finish
    timeout /t 30 /nobreak > nul

    REM Wait for 5 seconds before starting the next iteration
    timeout /t 5 /nobreak > nul
)

REM Pause to keep the console window open after all iterations are completed
echo iperf is finished
pause

REM iperf3.exe -c fiosspeed3.west.verizon.net -t 30 -i 1 -p 5201 -R