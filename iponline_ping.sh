TRY_IP=$1
TRY_HOST=$2


CMD="ping -c 1"
CMD="fping -c 1"


if [[ "$TRY_HOST" == "" ]]; then
    TRY_HOST=TRY_IP
fi;

echo testing $TRY_HOST with IP $TRY_IP
$CMD $TRY_IP &> /dev/null
TRY_RESULT=$?

if [[ $TRY_RESULT = 0 ]]; then
    echo result ok $TRY_HOST $TRY_IP
    touch results_ok/$TRY_HOST
else
    echo result nok $TRY_HOST $TRY_IP
    touch results_not_ok/$TRY_HOST
fi

