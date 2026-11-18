// Box.asm (K = 08)
// Black box appears while a key is pressed
// Starting row = 8
// Height = 20 rows
// Width = 16 pixels (1 word)

// MAIN LOOP
(MAIN)
    @KBD
    D=M
    @BLACK
    D;JNE

    // No key pressed: white
    @color
    M=0
    @DRAW
    0;JMP

(BLACK)
    // Key pressed: black
    @color
    M=-1

(DRAW)
    // SCREEN + (32 * K)
    // SCREEN + 256 for K = 8
    @SCREEN
    D=A
    @256
    D=D+A
    @addr
    M=D

    // Box height = 20 rows
    @20
    D=A
    @rows
    M=D

(ROWLOOP)
    @addr
    D=M
    @ptr
    M=D

    // Width = 1 word = 16 pixels
    @1
    D=A
    @cols
    M=D

(COLLOOP)
    @color
    D=M
    @ptr
    A=M
    M=D

    @ptr
    M=M+1

    @cols
    M=M-1
    D=M
    @COLLOOP
    D;JGT

    // Move to next screen row
    @32
    D=A
    @addr
    M=D+M

    @rows
    M=M-1
    D=M
    @ROWLOOP
    D;JGT

    @MAIN
    0;JMP