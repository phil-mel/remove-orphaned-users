#script designed to pull all users with both read and send as permissions
#then identify orphaned users by their SID strings
#and remove permissions from all users with SID strings

Connect-ExchangeOnline -UserPrincipalName [<credentials.]

$readperm = (get-mailboxpermission -identity [<MB>]).user
$readarray = (0..(($readperm.count)-1))
foreach ($number in $readarray)
{
    if ($readperm[$number] -like "*S-1-5-21-*")
        {
            remove-mailboxpermission -identity [<MB>] -user $readperm[$number] -accessrights fullaccess
        }
        
}

$sendperm = (get-recipientpermission -identity [<MB>]).trustee
$sendarray = (0..(($sendperm.count)-1))
foreach ($number in $sendarray)
{
    if ($sendperm[$number] -like "*S-1-5-21-*")
        {
            remove-recipientpermission [<MB>] -AccessRights SendAs -Trustee $sendperm[$number]
        }
        
}
