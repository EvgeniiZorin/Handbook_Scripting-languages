
# Powershell

# General

`systeminfo` - get info about the computer's software and hardware.

**Environment variables (Powershell)**

```py
# List all environment variables
Get-ChildItem Env:
# Print a specific environment variable
echo $Env:EMAIL_USER

# Set an env var:
[Environment]::SetEnvironmentVariable("variable_name","variable_value","User")
### Then, reopen the terminal
```
**Environment variables (GUI)**

You can set environment variable in GUI by following the following steps:
- Win+R
- `sysdm.cpl`
- "Advanced" tab
- "Environment Variables"
- "New"
- Define a variable


# Text editing

```powershell
pip freeze | Select-String -Pattern "pandas|numpy|matplotlib|seaborn|tensorflow" > requirements.txt
```
