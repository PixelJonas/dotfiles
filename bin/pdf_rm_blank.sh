#!/usr/bin/env bash

DOCUMENT_FILE_NAME=${1}

echo "
Document ${DOCUMENT_ID} is about to be consumed.
"

IN="$DOCUMENT_FILE_NAME"
OUT="${DOCUMENT_FILE_NAME}_tmp"
PAGES=$(pdfinfo "$IN" | grep ^Pages: | tr -dc '0-9')

echo "Starting to remove blank pages from $IN"
for i in $(seq 1 $PAGES)
do
    if [ $(convert -density 25 "$IN[$((i-1))]" -define histogram:unique-colors=true -format %c histogram:info:- | wc -l) -gt 100 ]
    then
        echo "not blank - $(convert -density 25 "$IN[$((i-1))]" -define histogram:unique-colors=true -format %c histogram:info:- | wc -l)"
    else
        echo "blank - $(convert -density 25 "$IN[$((i-1))]" -define histogram:unique-colors=true -format %c histogram:info:- | wc -l)"
    fi
done

echo "finishing removing blank pages from $IN"
