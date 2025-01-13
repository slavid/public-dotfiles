(@(& 'C:/Users/Salva/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\Salva\AppData\Local\Programs\oh-my-posh\themes\montys.omp.json' --print) -join "`n") | Invoke-Expression

. "C:\Users\Salva\Documents\PowerShell\shell-scripts.ps1"

#########################################################
###################### IMPORT MODULES ###################
#########################################################

Import-Module Terminal-Icons

## Import PSFzf
Import-Module PSFzf

# region profile alias initialize
Import-Module -Name HackF5.ProfileAlias -Force -Global -ErrorAction SilentlyContinue
# end region

# DOCKER AUTOCOMPLETE
Import-Module DockerCompletion

# Import posh-git

Import-Module posh-git

#########################################################
###################### SET MODULES ######################
#########################################################

# Autocomplete like bash
### Disabled in favour of fzf
# Set-PSReadlineKeyHandler -Key Tab -Function Complete


# Mute bell on Tab autocomplete
set-psreadlineoption -bellstyle none




# Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption -PredictionSource History 
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -EditMode Windows 

## Enable More Fzf
### Control+r history search fzf

Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r' -TabExpansion -EnableAliasFuzzyHistory
### fzf on tab autocomplete
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

#########################################################
###################### ALIAS ############################
#########################################################

## Alias Kubernetes

. $HOME\.kubectl-completion.ps1
. $HOME\.minikube-completion.ps1
. $HOME\.k9s-completion.ps1

Set-Alias -Name k -Value kubectl

## bat batcat
Set-Alias -Name batcat -Value bat

## eza
function ezall { param($Path=".\") eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style='+%d/%m/%Y %H:%M' $Path }

#Set-Alias -Name ll -Value 'eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style="+%d/%m/%Y %H:%M"'
Set-Alias -Name ll -Value ezall

Set-Alias -Name Last-Reboot -Value Get-SystemUptime-Number
Set-Alias -Name Last-Reboot-Days -Value Get-SystemUptime-Days

#########################################################
###################### FUNCTIONS ########################
#########################################################

## Find alternative with fzf and preview for files

function Find-Preview { param($Extension="*") Get-ChildItem -Recurse -Filter "$Extension" | ForEach { $_.FullName } | fzf --bind "pgup:preview-up,pgdn:preview-down" --preview "bat --color=always {}" }

## Show boot times of the last X days (default 30 days, run 'Lastdays-Reboot 20' for last 20 days)

function lastdays-reboot { param($Days=30) Get-WinEvent -FilterHashtable @{ LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12,13; Level=4; StartTime=(Get-Date) - (New-TimeSpan -Day $Days) } }

## Show all boot times

# function last-reboot { param($Number=30) Get-WinEvent -FilterHashtable @{ LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12,13; Level=4 } | select -first $Number }

## Full uptime

function Full-Uptime { param($Number=10) Get-Uptime && Get-Uptime -Since && Get-SystemUptime-Number $Number | Format-Table -autosize }

#########################################################
###################### INIT COMMANDS ####################
#########################################################

## zoxide
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })

#########################################################
###################### VARIABLES ########################
#########################################################

$env:PATH += ";C:\Program Files\Mozilla Firefox;C:\Program Files\Oracle\VirtualBox;C:\Users\Salva\Downloads\webOS_TV_SDK\CLI\bin"
$env:KUBECONFIG = "C:\Users\Salva\.kube\config;C:\Users\Salva\.kube\config-k3s"