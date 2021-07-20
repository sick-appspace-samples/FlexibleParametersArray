
--Start of Functions Scope---------------------------------------------------------

--Writes to a specified array at a specified index, expanding it if needed - will throw errors
--if something's wrong with the values or indices.
--input: arrayName: name of the array to add the values to, index - index to add the value
--(default: appends to the end of array), value - value to write in the array
--@writeToArray(arrayName:string,index:int,value:any)
local function writeToArray(arrayName,index,value)
  local node = Parameters.getNode(arrayName)
  index = index or node:getArraySize()

  assert(index>=0, "Index out of bounds!")
  
  if index >= node:getArraySize() then
    assert(node:setArraySize(index+1), "Index out of bounds!")
    Parameters.setNode(arrayName,node)
  end

  assert(Parameters.set(("%s[%X]"):format(arrayName,index), value), "Wrong value format!")
end

--Deletes an element from a specified index in an array, moving elements behind deleted one
--forward. Returns deleted item, or nil if the array was already empty.
--Will throw errors if indices don't match.
--input: arrayName: name of the array to add the values to, index - index to delete the value
--from (default: 0)
--output: element that was just deleted from the array
--@deleteFromArray(arrayName:string,index:int):any
local function deleteFromArray(arrayName,index)
  local node = Parameters.getNode(arrayName)
  index = index or 0
  
  if node:getArraySize() == 0 then return nil end
  
  assert((index>=0) and (index<node:getArraySize()), "Index out of bounds!")

  local t = node:get()
  local p = table.remove(t,index+1)

  node:set(t)
  node:setArraySize(#t)

  Parameters.setNode(arrayName,node)
  return p
end


--Reads an element from a specified index in an array, and returns it or nil if array was empty.
--Will throw errors if indices don't match.
--input: arrayName: name of the array to add the values to, index - index to read the value
--from (default: last index)
--output: value of the element that was just read from the array
--@readFromArray(arrayName:string,index:int):any
local function readFromArray(arrayName,index)
  local node = Parameters.getNode(arrayName)
  index = index or (node:getArraySize() - 1)
  
  if node:getArraySize() == 0 then return nil end
  
  assert((index>=0) and (index<node:getArraySize()), "Index out of bounds!")

  return Parameters.get(("%s[%X]"):format(arrayName,index))
end

--End of Functions Scope-----------------------------------------------------------

--Start of Example-----------------------------------------------------------------

-- flexArray is a flexible Parameters array of maximum length of 16 and it can store integers

-- Get the array and print out it's contents
print("Get the array and print out it's contents")
local n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Add new value to array
print("Add new value to array")
writeToArray('flexArray',0, math.tointeger(math.random(0,1000)))
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Append another value to the array
print("Append another value to the array")
writeToArray('flexArray',nil, math.tointeger(math.random(0,1000)))
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Change the second value to 123
print("Change the second value to 123")
writeToArray('flexArray',1, 123)
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Put another value at index 8
print("Put another value at index 8")
writeToArray('flexArray',8, math.tointeger(math.random(0,1000)))
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Set value at index 5 to 999
print("Set value at index 5 to 999")
writeToArray('flexArray',5, 999)
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))


-- Read first five values
print("Read first five values")
for i=0,4 do
  print(readFromArray('flexArray', i))
end

-- Read the last value
print("Read the last value")
print(readFromArray('flexArray'))

-- Delete the first value
print("Delete the first value")
print(deleteFromArray('flexArray'))
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Delete the last value
print("Delete the last value")
print(deleteFromArray('flexArray',n:getArraySize()-1))
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

-- Delete all values
print("Delete all values")
for _=0,n:getArraySize()-1 do
  print(deleteFromArray('flexArray'))
end
n = Parameters.getNode('flexArray')
print(table.unpack(n:get()))

--End of Example-------------------------------------------------------------------