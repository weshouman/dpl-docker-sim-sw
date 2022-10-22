yay -G espressomd-git --noconfirm
cd espressomd-git/
sed -i "s#.*python-sphinx.*#         'python-sphinx'#g" PKGBUILD
makepkg -si --noconfirm
