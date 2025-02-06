function GT {
  $ab = @('C:\configs\')
  $f = @(
    'C:\projects',
    'C:\projects\opensource'
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
