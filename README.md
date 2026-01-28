BREAKOUT
Classic Breakout game implemented in x86 Assembly Language (16-bit).

Main Menu

Main_Menu.jpg

Gameplay

Gameplay.jpg

Game Over

Game_Over.jpg

Records

Records.jpg

Description
A faithful recreation of the classic Breakout arcade game written entirely in Assembly Language. The game features a paddle, ball physics, destructible blocks, lives system, scoring, and persistent high score tracking.
Technical Details

Language: x86 Assembly (16-bit)
Development Tool: GUI Turbo Assembler 5.1
Video Mode: VGA Mode 13h (320x200, 256 colors)
Platform: DOS

breakout/
├── code.asm          # Main game source code
├── dra2.inc          # Graphics macros library
├── records.txt       # High scores database (auto-generated)
├── Main_Menu.jpg
├── Gameplay.jpg
├── Game_Over.jpg
└── Records.jpg
└── README.md


Features

Main Menu: Title screen with game instructions and options
Gameplay: Classic brick-breaking mechanics with ball physics
Scoring System: Points awarded for destroying blocks
Lives System: Start with 3 lives
Level Progression: Blocks regenerate after clearing all
High Scores: Persistent leaderboard stored in records.txt
Player Names: Enter your name when achieving a high score
Records Screen: View top 15 high scores


## Controls

| Key | Action |
|-----|--------|
| `A` / `Left Arrow` | Move paddle left |
| `D` / `Right Arrow` | Move paddle right |
| `ESC` | Exit to menu / Quit game |
| `ENTER` | Start game from menu |
| `V` | View records |
| `R` | Retry (after game over) |
| `M` | Return to main menu (after game over) |

How to Compile and Run
Using GUI Turbo Assembler 5.1:

Open GUI Turbo Assembler 5.1
Click File > Open and select code.asm
Ensure dra2.inc is in the same directory as code.asm
Click Compile > Compile (or press Alt+F9)
Click Compile > Build (or press F9)
Click Run > Run (or press Ctrl+F9) to execute the game

Note: All compilation and execution is done directly within GUI Turbo Assembler 5.1. No additional DOS tools or emulators required.


git clone https://github.com/yourusername/breakout-asm.git
cd breakout-asm

### Prerequisites:

- **GUI Turbo Assembler 5.1** (includes TASM and TLINK)

That's it! Everything needed is included in GUI Turbo Assembler 5.1.

## Game Rules

1. Use the paddle to bounce the ball and destroy all blocks
2. Each block destroyed awards **10 points**
3. Clearing all blocks awards **100 bonus points** and regenerates the level
4. Missing the ball costs one life
5. Game ends when all lives are lost
6. High scores are automatically saved when you beat the current record

## Block Layout

The game features **28 blocks** arranged in 4 rows:

| Row | Blocks | Color |
|-----|--------|-------|
| 1 | 7 | Yellow (14) |
| 2 | 7 | Light Red (12) |
| 3 | 7 | Blue (9) |
| 4 | 7 | Green (10) |

## Scoring

- **Block destroyed:** 10 points
- **Level cleared:** 100 bonus points
- **Maximum records stored:** 15

## High Score System

High scores are automatically stored in `records.txt` in the format:
00100 - PLAYER1
00090 - PLAYER2
00080 - PLAYER3

Code Structure
Main Components:

Game Loop: BUCLE_JUEGO - Main game execution loop
Physics Engine: ACTUALIZAR_FISICA - Ball movement and collision detection
Input Handler: PROCESAR_INPUT - Keyboard input processing
Rendering: DIBUJAR_ESCENA - Screen drawing routines
Score Manager: High score tracking and file I/O operations

Key Macros (dra2.inc):

DIBUJAR_BLOQUE - Draw rectangular blocks
DIBUJAR_PELOTA - Draw the ball
BORRAR_PELOTA - Erase ball (for smooth movement)
FISICA_PELOTA - Ball physics and boundary collision
DIBUJAR_MARCO - Draw game border

Known Limitations

Requires GUI Turbo Assembler 5.1 environment
Fixed 320x200 resolution
Maximum 15 high scores stored
Player names limited to 15 characters

Troubleshooting
Compilation errors:

Ensure dra2.inc is in the same directory as code.asm
Check that both files are properly saved

Records not saving:

Ensure write permissions in game directory
Check records.txt file integrity

Game not running:

Verify compilation completed successfully
Check for error messages in GUI Turbo Assembler output window

Enjoy breaking blocks!!!
