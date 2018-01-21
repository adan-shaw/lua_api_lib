local lua_package_lib = require "lua_package_lib";--引用优化api lua package库


--2.6: <注意: require 始终返回一个table, nil or table..但是table 不一定绝对安全, table 中的项可能key = nil >
--           如果装载的key = nil, 则报错：lua attempt to call a nil value
--local req_tmp = require "lua_file";--默认省缺 .lua, 也可以是路径:
--local req_tmp2 = require "./test/lua_file"
--利用require 你可以实现面向对象编程...

--测试函数(指针优化版)
local function plua_package_test()
  --1. require(mod_name) 加载一个模块
  --这个函数首先查找package.loaded 表, 检测mod_name 是否被加载过..
  --如果被加载过, require 返回package.loaded[mod_name] 中保存的值..
  --
  --否则, 它试着为模块寻找加载器:
  --1.1: 首先require 查找package.preload[mod_name], 如果这里有一个值, 这个值(必须是一个函数)就是那个加载器.
  --1.2: 否则require 使用Lua 加载器去查找package.path 的路径...
  --1.3: 如果查找失败, 接着使用C 加载器去查找package.cpath 的路径...
  --1.4: 如果都失败了, 再尝试<一体化>加载器(参见package.searchers)
  --
  --失败: 如果在加载或运行模块时有错误, 或是无法为模块找到加载器, require 都会抛出错误

  --2.package.preload -- 被加载过的table
  
  
  --******************************************************
  --用; 号分割path 字符串, 用.. 来拼接字符串, 用? 来做通用匹配--表示所有的lua file...* 应该也可以
  --******************************************************
  --3.package.path -- lua file 加载器--路径指派
  package.path = package.path .. ";<file_path>\?.lua"; 
  
  --4.package.cpath -- c so 动态链接库加载器--路径指派
  package.cpath = package.cpath .. ";<file_path>\?.lua"; 
  
  --5.package.searchpath -- 一体化-加载器--路径指派
  package.searchpath = package.searchpath .. ";<file_path>\?.lua"; 
  --******************************************************
  
  
end
--执行自测函数(指针优化版)
plua_package_test();

