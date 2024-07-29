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

# DOCKER AUTOCOMPLETE

# Install from PowerShell Gallery
#Install-Module DockerCompletion -Scope CurrentUser
# Import
Import-Module DockerCompletion

# ALIAS

# function ll { Get-ChildItem }
# Set-Alias -Name ll -Value Get-Childitem

## eza

function ezall { param($Path=".\") eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style='+%d/%m/%Y %H:%M' $Path }

#Set-Alias -Name ll -Value 'eza -lagMh --group-directories-first --icons=always --git --git-repos --time-style="+%d/%m/%Y %H:%M"'
Set-Alias -Name ll -Value ezall

## Show boot times of the last X days (default 30 days, run 'Lastdays-Reboot 20' for last 20 days)

function lastdays-reboot { param($Days=30) Get-WinEvent -FilterHashtable @{ LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12,13; Level=4; StartTime=(Get-Date) - (New-TimeSpan -Day $Days) } }

## Show all boot times

# function last-reboot { param($Number=30) Get-WinEvent -FilterHashtable @{ LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12,13; Level=4 } | select -first $Number }

## Full uptime

function Full-Uptime { param($Number=10) Get-Uptime && Get-Uptime -Since && Get-SystemUptime $Number | Format-Table -autosize }

Set-Alias -Name Last-Reboot -Value Get-SystemUptime

function Get-SystemUptime {
    param (
        [int]$Days = 7  # Número de días hacia atrás para buscar eventos
    )

    # Obtener eventos de apagado (Event ID 13) y encendido (Event ID 12)
    $shutdownEvents = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=13; Level=4; StartTime=(Get-Date).AddDays(-$Days)} | Sort-Object TimeCreated
    $startupEvents = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12; Level=4; StartTime=(Get-Date).AddDays(-$Days)} | Sort-Object TimeCreated

    # Lista para almacenar los resultados
    $results = @()

    # Emparejar eventos de apagado y encendido
    foreach ($startupEvent in $startupEvents) {
        $shutdownEvent = $shutdownEvents | Where-Object { $_.TimeCreated -gt $startupEvent.TimeCreated } | Select-Object -First 1

        if ($shutdownEvent) {
            $uptime = $shutdownEvent.TimeCreated - $startupEvent.TimeCreated
            $results += [PSCustomObject]@{
                Encendido = $startupEvent.TimeCreated
                Apagado   = $shutdownEvent.TimeCreated
                Uptime    = $uptime
            }
            # Eliminar el evento de apagado ya utilizado
            $shutdownEvents = $shutdownEvents | Where-Object { $_.TimeCreated -ne $shutdownEvent.TimeCreated }
        } else {
            $results += [PSCustomObject]@{
                Encendido = $startupEvent.TimeCreated
                Apagado   = "Sistema sigue encendido"
                Uptime    = [TimeSpan]::MaxValue  # Indica que no ha terminado
            }
        }
    }

    # Ordenar los resultados por la fecha de encendido, descendente
    $results = $results | Sort-Object Encendido -Descending

    # Mostrar los resultados
    foreach ($result in $results) {
        $encendidoStr = $result.Encendido.ToString("dd/MM/yyyy HH:mm:ss")
	
        if ($result.Apagado -eq "Sistema sigue encendido") {
            Write-Output "Encendido: $encendidoStr - $($result.Apagado)"
        } else {
            $apagadoStr = $result.Apagado.ToString("dd/MM/yyyy HH:mm:ss")
	    $uptimeStr = $result.Uptime.ToString("hh\:mm\:ss")
            Write-Output "Encendido: $encendidoStr - Apagado: $apagadoStr ($uptimeStr)"
        }
    }
}

# Ejemplo de uso:
# Get-SystemUptime -Days 7

## Alias Kubernetes

. $HOME\.kubectl-completion.ps1
. $HOME\.minikube-completion.ps1
. $HOME\.k9s-completion.ps1

Set-Alias -Name k -Value kubectl

### Welcoming text

write-output ""
write-output "░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ░██████╗░█████╗░██╗░░░░░██╗░░░██╗░█████╗░"
write-output "░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ██╔════╝██╔══██╗██║░░░░░██║░░░██║██╔══██╗"
write-output "░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ╚█████╗░███████║██║░░░░░╚██╗░██╔╝███████║"
write-output "░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░╚═══██╗██╔══██║██║░░░░░░╚████╔╝░██╔══██║"
write-output "░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ██████╔╝██║░░██║███████╗░░╚██╔╝░░██║░░██║"
write-output "░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ╚═════╝░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝"
write-output ""
write-output "Custom alias:"
write-output ""
write-output "- Lastdays-Reboot: Show boot times of the last X days (default 30 days, run 'Lastdays-Reboot 20' for last 20 days)"
# write-output "- Last-Reboot: Show the last X boot times (default 30 lines, run 'Last-Reboot 20' for 20 lines)"
write-output "- Full-Uptime: Show uptime and the last X boot times (default 10 lines, run 'Full-Uptime 20' for 20 lines)"
write-output "- Last-Reboot / Get-SystemUptime: Show boot time, shutdown time and uptime of the last X days (default 7 days, run 'Get-SystemUptime -Days 30 / Last-Reboot 30' for last 30 days)"
write-output ""

