#!/bin/bash
  function usage()
  {
      echo "$0 <likwid timeline log>";
      echo "where <likwid timeline log> is a file obtained with likwid-perfctr -t (timeline mode)";
  }

  FILE=$1
  if [ -z $FILE ]; then
    echo "Error: file has not been provided.";
    usage;
    exit 1;
  fi

  echo "Time Core Metric Value"
  TEMP=`mktemp`
  cat $FILE | grep -v -e CORE -e ^$  > $TEMP
  while read -r line; do
    GROUPID=`echo $line | awk '{ print $1 }'`
    METRICS=`echo $line | awk '{ print $2 }'`
    CORES=`echo $line | awk '{ print $3 }'`
    TIMESTAMP=`echo $line | awk '{ print $4 }'`
    VALS=`mktemp`
    echo $line | cut -d" " -f5- | sed "s/ /\n/g" > $VALS
    REMS=`mktemp`
    for METRIC in `seq 1 $METRICS`; do
      for CORE in `seq 1 $CORES`; do
         echo $TIMESTAMP $CORE M$METRIC
      done
    done > $REMS
    paste -d " " $REMS $VALS
    rm $VALS
    rm $REMS
  done < $TEMP
  rm $TEMP
  exit 0
