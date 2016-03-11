_git_webkit2png(){
  __gitcomp "run clean $(git for-each-ref --format='%(refname:short)')"
}
