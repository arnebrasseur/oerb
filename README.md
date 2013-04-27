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

This tool is built on the OOOR library which provides Ruby bindings for the OpenERP XML-RPC API. Run the executable, pass in the necessary OpenERP credentials, and the path of the text file.

## Running it

````
bin/oerp --help
Usage: oerp [options] [input file]
    -u, --username USERNAME          OpenERP username
    -p, --password PASSWORD          OpenERP password
    -d, --domain DOMAIN              OpenERP domain/host
    -P, --port PORT                  OpenERP port
    -y, --dry-run                    Dry run, leave the database unchanged
    -h, --help                       Print this help message
````
