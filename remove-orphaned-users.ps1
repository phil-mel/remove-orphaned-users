#script designed to pull all users with both read and send as permissions
#then identify orphaned users by their SID strings
#and remove permissions from all users with SID strings


#replace [<365admin>] with admin UPN
#replace [<MB>] with mailbox name (keep quotes)

#below is the test version, just showing that it is only pulling out SIDs

$SharedMB = "credit.control@card-saver.co.uk"

Connect-ExchangeOnline -UserPrincipalName pwilcock@fyldecoast.onmicrosoft.com

Get-MailboxPermission $SharedMB | ForEach `
{
    if ($_.User -Like "*S-1-5-21-*")
    {
        [System.Windows.MessageBox]::show($_.User)
    }
        
}

Get-RecipientPermission $SharedMB | ForEach `
{
    if ($_.Trustee -Like "*S-1-5-21-*")
    {
        [System.Windows.MessageBox]::show($_.Trustee)
    }
        
}


#below is the finished version, designed to remove permissions from the SIDs it pulls

$SharedMB = "[<MB>]"

Connect-ExchangeOnline -UserPrincipalName [<365admin>]

Get-MailboxPermission $SharedMB | ForEach `
{
    if ($_.User -Like "*S-1-5-21-*")
    {
        Remove-MailboxPermission -Identity $SharedMB -User $_.Name
    }
        
}

Get-RecipientPermission $SharedMB | ForEach `
{
    if ($_.Trustee -Like "*S-1-5-21-*")
    {
        Remove-RecipientPermission -Identity $SharedMB -Trustee $_.Trustee
    }
        
}
