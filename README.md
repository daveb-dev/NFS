Nuclear Fracture Simulation (NFS)
=====

"Fork NFS" to create a new MOOSE-based application.

For more information see: [http://mooseframework.org/create-an-app/](http://mooseframework.org/create-an-app/)

#### NFS is a development app specific designed for fracture related simulation in nuclear related materials. It used a specific version of MOOSE and BISON(export controlled) for specific dependency related.
<br/>

#### Make sure that the moose directory is named `./moose_fracture`

## Building
Make sure to change the `MOOSE_DIR` into the correct moose directory, located in the Makefile

```bash
make
```


## Running Test
To run the test suite current resided:


```bash
./run_tests -j 4
```

where 4 is the number of the processors

## Run Main Executables
To run test with samples test, use the following

### serial
```bash
nfs-opt -i input.i
```

### MPI

```bash
mpiexec -n 4 nfs-opt -i input.i
```

where 4 is the number of processors


To see the list of available inputs after successfully compiling **NFS**:<br />
```bash
./nfs-opt --dump > nsf_input.txt
```
