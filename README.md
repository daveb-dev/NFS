Nuclear Fracture Simulation (NFS)
=====

"Fork NFS" to create a new MOOSE-based application.

For more information see: [http://mooseframework.org/create-an-app/](http://mooseframework.org/create-an-app/)

#### NFS is a development app specific designed for fracture related simulation in nuclear related materials. It used a specific version of MOOSE and BISON(export controlled) for specific dependency related.
<br/>

#### Make sure that the moose directory is named `./moose_fracture`

Building
------
Make sure to change the `MOOSE_DIR` into the correct moose directory, located in the Makefile

`make`
<br />









To see the list of available inputs after successfully compiling **NFS**:<br />
`./nfs-opt --dump > nsf_input.txt`
