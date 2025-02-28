# Source emsdk for this terminal session if last command failed
if [ -z "$EMSDK" ]; then
	source $HOME/emsdk/emsdk_env.sh
fi

# Try make web directory if doesn't exist
mkdir -p web

# https://github.com/raysan5/raylib/wiki/Working-for-Web-(HTML5)

# NOTE:
# Can remove -s ASYNCIFY if there is no while(!WindowShouldClose()) loop
# --preload-file src/resources must be added if you want to load assets
emcc -o web/game.html src/main.c -Os -Wall $HOME/raylib/src/web/libraylib.web.a \
-I. -I$HOME/raylib/src -L. -L$HOME/raylib/src/web \
-s USE_GLFW=3 \
-s ASYNCIFY \
--shell-file $HOME/raylib/src/minshell.html \
-s TOTAL_STACK=64MB \
-s INITIAL_MEMORY=128MB \
-DPLATFORM_WEB

# Exit the script if the last command was unsuccessful
if [ $? -ne 0 ]; then
	return 1
fi

emrun web/game.html
