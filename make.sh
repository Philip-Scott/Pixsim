echo "namespace Pixsim {" > ./src/user_string.vala
echo "public const string user = \"$(pwd)\";" >>./src/user_string.vala
echo "}" >> ./src/user_string.vala

valac-0.26 --pkg gtk+-3.0 --pkg granite --thread --target-glib 2.32 src/window.vala src/lights.vala src/board.vala src/user_string.vala  src/clicked.c src/pilas.h src/colas.h -o Pixsim && ./Pixsim
