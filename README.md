# AutoRunIperf
Run download and upload iperf3 simultaneously
1. Put this file under your iperf.exe directory.
2. Run CMD under the same directory.
3. "YOUR DIRECTORY">AutoRunIperf.bat %Download_port% %Upload_port% %Iteration_times% %iperf_address(optional)%
     //It takes 4 arguments as input, the 4th argument is optional.
     //Ex:> AutoRunIperf.bat 5203 5204 10 "The address you want".
     //This line run iperf3 command using 5203 as download port and 5204 upload port 10 times.
4. It will output the result under your iperf3 directory.
