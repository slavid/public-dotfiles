(@(& 'C:/Users/Salva/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\Salva\AppData\Local\Programs\oh-my-posh\themes\montys.omp.json' --print) -join "`n") | Invoke-Expression
Import-Module Terminal-Icons

# region profile alias initialize
Import-Module -Name HackF5.ProfileAlias -Force -Global -ErrorAction SilentlyContinue
# end region

$env:PATH += ";C:\Program Files\Mozilla Firefox;C:\Program Files\Oracle\VirtualBox;C:\Users\Salva\Downloads\webOS_TV_SDK\CLI\bin"
$env:KUBECONFIG = "C:\Users\Salva\.kube\config;C:\Users\Salva\.kube\config-k3s"

# Autocomplete like bash
Set-PSReadlineKeyHandler -Key Tab -Function Complete
# Mute bell on Tab autocomplete
set-psreadlineoption -bellstyle none

# ALIAS

# function ll { Get-ChildItem }
# Set-Alias -Name ll -Value Get-Childitem

## eza

function ezall { param($Path=".\") eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style='+%d/%m/%Y %H:%M' $Path }

#Set-Alias -Name ll -Value 'eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style="+%d/%m/%Y %H:%M"'
Set-Alias -Name ll -Value ezall

## Alias Kubernetes

. $HOME\.kubectl-completion.ps1
. $HOME\.minikube-completion.ps1
. $HOME\.k9s-completion.ps1

Set-Alias -Name k -Value kubectl