#!/bin/bash

												
ping_mariadb_container() {						# Function to ping the MariaDB container
    nc -zv mariadb 3306 > /dev/null         	# ping the mariadb container
    return $?                               	# return the exit status of the ping command
}

wait_for_mariadb() {
    start_time=$(date +%s)                      # get the current time in seconds
    end_time=$((start_time + 20))               # set the end time to 20 seconds after the start time
    while [ $(date +%s) -lt $end_time ]; do     # loop until the current time is greater than the end time
        ping_mariadb_container                  # Ping the MariaDB container
        if [ $? -eq 0 ]; then                   # Check if the ping was successful
            echo "[========MARIADB IS UP AND RUNNING========]"
            break                               # Exit the loop if MariaDB is up
        else
            echo "[========WAITING FOR MARIADB TO START...========]"
            sleep 1                             # Wait for 1 second before trying again
        fi
    done

    if [ $(date +%s) -ge $end_time ]; then      # check if the current time is greater than or equal to the end time
        echo "[========MARIADB IS NOT RESPONDING========]"
    fi
}
