local lua_package_lib = {};--引用优化api lua package库

lua_package_lib.require = require;--同一个文件, 一个lua 机里面只装载一份, 重复就返回preload 库中的存档, 自动执行

lua_package_lib.preload = package.preload;--已经加载的库(一般也很少用, 自动匹配, 用户一般不需要自己调用)

--加载库实体--可以单个加载, 但是一般通过指认搜索路径, 再用require 单个加载
lua_package_lib.loaded = package.loaded;--require 控制哪些模块已经被加载的表
lua_package_lib.loadlib = package.loadlib;--让宿主程序动态链接 C 库 libname (单个指认so 库加载)
lua_package_lib.searchers = package.searchers;

--加载库路径指认
lua_package_lib.path = package.path;
lua_package_lib.cpath = package.cpath;--它会使用环境变量 LUA_CPATH_5_3 或 环境变量 LUA_CPATH 初始化
lua_package_lib.searchpath = package.searchpath;



lua_package_lib.config = package.config;--少用

return lua_package_lib;