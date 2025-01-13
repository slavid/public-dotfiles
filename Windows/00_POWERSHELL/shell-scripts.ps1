function Get-SystemUptime-Number {

    param (
        [int]$Number = 20  # Número de días hacia atrás para buscar eventos
    )


    # Obtener eventos de apagado (Event ID 13) y encendido (Event ID 12)
    $shutdownEvents = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=13; Level=4 } | select -first $Number
# } ; StartTime=(Get-Date).AddDays(-$Days)} | Sort-Object TimeCreated
    $startupEvents = Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-General'; Id=12; Level=4 } | select -first $Number
# } ; StartTime=(Get-Date).AddDays(-$Days)} | Sort-Object TimeCreated

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

function Get-SystemUptime-Days {
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

### Welcoming text
fastfetch
#write-output ""
#write-output "░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ░██████╗░█████╗░██╗░░░░░██╗░░░██╗░█████╗░"
#write-output "░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ██╔════╝██╔══██╗██║░░░░░██║░░░██║██╔══██╗"
#write-output "░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ╚█████╗░███████║██║░░░░░╚██╗░██╔╝███████║"
#write-output "░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░╚═══██╗██╔══██║██║░░░░░░╚████╔╝░██╔══██║"
#write-output "░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ██████╔╝██║░░██║███████╗░░╚██╔╝░░██║░░██║"
#write-output "░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ╚═════╝░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝"
#write-output ""
write-output "Custom alias:"
write-output ""
write-output "- Lastdays-Reboot: Show boot times of the last X days (default 30 days, run 'Lastdays-Reboot 20' for last 20 days)"
# write-output "- Last-Reboot: Show the last X boot times (default 30 lines, run 'Last-Reboot 20' for 20 lines)"
write-output "- Full-Uptime: Show uptime and the last X boot times (default 10 lines, run 'Full-Uptime 20' for 20 lines)"
write-output "- Last-Reboot: Show the last X boot time, shutdown time and uptime (default 20 lines, run Last-Reboot 30' for last 30 lines)"
write-output "- Last-Reboot-Days: Show boot time, shutdown time and uptime of the last X days (default 7 days, Last-Reboot-Days 30' for last 30 days)"
write-output "- Find-Preview: Find-like with fuzzy-finder (fzf) and bat preview with file extension filter (ie. Find-Preview *.yml)"
write-output ""