yay -G python-griddataformats --noconfirm
cd python-griddataformats/
sed -i "s#^sha256sums=.*#sha256sums=('2e67d831385e61307e036188b9a8918074c9032a94d52b09bf261c9cc2be7d23')#g" PKGBUILD
makepkg -si --noconfirm
