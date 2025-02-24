# setup info https://hamidmosalla.com/2022/12/26/how-to-customize-windows-terminal-and-powershell-using-fzf-neovim-and-beautify-it-with-oh-my-posh/
Set-Alias vim nvim 
Set-Alias grep findstr

# Set Some Option for PSReadLine to show the history of our typed commands
Set-PSReadLineOption -PredictionSource History 
Set-PSReadLineOption -PredictionViewStyle ListView 
Set-PSReadLineOption -EditMode Windows 
Set-PSReadLineKeyHandler -Chord Ctrl+p -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord Ctrl+n -Function NextHistory
Set-PSReadlineKeyHandler -Key Ctrl+Spacebar -Function MenuComplete
Set-PSReadLineKeyHandler -Chord Ctrl+d -ScriptBlock { Get-ChildItem . -Recurse -Directory | Where-Object { $_.FullName -notmatch '\\node_modules\\' -and $_.FullName -notmatch '\\.git\\' } | Invoke-Fzf | % {cd $_ } }

#Fzf (Import the fuzzy finder and set a shortcut key to begin searching)
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

function loadenv {
    param ($path)
        
        get-content $path | foreach {
            $name, $value = $_.split('=')
                set-content env:\$name $value
        }
}
