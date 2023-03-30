local BinaryFormat = package.cpath:match("%p[\\|/]?%p(%a+)")
local system = ''
if BinaryFormat == "dll" then
  system = "Windows"
elseif BinaryFormat == "so" then
  system = "Linux"
elseif BinaryFormat == "dylib" then
  system = "MacOS"
end
BinaryFormat = nil

return system
