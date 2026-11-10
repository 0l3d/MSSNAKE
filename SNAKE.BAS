DECLARE SUB DrawFood (posx AS INTEGER, posy AS INTEGER)
DECLARE SUB DrawScore ()
DECLARE SUB GoSnakeGo (SnakeX() AS INTEGER, SnakeY() AS INTEGER, length AS INTEGER, direction AS INTEGER, speed AS INTEGER, lastpos AS INTEGER)
DECLARE SUB DeleteTail (posx AS INTEGER, posy AS INTEGER)
DECLARE SUB DrawSnake (X() AS INTEGER, Y() AS INTEGER, length AS INTEGER)
DECLARE SUB DrawBlock (positionx AS INTEGER, positiony AS INTEGER, colorblock AS INTEGER)
SCREEN 12
RANDOMIZE TIMER
' GAME START
' Written BY 0L3D
' IN MS-DOS
' USED QBASIC DEFAULT EDITOR (QBASIC.EXE)
' RUN:              
' QBASIC.EXE /RUN SNAKE.BAS

' SNAKE VARIABLES
snakedirection% = 1
score% = 0
snakespeed% = 5
snakelen% = 4
snakecurrent% = 1
grow% = 0
CONST MaxLen = 40
DIM SnakeX(MaxLen) AS INTEGER
DIM SnakeY(MaxLen) AS INTEGER
SnakeX(1) = 7: SnakeY(1) = 10
SnakeX(2) = 12: SnakeY(2) = 10
SnakeX(3) = 17: SnakeY(3) = 10
SnakeX(4) = 22: SnakeY(4) = 10
' ======================
' ONLY 1 FOOD
foodx% = 102
foody% = 100
' ================
' DrawSnake snakedirection%, snakex%, snakey%, snakesize%
' ClearSnake snakedirection%, snakex%, snakey%, snakesize%
' DrawFood 10, 10

DrawScore
DrawFood foodx%, foody%

WHILE 1
    key$ = INKEY$
    IF key$ = CHR$(27) THEN SYSTEM
    IF key$ = "w" AND snakedirection% <> 1 THEN snakedirection% = 0
    IF key$ = "s" AND snakedirection% <> 0 THEN snakedirection% = 1
    IF key$ = "a" AND snakedirection% <> 3 THEN snakedirection% = 2
    IF key$ = "d" AND snakedirection% <> 2 THEN snakedirection% = 3
    IF grow% = 1 THEN
        FOR i = snakelen% TO snakecurrent% STEP -1
                SnakeX(i + 1) = SnakeX(i)
                SnakeY(i + 1) = SnakeY(i)
        NEXT i
        snakelen% = snakelen% + 1
        grow% = 0
    END IF

    GoSnakeGo SnakeX(), SnakeY(), snakelen%, snakedirection%, snakespeed%, snakecurrent%
    IF SnakeX(snakecurrent%) < 0 OR SnakeX(snakecurrent%) > 635 OR SnakeY(snakecurrent%) < 0 OR SnakeY(snakecurrent%) > 475 THEN
        LOCATE 15, 33
        PRINT "Game Over!"
        LOCATE 16, 33
        PRINT "Score: "; score%
        LOCATE 18, 25
        PRINT "Press enter to continue";
        SLEEP
        SYSTEM
    END IF

    IF SnakeX(snakecurrent%) = foodx% AND SnakeY(snakecurrent%) = foody% THEN
        score% = score% + 1

        IF snakelen% < MaxLen THEN grow% = 1
        foodx% = INT(RND * 115) * 5 + 2
        foody% = INT(RND * 90) * 5

        DrawFood foodx%, foody%
        DrawScore
    END IF
    DrawSnake SnakeX(), SnakeY(), snakelen%

    snakecurrent% = snakecurrent% + 1
    IF snakecurrent% > snakelen% THEN
        snakecurrent% = 1
    END IF

    startTime! = TIMER
    WHILE TIMER - startTime! < .1
    WEND
WEND

SUB DeleteTail (posx AS INTEGER, posy AS INTEGER)
        DrawBlock posx, posy, 0
END SUB

SUB DrawBlock (positionx AS INTEGER, positiony AS INTEGER, colorblock AS INTEGER)
        LINE (positionx, positiony)-(positionx + 4, positiony + 4), colorblock, BF
END SUB

SUB DrawFood (posx AS INTEGER, posy AS INTEGER)
        DrawBlock posx, posy, 4
END SUB

SUB DrawScore
        SHARED score%
        LOCATE 30, 1
        PRINT "Score: "; score%; "   ";
END SUB

SUB DrawSnake (X() AS INTEGER, Y() AS INTEGER, length AS INTEGER)
        FOR i = 1 TO length
              DrawBlock X(i), Y(i), 2
        NEXT i
END SUB

SUB GoSnakeGo (SnakeX() AS INTEGER, SnakeY() AS INTEGER, length AS INTEGER, direction AS INTEGER, speed AS INTEGER, lastpos AS INTEGER)
        DeleteTail SnakeX(lastpos), SnakeY(lastpos)
        DIM prevpos AS INTEGER
        prevpos = lastpos - 1
        IF prevpos < 1 THEN prevpos = length

        IF direction% = 0 THEN
                SnakeX(lastpos) = SnakeX(prevpos)
                SnakeY(lastpos) = SnakeY(prevpos) - speed
        ELSEIF direction% = 1 THEN
                SnakeX(lastpos) = SnakeX(prevpos)
                SnakeY(lastpos) = SnakeY(prevpos) + speed
        ELSEIF direction% = 2 THEN
                SnakeX(lastpos) = SnakeX(prevpos) - speed
                SnakeY(lastpos) = SnakeY(prevpos)
        ELSEIF direction% = 3 THEN
                SnakeX(lastpos) = SnakeX(prevpos) + speed
                SnakeY(lastpos) = SnakeY(prevpos)
        END IF
END SUB

