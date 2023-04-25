Log.setLevel('ALL')
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

local nodeName = 'flexArray'

-- Get the array and print out it's contents
Log.info("Get the array and print out it's contents")
local n = Parameters.getNode(nodeName)
local values = n:get()
if (values) then
  Log.info(table.concat(values, ", "))
else
  Log.info("The array is empty.")
end

-- Add new value to array
Log.info("Add new value to array")
writeToArray(nodeName,0, math.tointeger(math.random(0,1000)))
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Append another value to the array
Log.info("Append another value to the array")
writeToArray(nodeName,nil, math.tointeger(math.random(0,1000)))
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Change the second value to 123
Log.info("Change the second value to 123")
writeToArray(nodeName,1, 123)
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Put another value at index 8
Log.info("Put another value at index 8")
writeToArray(nodeName,8, math.tointeger(math.random(0,1000)))
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Set value at index 5 to 999
Log.info("Set value at index 5 to 999")
writeToArray(nodeName,5, 999)
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))


-- Read first five values
Log.info("Read first five values")
for i=0,4 do
  Log.info(string.format("%d",readFromArray(nodeName, i)))
end

-- Read the last value
Log.info("Read the last value")
Log.info(string.format("%d",readFromArray(nodeName)))

-- Delete the first value
Log.info("Delete the first value")
Log.info(string.format("%d",deleteFromArray(nodeName)))
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Delete the last value
Log.info("Delete the last value")
Log.info(string.format("%d",deleteFromArray(nodeName,n:getArraySize()-1)))
n = Parameters.getNode(nodeName)
Log.info(table.concat(n:get(), ", "))

-- Delete all values
Log.info("Delete all values")
for _=0,n:getArraySize()-1 do
  Log.info(string.format("%d",deleteFromArray(nodeName)))
end
n = Parameters.getNode(nodeName)
values = n:get()
if (values) then
  Log.info(table.concat(values, ", "))
else
  Log.info("The array is empty.")
end

--End of Example-------------------------------------------------------------------