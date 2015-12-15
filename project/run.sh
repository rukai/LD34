#!/bin/sh


#zip files into .love
zip -r ../herballistic.love *

#run .love
cd ..
love herballistic.love
