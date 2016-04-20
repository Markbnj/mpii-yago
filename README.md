# mpii-yago

A docker image to implement the MPII YAGO ontology using apache-jena

This image is based on [markbnj/apache-jena](https://github.com/Markbnj/apache-jena)
and adds the commands to install and initialize the YAGO dataset(s).

The build will download and unpack the yago ontology in turtle (.ttl) format
if it doesn't exist in the ttl/ directory. The file is packed in .7z format
so the build requires pz7ip-full.

`sudo apt-get install p7zip-full`

## Resources

https://suchanek.name/work/publications/cidr2015.pdf
http://www.mpi-inf.mpg.de/departments/databases-and-information-systems/research/yago-naga/yago/
