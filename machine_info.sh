#!/bin/bash
get_infos(){
    local actual_user="$USER"
    local hostname="$HOSTNAME"
    local user_home_directory="$HOME"
    local working_directory="$PWD"
    local current_date=$(date '+%Y-%m-%d %H:%M:%S')

    printf 'Get Infos : %s\n' "$current_date"
    printf 'actual user : %s\n' $actual_user
    printf 'hostname : %s\n' "$hostname"
    printf 'user home directory : %s\n' "$user_home_directory"
    printf 'working directory : %s\n' "$working_directory"
}

check_path(){
    
}