if [ "$(arch)" = "x86_64" ]
then
    echo "$(cat ./../version.txt)"
else
    echo "$(cat ~/version.txt)"
fi