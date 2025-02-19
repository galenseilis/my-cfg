# Makefile for installing dependencies

# Install PyPy3
install_pypy3:
	sudo apt-get install -y pypy3

# Install Zig using snap
install_zig:
	sudo snap install zig --classic --beta

# Install Rust
install_rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install evcxr_jupyter using cargo
install_evcxr_jupyter:
	cargo install --locked evcxr_jupyter

# Install evcxr_jupyter notebook
install_evcxr_notebook:
	evcxr_jupyter --install

# Install libgraphviz-dev using pip
install_libgraphviz:
	sudo apt-get install -y graphviz
	pip install libgraphviz-dev

# Combined target to install all dependencies
install_all: install_pypy3 install_zig install_rust install_evcxr_jupyter install_evcxr_notebook install_libgraphviz
	@echo "All dependencies have been installed."


