echo -e 'normal'
echo -e '\e[2mdim\e[22m'
echo -e '\e[3mitalic\e[23m'
echo -e '\e[1;3mbold italic\e[22;23m'
echo -e '\e[1mbold\e[22m'
echo -e '\e[4munderline\e[24m'
echo -e '\e[4:1mthis is also underline (new in 0.52)\e[4:0m'
echo -e '\e[21mdouble underline (new in 0.52)\e[24m'
echo -e '\e[4:2mthis is also double underline (new in 0.52)\e[4:0m'
echo -e '\e[4:3mcurly underline (new in 0.52)\e[4:0m'
echo -e '\e[5mblink (new in 0.52)\e[25m'
echo -e '\e[7mreverse\e[27m'
echo -e '\e[8minvisible\e[28m <- invisible (but copy-pasteable)'
echo -e '\e[9mstrikethrough\e[29m'
echo -e '\e[53moverline (new in 0.52)\e[55m'

echo -e '\e[31mred\e[39m'
echo -e '\e[91mbright red\e[39m'
echo -e '\e[38:5:42m256-color, de jure standard (ITU-T T.416)\e[39m'
echo -e '\e[38;5;42m256-color, de facto standard (commonly used)\e[39m'
echo -e '\e[38:2::240:143:104mtruecolor, de jure standard (ITU-T T.416) (new in 0.52)\e[39m'
echo -e '\e[38:2:240:143:104mtruecolor, rarely used incorrect format (might be removed at some point)\e[39m'
echo -e '\e[38;2;240;143;104mtruecolor, de facto standard (commonly used)\e[39m'

echo -e '\e[46mcyan background\e[49m'
echo -e '\e[106mbright cyan background\e[49m'
echo -e '\e[48:5:42m256-color background, de jure standard (ITU-T T.416)\e[49m'
echo -e '\e[48;5;42m256-color background, de facto standard (commonly used)\e[49m'
echo -e '\e[48:2::240:143:104mtruecolor background, de jure standard (ITU-T T.416) (new in 0.52)\e[49m'
echo -e '\e[48:2:240:143:104mtruecolor background, rarely used incorrect format (might be removed at some point)\e[49m'
echo -e '\e[48;2;240;143;104mtruecolor background, de facto standard (commonly used)\e[49m'

echo -e '\e[21m\e[58:5:42m256-color underline (new in 0.52)\e[59m\e[24m'
echo -e '\e[21m\e[58;5;42m256-color underline (new in 0.52)\e[59m\e[24m'
echo -e '\e[4:3m\e[58:2::240:143:104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'
echo -e '\e[4:3m\e[58:2:240:143:104mtruecolor underline (new in 0.52) (might be removed at some point) (*)\e[59m\e[4:0m'
echo -e '\e[4:3m\e[58;2;240;143;104mtruecolor underline (new in 0.52) (*)\e[59m\e[4:0m'

echo
echo Underlines:

echo -e "\x1b[58:2::255:0:0m\x1b[4:1msingle underline \x1b[0m"
echo -e "\x1b[4:2mdouble underline \x1b[58:2::255:0:0m and with color\x1b[0m"
echo -e "\x1b[4:3mcurly underline \x1b[58:2::255:0:0m and with color\x1b[0m"
echo -e "\x1b[4:4mdotted underline \x1b[58:2::255:0:0m and with color\x1b[0m"
echo -e "\x1b[4:5mdashed underline \x1b[58:2::255:0:0m and with color\x1b[0m"



echo
echo Ligatures:
liga="-<< -< -<- <-- <--- <<- <- -> ->> --> ---> ->- >- >>- <-> <--> <---> <----> <!--\n
=<< =< =<= <== <=== <<= <= => =>> ==> ===> =>= >= >>= <=> <==> <===> <====> <!---\n
[| |] {| |} <=< >=> <~~ <~ ~> ~~> :: ::: \/ /\ == != /= ~= <> === !== =/= =!= :>\n
:= :- :+ <* <*> *> <| <|> |> <. <.> .> +: -: =: <***> __ (* comm *) ++ +++ |- -|"
echo "Normal:"
echo -e " "$liga
echo -e "\e[3mItalic:\e[0m"
echo -e "\e[3m" $liga"\e[0m"
echo -e "\e[1mBold:\e[0m"
echo -e "\e[1m" $liga"\e[0m"

echo
echo "Emoji: 🚀 💩 😁 🍖 🔥 🔷"

echo
echo Nerd font:
echo -e " 歷    שּ      "

echo 
echo 24-bit colors:

# This file was originally taken from iterm2 https://github.com/gnachman/iTerm2/blob/master/tests/24-bit-color.sh
#
#   This file echoes a bunch of 24-bit color codes
#   to the terminal to demonstrate its functionality.
#   The foreground escape sequence is ^[38;2;<r>;<g>;<b>m
#   The background escape sequence is ^[48;2;<r>;<g>;<b>m
#   <r> <g> <b> range from 0 to 255 inclusive.
#   The escape sequence ^[0m returns output to default

setBackgroundColor()
{
    #printf '\x1bPtmux;\x1b\x1b[48;2;%s;%s;%sm' $1 $2 $3
    printf '\x1b[48;2;%s;%s;%sm' $1 $2 $3
}

resetOutput()
{
    echo -en "\x1b[0m\n"
}

# Gives a color $1/255 % along HSV
# Who knows what happens when $1 is outside 0-255
# Echoes "$red $green $blue" where
# $red $green and $blue are integers
# ranging between 0 and 255 inclusive
rainbowColor()
{ 
    let h=$1/43
    let f=$1-43*$h
    let t=$f*255/43
    let q=255-t

    if [ $h -eq 0 ]
    then
        echo "255 $t 0"
    elif [ $h -eq 1 ]
    then
        echo "$q 255 0"
    elif [ $h -eq 2 ]
    then
        echo "0 255 $t"
    elif [ $h -eq 3 ]
    then
        echo "0 $q 255"
    elif [ $h -eq 4 ]
    then
        echo "$t 0 255"
    elif [ $h -eq 5 ]
    then
        echo "255 0 $q"
    else
        # execution should never reach here
        echo "0 0 0"
    fi
}

for i in `seq 0 127`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor $i 0 0
    echo -en " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor 0 $i 0
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor 0 0 $i
    echo -n " "
done
resetOutput

for i in `seq 0 127`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput
for i in `seq 255 -1 128`; do
    setBackgroundColor `rainbowColor $i`
    echo -n " "
done
resetOutput
