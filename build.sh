# Source emsdk for this terminal session if last command failed
if [ -z "$EMSDK" ]; then
	source $HOME/emsdk/emsdk_env.sh
fi

# Try make web directory if doesn't exist
mkdir -p web

# https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5)

# Without ASYNCIFY
# emcc -o game.html game.c -Os -Wall ./path-to/libraylib.a -I. -Ipath-to-raylib-h -L. -Lpath-to-libraylib-a -s USE_GLFW=3 --shell-file path-to/shell.html -DPLATFORM_WEB

# With ASYNCIFY
emcc -o web/game.html src/main.c -Os -Wall $HOME/raylib/src/web/libraylib.web.a -I. -I$HOME/raylib/src -L. -L$HOME/raylib/src/web -s USE_GLFW=3 -s ASYNCIFY --shell-file $HOME/raylib/src/minshell.html -DPLATFORM_WEB

# Exit the script if the last command was unsuccessful
if [ $? -ne 0 ]; then
	exit 1
fi

emrun web/game.html
