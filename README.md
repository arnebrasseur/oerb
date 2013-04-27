# OERB : OpenERP Report Baker

A little tool that takes a text file and turns it into an OpenERP accounting report.

Look at the examples to get a feel for the format, it's a simple hierarchical list with two space indents.

## Simple Example

````
BALANCE
  ACTIVE
    Buildings ! 21
    Machines ! 22
  PASSIF
    Capital ! 40
````

This will link all accounts with a code that starts with `21` to the third line of the report. The first and second lines will simply roll up what's beneath them.

There are three ways to specify the account code prefixes :

* just a number, e.g. '20', this will take all accounts starting with twenty
* comma separated list, e.g. '20,23', will take accounts '20xxx' and '23xxx'
* range using a slash, e.g. '20/23', will take account '20xxx', '21xxx', '22xxx' and '23xxx'

This tool is built on the OOOR library which provides Ruby bindings for the OpenERP XML-RPC API. Run the executable, pass in the necessary OpenERP credentials, and the path of the text file.

## Running it

````
bin/oerp --help
bin/oerp -u user -p password -o hostname -d database input.txt
````
