# mpii-yago

A docker image to implement the MPII YAGO ontology using apache-jena

This image is based on [markbnj/apache-jena](https://github.com/Markbnj/apache-jena)
and adds the commands to install and initialize the YAGO dataset(s).

The makefile will download the YAGO compressed TTL files listed in the yago-files.txt
manifest file the first time it is run. Thereafter it will only download missing or
added files.

## Resources

https://suchanek.name/work/publications/cidr2015.pdf
http://www.mpi-inf.mpg.de/departments/databases-and-information-systems/research/yago-naga/yago/
