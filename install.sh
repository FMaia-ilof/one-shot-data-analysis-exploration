#!/bin/bash

# Name of the virtual environment directory
VENV_DIR=".venv"

# Check if a Python version is specified (default is python3)
PYTHON_CMD=${1:-python3}

echo ">>> Checking Python version..."
$PYTHON_CMD --version || { echo "$PYTHON_CMD not found. Please install Python first."; exit 1; }

echo ">>> Creating virtual environment in $VENV_DIR ..."
$PYTHON_CMD -m venv $VENV_DIR || { echo "Failed to create virtual environment."; exit 1; }

echo ">>> Activating virtual environment ..."
source $VENV_DIR/bin/activate || { echo "Failed to activate virtual environment."; exit 1; }

echo ">>> Upgrading pip ..."
pip install --upgrade pip || { echo "Failed to upgrade pip."; exit 1; }

if [ -f "requirements.txt" ]; then
  echo ">>> Installing dependencies from requirements.txt ..."
  pip install -r requirements.txt || { echo "Failed to install dependencies."; exit 1; }
else
  echo ">>> No requirements.txt found. Skipping dependency installation."
fi

echo ">>> Virtual environment setup is complete."
echo "Use 'source $VENV_DIR/bin/activate' to activate your environment."