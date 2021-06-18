
echo -n "" > list_ok
echo -n "" > list_not_ok


# list file should be one of these formats:
# ip hostname
# ip


# after running it will generate two files on current dir:
# list_ok list of hostnames up
# list_not_ok list of hostnames not up

while read TRY; do
    TRY_IP=$(echo $TRY | awk '{print $1}')
    TRY_HOST=$(echo $TRY  | awk '{print $2}')
    if [[ $TRY_HOST -eq "" ]]; then
        TRY_HOST=TRY_IP
    fi;

    echo testing $TRY_HOST with IP $TRY_IP
    ping -c 1 $TRY_IP &> /dev/null
    TRY_RESULT=$?

    if [[ $TRY_RESULT = 0 ]]; then
        echo result ok $TRY_HOST $TRY_IP
        echo $TRY_HOST >> list_ok
    else
        echo result nok $TRY_HOST $TRY_IP
        echo $TRY_HOST >> list_not_ok
    fi


    #echo $TRY
done < list;
