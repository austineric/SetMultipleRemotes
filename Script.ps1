

####################################
# Author:      Eric Austin
# Create date: January 2019
# Description: This script helps set multiple remotes for a repo since apparently it's a hassle to do that manually
####################################

$OriginalRemote=""
$AdditionalRemote=""

Try {

    Clear-Host
    Write-Host ""

    #capture original remote
    $OriginalRemote=((git remote show origin) -like "*Push*URL*").Substring(13)

    #receive new remote path
    $Confirm=""
    Do {
        $AdditionalRemote=Read-Host "Additional remote path (no need to modify slash direction)"
        $Confirm=Read-Host "Additional remote path will be `"$($AdditionalRemote)`". Is that correct (y/n)?"
    }
    Until ($Confirm -eq "y")

    #reverse slash direction (it appears to work fine with backwards slashes as well as forward, but use forward slashes to keep things consistent)
    $AdditionalRemote=$AdditionalRemote.Replace("\","/")

    #this handles paths with spaces without any special handling
    git remote set-url --add --push origin $OriginalRemote
    git remote set-url --add --push origin $AdditionalRemote

    git remote show origin

}

Catch {

    Write-Host $Error[0]
    
}