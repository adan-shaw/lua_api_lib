--[[
lua VM对string 的管理机制为: 同一个lua vm 中string 永远只保留一份唯一 的copy...
所以 string使用 = 赋值操作, 实质上是引用已经存在的string or 新建一份全新的string
]]

local lua_string_lib = {};--引用优化api lua string库

lua_string_lib.byte = string.byte;--单字符转数字
lua_string_lib.char = string.char;--数字转单字符

lua_string_lib.dump = string.dump;--将字符串函数, 转换为二进制码, 就可以传递这个函数出去了... 网络发送

lua_string_lib.find = string.find;--返回第一个匹配字符串的起始 and 结束位--失败返回nil
lua_string_lib.match = string.match;--返回第一个匹配字符串的--失败返回nil
lua_string_lib.gmatch = string.gmatch;--不会用

lua_string_lib.sub = string.sub;--查找起始 and 结束位, 成功返回找到的字符串, 失败返回nil
lua_string_lib.gsub = string.gsub;--查找替换

lua_string_lib.lower = string.lower;--字符串全部转换为小写
lua_string_lib.upper = string.upper;--字符串全部转换为大写

lua_string_lib.len = string.len;--返回字符串长度

lua_string_lib.rep = string.rep;--re pint 自我打印

lua_string_lib.reverse = string.reverse;--字符串序列反转


--5.3 特有, 不建议用 !!
--lua_string_lib.pack = string.pack;
--lua_string_lib.unpack = string.unpack;
--lua_string_lib.packsize = string.packsize;


lua_string_lib.format = string.format;--格式化字符串
--[[
%c - 接受一个数字, 并将其转化为ASCII码表中对应的字符
%d, %i - 接受一个数字并将其转化为有符号的整数格式
%o - 接受一个数字并将其转化为八进制数格式
%u - 接受一个数字并将其转化为无符号整数格式
%x - 接受一个数字并将其转化为十六进制数格式, 使用小写字母
%X - 接受一个数字并将其转化为十六进制数格式, 使用大写字母
%e - 接受一个数字并将其转化为科学记数法格式, 使用小写字母e
%E - 接受一个数字并将其转化为科学记数法格式, 使用大写字母E
%f - 接受一个数字并将其转化为浮点数格式
%g(%G) - 接受一个数字并将其转化为%e(%E, 对应%G)及%f中较短的一种格式
%q - 接受一个字符串并将其转化为可安全被Lua编译器读入的格式
%s - 接受一个字符串并按照给定的参数格式化该字符串
]]

return lua_string_lib;