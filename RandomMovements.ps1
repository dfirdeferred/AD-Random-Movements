#################################################################################
# RandomMovements.ps1 v.2                                                       #
#                                                                               #
#  RandomMovements.PS1 generates activity in Active Directory for Sandboxes     #
#                                                                               #
#                     WRITTEN BY: Darryl G. Baker, CISSP, CEH                   #
#                                     for                                       #
#                         Tenable for AD Sandbox Environments                   #
#################################################################################



function MoveUsers{
    $user = Get-ADuser -Filter * -Properties * | Get-Random 
    $user | Move-ADObject -TargetPath "OU=Domain Controllers,DC=alsid,DC=corp"
    
    }


function MoveComputers{
    $computer = Get-ADComputer -Filter "name -ne 'dc-vm'" | Get-Random 
    $computer | Move-ADObject -TargetPath "CN=Users,DC=alsid,DC=corp"
    
    }


function MoveClean{
    Get-ADUser -SearchBase "OU=Domain Controllers,DC=alsid,DC=corp" -Filter * | Move-ADObject -TargetPath "OU=Alsid,DC=alsid,DC=corp"
    Get-ADComputer -SearchBase "CN=Users,DC=alsid,DC=corp" -Filter * | Move-ADObject -TargetPath "CN=Computers,DC=alsid,DC=corp"
    }

try{
    Get-ADComputer computer-50
    }
Catch
    {
     1..50 | %{New-ADComputer -Name ('computer-' + $_)
     Start-Sleep -Seconds 10
        }
    }

MoveClean

1..10 | %{
    MoveUsers
    Start-Sleep -Seconds 5
    MoveComputers
    }




# SIG # Begin signature block
# MIIFlAYJKoZIhvcNAQcCoIIFhTCCBYECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQULwiyPDG8JRnyQFCa+pcrQ3At
# fT2gggMiMIIDHjCCAgagAwIBAgIQO+B/uXgs+ZJDI4pFwa7Z0DANBgkqhkiG9w0B
# AQsFADAnMSUwIwYDVQQDDBxEYXJyeWwgRy4gQmFrZXIgQ29kZSBTaWduaW5nMB4X
# DTIxMDgxODE5NTcwMloXDTIyMDgxODIwMTcwMlowJzElMCMGA1UEAwwcRGFycnls
# IEcuIEJha2VyIENvZGUgU2lnbmluZzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
# AQoCggEBAKG7SowGauN0KCzcvXbxj5N9w6JrBU7OG3CqEh/5wCxvJ1CLAMIVa3lL
# +VqXxGS5iX/DbGt3NbvtCDcnu4OCCWDQkqM83NTZP84cD30O9JQblnxIwV1KLjXf
# p96NrOmAuhHHAbRITUxF5+dGZFfpJVp8Gi09GJf+DaEqSCzxu2Qw+g6NW9CWPRW0
# x0HGua95OcNHhNHOJLTTBg1ohtmo82mo5vMuniHIzM5j0sRqxj9vnNwQvTmgC/yq
# rRb3/u9XuPfGBnyR9mNw5po+MwOYenxShZgVv/UekL+oxBnt17r5TrUQfvWfKT7l
# i6pJ5+3Lose2Ave0ZVi4niNdzUi38mUCAwEAAaNGMEQwDgYDVR0PAQH/BAQDAgeA
# MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSd+ISqqC2sU6pmoZKlYLvJ
# 5a3vgDANBgkqhkiG9w0BAQsFAAOCAQEAY0P3VKNfGMKr+dqlEKjP8Ab95GZ++DZv
# yl4LmoCg0SLsgPoOgDzaaVkCu/OYSsScY9lkZqUO4T37hqdJpiI7FHi7hWWdGJFH
# /x/sQFJwUwuF4zJCCBv33YfJtrs42upbN1xSb3yUof61RTMhe2ZBp8DbfiPhsHI/
# +VZBqWy3FTUTj7XUng09B3gEv55mwEgPaGbUktAOK6fV8AVPtEksHqMllmcjLCeL
# nA6miV7eu+JGCNX/AO6Cvz2BIYMday06B1uVAMu+4NAI7A0kbmPJ7vZ2nXoCqN/y
# 1UrpGuO3EnXLsjYq5skJdNVmmFBTnlpMeM3a0e2I2fvYIkQ0m63CvjGCAdwwggHY
# AgEBMDswJzElMCMGA1UEAwwcRGFycnlsIEcuIEJha2VyIENvZGUgU2lnbmluZwIQ
# O+B/uXgs+ZJDI4pFwa7Z0DAJBgUrDgMCGgUAoHgwGAYKKwYBBAGCNwIBDDEKMAig
# AoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgEL
# MQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUZ9c739wB7sCpHBh5UiUk
# 2jdSnPgwDQYJKoZIhvcNAQEBBQAEggEAh+UxJrsYIPTpnB/GHxRJf1zVXqIZpSpz
# O6vxKb2phxAQ2Iv2uoh4+MWm5fOMUKEQDu/jY4Tbji2iqgEQAEMT+Fjo2/XBKSLC
# KM2PPXPLTSfjnp5OyrlX9rIU4JlycnCcD6Tp43PGOrFLcDVVvG0LWzZjmoiZMMAq
# /PVwCbPgIKoqL5GegdEd5Qu0FacVg6v3Efb4/Rd12exuyydB5tdvEo8lhjspwJIX
# /r2v51ZeDTbJ5BGnaNdalCYOXpQFQWOIv+BIusGLCKoXQeh0D0p+W091tEJ5tdee
# wKP33sT9zYLtFtqcFA2hziSnELDG6Ggn0eUcP03e1vpOM3wxLwc1fA==
# SIG # End signature block
