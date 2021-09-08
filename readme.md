## FlexibleParametersArray
Using Parameters arrays of variable length

### Description
This sample shows how to proceed with usage of Parameters arrays of unfixed length
in lua script. It uses the Parameters to create a definition of new array, which
will be then filled by the script. The usage of Parameters.Node CROWN allows for
extending the array, which is not doable the way the Parameters array work -
one can't use **Parameter.set('myArray\[x\]')** to add new elements to the flexible
array. The example contains three functions that can be directly used in any context
related to handling the arrays from Parameters.

### HowToRun
To demo this sample, it must be loaded to any device or the emulator. The output
of the consumer function can be seen at the console.

### Topics
Programming-Pattern, Parameters, Sample, SICK-AppSpace