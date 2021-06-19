# list file should be one of these formats:
# ip hostname
# ip


# after running it will generate two files on current dir:
# list_ok list of hostnames up
# list_not_ok list of hostnames not up


PARALLEL="20"
SLEEP=0.5

echo -n "" > list_ok
echo -n "" > list_not_ok

# parallel results 
mkdir -p results_ok
mkdir -p results_not_ok
rm -rf results_ok/*
rm -rf results_not_ok/*

x=$PARALLEL
while read TRY; do
    x=$(($x-1))
    if [[ $x -lt 0 ]]; then
       x=$PARALLEL
       echo "sleeping one moment"
       sleep $SLEEP;
    fi; 

    bash iponline_ping.sh $TRY &
done < list;

# generating list_ok
for f in $(/bin/ls results_ok/); do
    echo $f >> list_ok
done

# generating list_not_ok
for f in $(/bin/ls results_not_ok/); do
    echo $f >> list_not_ok
done