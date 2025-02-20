# Makefile for installing dependencies

# Ensure curl is installed
install_curl:
	sudo apt-get install -y curl

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

# Install Neovim and config for it
install_neovim:
	sudo apt install fonts-noto-color-emoji
	sudo apt-get install -y gcc ripgrep unzip git xclip
	sudo apt-get install neovim
	mkdir ~/.config/nvim/
	cp init.lua ~/.config/nvim/init.lua

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


# Combined target to install all dependencies
install_all: install_neovim install_pypy3 install_zig install_rust install_evcxr_jupyter install_evcxr_notebook install_libgraphviz install_quarto install_starship
	@echo "All dependencies have been installed."

