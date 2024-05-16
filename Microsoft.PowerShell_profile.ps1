oh-my-posh init pwsh --config "C:\configs\ohmyposh-configs.json" | Invoke-Expression

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function GT {
  $ab = @('C:\configs\')
  $f = @(
    'C:\Users\tsiory_re\projects',
    'C:\Users\tsiory_re\projects\opensource'
  )
  foreach($j in $f) {
    Invoke-Expression "ls -name -dir $j | Set-Variable a"
    foreach($i in $a) {
      $ar = $j + '\' + $i + '\'
      $ab += $ar
    }
  }
  Invoke-Expression "echo $ab | fzf | cd"
}

Set-PSReadLineKeyHandler -Chord Ctrl+r -ScriptBlock {
  $command = Get-Content (Get-PSReadlineOption).HistorySavePath | awk "!a[$0]++" | fzf
  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
}
