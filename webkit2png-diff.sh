root=$(git rev-parse --show-toplevel)
cd "$root/.git/"
comm -12 <(ls $1) <(ls $2)

#for i in $(ls $1)
#do
  #compare -metric AE  "$1/$i" "$2/$i" temp.png 2>/dev/null 1>/dev/null
  ## treat errors and differences as 'being different'. probably means false positives
  #if [ $? != "0" ]
  #then
    #echo $i
    #mkdir -p diffs
    #composite "$1/$i" "$2/$i" -compose difference "diffs/$i"
    ## auto level makes it easier to notice differences
    #convert  "diffs/$i" -auto-level "diffs/$i"
  #fi
#done
