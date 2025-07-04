#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <unistd.h>
#include <termios.h>
#include <fcntl.h>

#define BOARD_WIDTH 12
#define BOARD_HEIGHT 12
#define INITIAL_LENGTH 3

#define RED "\033[31m"
#define GREEN "\033[32m"
#define RESET "\033[0m"

typedef struct {
    int x;
    int y;
} Position;

int score = 1;
int snake_length = INITIAL_LENGTH;
Position snake[BOARD_WIDTH * BOARD_HEIGHT];
Position food;
char direction = 'a';
char last_direction = 'a';

bool game_over = false;

void disable_input_buffering() {
    struct termios t;
    tcgetattr(STDIN_FILENO, &t);
    t.c_lflag &= ~(ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &t);
    fcntl(STDIN_FILENO, F_SETFL, fcntl(STDIN_FILENO, F_GETFL) | O_NONBLOCK);
}

void restore_input_buffering() {
    struct termios t;
    tcgetattr(STDIN_FILENO, &t);
    t.c_lflag |= (ICANON | ECHO);
    tcsetattr(STDIN_FILENO, TCSANOW, &t);
}

void handle_game_over() {
    printf(RED "Game Over! Final Score: %d\n" RESET, score);
    game_over = true;
}

void move_snake() {
    for (int i = snake_length - 1; i > 0; i--) {
        snake[i] = snake[i-1];
    }
    
    switch (direction) {
        case 'w': snake[0].y--; break;
        case 's': snake[0].y++; break;
        case 'a': snake[0].x--; break;
        case 'd': snake[0].x++; break;
    }
    
    if (snake[0].x < 0 || snake[0].x >= BOARD_WIDTH || 
        snake[0].y < 0 || snake[0].y >= BOARD_HEIGHT) {
        handle_game_over();
        return;
    }
    
    for (int i = 1; i < snake_length; i++) {
        if (snake[0].x == snake[i].x && snake[0].y == snake[i].y) {
            handle_game_over();
            return;
        }
    }
}

void check_food() {
    if (snake[0].x == food.x && snake[0].y == food.y) {
        snake[snake_length] = snake[snake_length-1];
        snake_length++;
        score++;
        
        bool valid_position;
        do {
            valid_position = true;
            food.x = rand() % BOARD_WIDTH;
            food.y = rand() % BOARD_HEIGHT;
            
            for (int i = 0; i < snake_length; i++) {
                if (food.x == snake[i].x && food.y == snake[i].y) {
                    valid_position = false;
                    break;
                }
            }
        } while (!valid_position);
    }
}

void draw_board() {
    system("clear");
    
    for (int y = 0; y < BOARD_HEIGHT; y++) {
        for (int x = 0; x < BOARD_WIDTH; x++) {
            bool is_snake = false;
            
            for (int i = 0; i < snake_length; i++) {
                if (snake[i].x == x && snake[i].y == y) {
                    if (i == 0) {
                        printf(GREEN "O" RESET " ");
                    } else {
                        printf(GREEN "o" RESET " ");
                    }
                    is_snake = true;
                    break;
                }
            }
            
            if (!is_snake) {
                if (food.x == x && food.y == y) {
                    printf(RED "@" RESET " ");
                } else {
                    printf(". ");
                }
            }
        }
        printf("\n");
    }
    
    printf(GREEN "Score: %d\n" RESET, score);
}

void process_input() {
    char input;
    if (read(STDIN_FILENO, &input, 1) > 0) {
        switch (input) {
            case 'w': 
                if (last_direction != 's') {
                    direction = input;
                    last_direction = input;
                }
                break;
            case 's': 
                if (last_direction != 'w') {
                    direction = input;
                    last_direction = input;
                }
                break;
            case 'a': 
                if (last_direction != 'd') {
                    direction = input;
                    last_direction = input;
                }
                break;
            case 'd': 
                if (last_direction != 'a') {
                    direction = input;
                    last_direction = input;
                }
                break;
        }
    }
}

void initialize_game() {
    for (int i = 0; i < INITIAL_LENGTH; i++) {
        snake[i].x = BOARD_WIDTH / 2 + i;
        snake[i].y = BOARD_HEIGHT / 2;
    }
    
    food.x = rand() % BOARD_WIDTH;
    food.y = rand() % BOARD_HEIGHT;
    
    printf("\033[?25l");
}

void cleanup() {
    restore_input_buffering();
    printf("\033[?25h");
}

int main() {
    srand(time(NULL));
    initialize_game();
    disable_input_buffering();
    atexit(cleanup);
    
    while (!game_over) {
        process_input();
        check_food();
        move_snake();
        if (game_over) break;
        draw_board();
        usleep(150000);
    }
}
