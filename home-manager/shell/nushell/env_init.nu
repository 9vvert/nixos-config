let DEFAULT_PYTHON_VENV = ($nu.home-path | path join ".venv14")

if (($DEFAULT_PYTHON_VENV | path type) == "dir") {
    overlay use ($DEFAULT_PYTHON_VENV | path join "bin" "activate.nu")
}