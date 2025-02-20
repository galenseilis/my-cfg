# Makefile for installing dependencies

# Ensure curl is installed
install_curl:
	sudo apt-get install -y curl

install_nerd_font:
	# Download the FiraCode Nerd Font zip file
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/0xProto.zip -O nerd_font.zip
	# Unzip the font archive
	unzip nerd_font.zip -d NerdFont
	# Move the font files to the local fonts directory
	mkdir -p ~/.local/share/fonts
	mv NerdFont/*.ttf ~/.local/share/fonts/
	# Clean up the downloaded zip file and extracted folder
	rm -rf nerd_font.zip NerdFont
	# Update the font cache
	fc-cache -fv
	@echo "A Nerd Font has been installed."

install_gh:
	(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) \
		&& sudo mkdir -p -m 755 /etc/apt/keyrings \
		&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
		&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
		&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
		&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
		&& sudo apt update \
		&& sudo apt install gh -y

# Install PyPy3
install_pypy3:
	sudo apt-get install -y pypy3

# Install Zig using snap
install_zig:
	sudo snap install zig --classic --beta

# Install Rust (ensure curl is available first)
install_rust: install_curl
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install evcxr_jupyter using cargo
install_evcxr_jupyter:
	cargo install --locked evcxr_jupyter

# Install evcxr_jupyter notebook
install_evcxr_notebook:
	evcxr_jupyter --install

# Install libgraphviz-dev and dependencies
install_libgraphviz:
	sudo apt-get install -y graphviz libgraphviz-dev

install_pyright:
	sudo apt install -y npm
	sudo npm install pyright
	sudo rm -r node_modules
	sudo rm package-lock.json
	sudo rm package.json


# Install Neovim and config for it
install_neovim: install_quarto install_pyright
	sudo apt install fonts-noto-color-emoji
	sudo apt-get install -y gcc ripgrep unzip git xclip
	sudo apt-get install neovim
	mkdir ~/.config/nvim/
	cp init.lua ~/.config/nvim/init.lua
	sudo apt install imagemagick
	sudo apt install libmagickwand-dev
	sudo apt install liblua5.1-0-dev
	sudo apt install luajit
	sudo apt install tree-sitter-cli

install_starship:
	curl -sS https://starship.rs/install.sh | sh
	@grep -qxF 'eval "$(starship init bash)"' ~/.bashrc || echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Install Quarto
install_quarto:
	# Download the .deb file for Quarto
	wget https://github.com/quarto-dev/quarto-cli/releases/download/v1.6.40/quarto-1.6.40-linux-amd64.deb -O quarto.deb
	# Install the downloaded .deb package
	sudo dpkg -i quarto.deb
	# Fix dependencies if needed
	sudo apt-get install -f
	# Clean up the .deb file
	rm quarto.deb
	# Run installation checks
	quarto check
	@echo "Quarto has been installed."

install_htop:
	sudo apt install -y htop

# Combined target to install all dependencies
install_all: install_curl install_nerd_font install_neovim install_pypy3 install_zig install_rust install_evcxr_jupyter install_evcxr_notebook install_libgraphviz install_quarto install_starship
	@echo "All dependencies have been installed."

