#!/bin/bash

score=1

red="\033[31m"
green="\033[32m"
reset="\033[0m"

board_width=12
board_height=12

snake_length=3

snake_x=(10 11 12)
snake_y=(10 10 10)

food_x=1
food_y=1

key=a
last_key=a

function game_over() {
    echo -e "${red}Game Over"
	exit 0
}

function snake_move() {
    for ((i = snake_length - 1; i > 0; i--)); do
        snake_x[i]=${snake_x[i - 1]}
        snake_y[i]=${snake_y[i - 1]}
    done

    read -s -n 1 -t 0.1 new_key
    if [ -n "$new_key" ]; then
        case $new_key in
            w) [[ "$last_key" != "s" ]] && { key=$new_key; last_key=$new_key; } ;;
            s) [[ "$last_key" != "w" ]] && { key=$new_key; last_key=$new_key; } ;;
            a) [[ "$last_key" != "d" ]] && { key=$new_key; last_key=$new_key; } ;;
            d) [[ "$last_key" != "a" ]] && { key=$new_key; last_key=$new_key; } ;;
        esac
    fi

    case $key in
        w) snake_y[0]=$((snake_y[0] - 1)) ;;
        s) snake_y[0]=$((snake_y[0] + 1)) ;;
        a) snake_x[0]=$((snake_x[0] - 1)) ;;
        d) snake_x[0]=$((snake_x[0] + 1)) ;;
    esac

    if [ ${snake_x[0]} -lt 0 ] || 
       [ ${snake_x[0]} -ge $board_width ] || 
       [ ${snake_y[0]} -lt 0 ] || 
       [ ${snake_y[0]} -ge $board_height ]; then
        game_over
    fi

    for ((i = 1; i < snake_length; i++)); do
        if [ ${snake_x[0]} -eq ${snake_x[i]} ] && [ ${snake_y[0]} -eq ${snake_y[i]} ]; then
            game_over
        fi
    done
}

function eat_food() {
	if [ ${snake_x[0]} -eq $food_x ] && [ ${snake_y[0]} -eq $food_y ]; then
		snake_length=$((snake_length + 1))

		snake_x+=(${snake_x[-1]})
		snake_y+=(${snake_y[-1]})

		food_x=$((RANDOM % board_width))
		food_y=$((RANDOM % board_height))

		score=$((score + 1))
	fi
}

function draw_board() {
    clear
    
    for ((y = 0; y < board_height; y++)); do
        for ((x = 0; x < board_width; x++)); do
            is_snake_segment=0

            for ((i = 0; i < snake_length; i++)); do
                if [ ${snake_x[i]} -eq $x ] && [ ${snake_y[i]} -eq $y ]; then
                    if [ $i -eq 0 ]; then
                        echo -en "${green}O${reset} "
                    else
                        echo -en "${green}o${reset} "
                    fi
                    is_snake_segment=1
                    break
                fi
            done
            
            if [ $is_snake_segment -eq 0 ]; then
                if [ $x -eq $food_x ] && [ $y -eq $food_y ]; then
                    echo -en "${red}@${reset} "  
                else
                    echo -en "${reset}.${reset} "  
                fi
            fi
        done
        echo
    done

    echo -e "${green}Score: $score${reset}"
}

function loop() {
	eat_food
    snake_move 
	draw_board
}

function main() {
	echo -ne "\033[?25l"
    trap "echo -ne '\033[?25h'" EXIT

    while true; do
        loop
		sleep 0.05
    done
}
main
