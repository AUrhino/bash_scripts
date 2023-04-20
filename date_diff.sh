#!/bin/bash
date1="2023-01-06 09:00:00"
date2="2023-02-06 12:00:00"
date1_seconds=$(date -d "$date1" +"%s")
date2_seconds=$(date -d "$date2" +"%s")
duration=$(( $date2_seconds - $date1_seconds ))
echo "Time Elapsed: $(($duration/3600)) hours $(($duration %3600 / 60)) minutes and $(($duration % 60)) seconds."
