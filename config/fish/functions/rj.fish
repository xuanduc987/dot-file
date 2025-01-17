function rj
  fd --type d --max-depth 4 --no-ignore --hidden --glob ".git" $(ghq root) | sed 's/\/\.git//' | fzf -1 -q "$argv[1]" | read -l result
  if [ -n "$result" ]
    cd -- $result
  end
end
