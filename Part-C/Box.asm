
(MAIN_LOOP)
    // 1. Check keyboard status
    @KBD
    D=M
    @KEY_PRESSED
    D;JNE

    // 2. No key pressed -> set color to white (0)
    @color
    M=0
    @START_DRAW
    0;JMP

(KEY_PRESSED)
    // 3. Key pressed -> set color to black (-1 = 0xFFFF)
    @color
    M=-1

(START_DRAW)
    // 4. Initialize height counter: 20 rows
    @20
    D=A
    @row_count
    M=D

    // 5. Initialize start row address: SCREEN + 32 * 69 = 20800
    @20800
    D=A
    @row_addr
    M=D

(ROW_LOOP)
    // Fetch color to D register
    @color
    D=M

    // Word 0 of current row (pixels 0..15)
    @row_addr
    A=M
    M=D

    // Word 1 of current row (pixels 16..31)
    @row_addr
    A=M+1
    M=D

    // Word 2 of current row (pixels 32..47)
    @row_addr
    A=M+1
    A=A+1
    M=D

    // Advance to next row: row_addr = row_addr + 32
    @32
    D=A
    @row_addr
    M=M+D

    // Decrement row counter and loop if > 0
    @row_count
    MD=M-1
    @ROW_LOOP
    D;JGT

    // Return to main loop to continuously check keyboard
    @MAIN_LOOP
    0;JMP
