local lua_os_lib = require "lua_os_lib"

--测试函数(指针优化版)
local function plua_os_test()
  --1.返回程序使用的按秒计CPU 时间的近似值
  print(lua_os_lib.clock());

  --2.返回一个包含日期及时刻的字符串或表
  print(lua_os_lib.date());

  --3.当不传参数时, 返回当前时刻
  print(lua_os_lib.time());
  
  --4.返回os.difftime(t1,t2)以秒计算的时刻t1 到t2 的差值
  print(lua_os_lib.difftime(lua_os_lib.time(),lua_os_lib.time()));


  --5.相当于 system(""), 执行shell 命令
  print(lua_os_lib.execute("ls"));
  --5.1: os.execute 复制文件
  --local copy_ret = lua_os_lib.execute("copy ".."luatest.lua".. ",".."luatest.lua.bak")
  --print("copy_ret = "..copy_ret)--copy_ret copy file len
  
  --5.2: os.execute 执行lua 程序(lua 运行lua)
  --lua_os_lib.execute("lua client.lua")--当前文件夹下的client.lua 文件, lua vm 为系统安装的默认lua vm
  --lua_os_lib.execute("3rd/lua/lua examples/client.lua")--指定目标lua vm 执行lua file

  --6.文件或目录-->更名
  print(lua_os_lib.rename("./tmp","./tmp2"));--自己创建tmp file
  
  --7.删除指定名字的文件, 如果函数失败, 返回 nil 加一个错误描述串及出错码
  print(lua_os_lib.remove("./tmp2"));
  
  --8.创建一个临时文件名--实际是创建一个临时字符串, 然后你再用这个字符串创建文件名
  print(lua_os_lib.tmpname());


  --9.返回进程环境变量 varname 的值, 如果该变量未定义, 返回 nil 
  print(lua_os_lib.getenv("USERDOMAIN"))
  print(lua_os_lib.getenv("SystemRoot"))
  print(lua_os_lib.getenv("Os2LibPath"))
  print(lua_os_lib.getenv("ProgramFiles" ))
  print(lua_os_lib.getenv("APPDATA" ))
  print(lua_os_lib.getenv("ALLUSERSPROFILE" ))
  print(lua_os_lib.getenv("CommonProgramFiles" ))
  print(lua_os_lib.getenv("COMPUTERNAME" ))
  print(lua_os_lib.getenv("USERNAME"))
  print(lua_os_lib.getenv("USERPROFILE" ))
  print(lua_os_lib.getenv("ComSpec"))
  print(lua_os_lib.getenv("LOGONSERVER" ))
  print(lua_os_lib.getenv("NUMBER_OF_PROCESSORS" ))
  print(lua_os_lib.getenv("OS"))
  print(lua_os_lib.getenv("PATHEXT" ))
  print(lua_os_lib.getenv("PROCESSOR_ARCHITECTURE" ))
  print(lua_os_lib.getenv("PROCESSOR_IDENTIFIER" ))
  print(lua_os_lib.getenv("PROCESSOR_LEVEL" ))
  print(lua_os_lib.getenv("PROCESSOR_REVISION" ))
  print(lua_os_lib.getenv("USERDOMAIN"))
  print(lua_os_lib.getenv("SystemRoot" ))
  print(lua_os_lib.getenv("TEMP"))

  --10.调用ISO C函数exit 终止宿主程序, lua vm 寄宿的主程序也会退出
  print(lua_os_lib.exit());

end
--执行自测函数(指针优化版)
plua_os_test();



--测试函数(正常版)
local function lua_os_test()
  --1.返回程序使用的按秒计CPU 时间的近似值
  print(os.clock());

  --2.返回一个包含日期及时刻的字符串或表
  print(os.date());

  --3.当不传参数时, 返回当前时刻
  print(os.time());
  
  --4.返回os.difftime(t1,t2)以秒计算的时刻t1 到t2 的差值
  print(os.difftime(os.time(),os.time()));


  --5.相当于 system(""), 执行shell 命令
  print(os.execute("ls"));
  --5.1: os.execute 复制文件
  --local copy_ret = os.execute("copy ".."luatest.lua".. ",".."luatest.lua.bak")
  --print("copy_ret = "..copy_ret)--copy_ret copy file len
  
  --5.2: os.execute 执行lua 程序(lua 运行lua)
  --os.execute("lua client.lua")--当前文件夹下的client.lua 文件, lua vm 为系统安装的默认lua vm
  --os.execute("3rd/lua/lua examples/client.lua")--指定目标lua vm 执行lua file


  --6.文件或目录-->更名
  print(os.rename("./tmp","./tmp2"));--自己创建tmp file
  
  --7.删除指定名字的文件, 如果函数失败, 返回 nil 加一个错误描述串及出错码
  print(os.remove("./tmp2"));
  
  --8.创建一个临时文件名--实际是创建一个临时字符串, 然后你再用这个字符串创建文件名
  print(os.tmpname());


  --9.返回进程环境变量 varname 的值, 如果该变量未定义, 返回 nil 
  print(os.getenv("USERDOMAIN"))
  print(os.getenv("SystemRoot"))
  print(os.getenv("Os2LibPath"))
  print(os.getenv("ProgramFiles" ))
  print(os.getenv("APPDATA" ))
  print(os.getenv("ALLUSERSPROFILE" ))
  print(os.getenv("CommonProgramFiles" ))
  print(os.getenv("COMPUTERNAME" ))
  print(os.getenv("USERNAME"))
  print(os.getenv("USERPROFILE" ))
  print(os.getenv("ComSpec"))
  print(os.getenv("LOGONSERVER" ))
  print(os.getenv("NUMBER_OF_PROCESSORS" ))
  print(os.getenv("OS"))
  print(os.getenv("PATHEXT" ))
  print(os.getenv("PROCESSOR_ARCHITECTURE" ))
  print(os.getenv("PROCESSOR_IDENTIFIER" ))
  print(os.getenv("PROCESSOR_LEVEL" ))
  print(os.getenv("PROCESSOR_REVISION" ))
  print(os.getenv("USERDOMAIN"))
  print(os.getenv("SystemRoot" ))
  print(os.getenv("TEMP"))

  --10.调用ISO C函数exit 终止宿主程序, lua vm 寄宿的主程序也会退出
  print(os.exit());

end
--执行自测函数(正常版)
lua_os_test();

