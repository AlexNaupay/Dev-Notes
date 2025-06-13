### Python Notes
```bash
python -m venv <environment_name>
python -m venv .env
source .venv/bin/activate
```

### poetry
```bash
# https://python-poetry.org/docs/#installing-with-the-official-installer
poetry new poetry-project

# poetry config
poetry config virtualenvs.create true --local
poetry config virtualenvs.in-project true --local
poetry config --list
poetry config virtualenvs.path # See value

# Initialising a pre-existing project
cd pre-existing-project
poetry init
poetry install --no-root

poetry add pendulum
poetry add flask
poetry add --dev pytest
poetry add "git+https://github.com/ansible/ansible.git@v2.11.6"}

poetry add pendulum@^2.0.5 # Allow >=2.0.5, <3.0.0 versions
poetry add pendulum@~2.0.5 # Allow >=2.0.5, <2.1.0 versions
poetry add "pendulum>=2.0.5" # Allow >=2.0.5 versions, without upper bound
poetry add pendulum==2.0.5 # Allow only 2.0.5 version

poetry add pendulum@latest


# List dependencies
poetry show

# Run a file on venv created
poetry run <command>
poetry run python main.py
poetry run pytest

poetry shell  # < poetry=2.0.0
poetry env activate # Print the command to activate a virtual environment
source .venv/bin/activate
```

### UV
```bash
uv init sample-project
uv venv
source .venv/bin/activate

uv add flask  # adds flask to your pyproject.toml

uv pip install flask                # Install Flask.
uv pip install -r requirements.txt  # Install from a requirements.txt file.
uv pip install -r pyproject.toml    # will only install the project's dependencies, not the project itself.
uv pip install -e .                 # Install current project in editable mode.
uv pip install "package @ ."        # Install current project from disk
uv pip install "flask[dotenv]"      # Install Flask with "dotenv" extra.

uv pip sync requirements.txt  # Install dependencies from a requirements.txt file.
uv sync # to ensure your virtual environment matches the dependencies in pyproject.toml

uv run hello.py
uv run app.py

# Install python
uv python install 3.12

```