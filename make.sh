echo "namespace Pixsim {" > ./src/user_string.vala
echo "public const string user = \"$(pwd)\";" >>./src/user_string.vala
echo "}" >> ./src/user_string.vala

echo "[Desktop Entry]" > /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Encoding=UTF-8" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Name=Pixsim" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Comment=Lights On/Lights Off" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Exec=$(pwd)/Pixsim" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Icon=$(pwd)/Pixsim.svg" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Terminal=false" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Type=Application" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "StartupNotify=true" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop
echo "Categories=Games" >> /home/$(whoami)/.local/share/applications/Pixsim.desktop

valac-0.26 --pkg gtk+-3.0 --pkg granite --thread --target-glib 2.32 src/window.vala src/lights.vala src/board.vala src/user_string.vala  src/clicked.c src/pilas.h src/colas.h -o Pixsim && ./Pixsim
