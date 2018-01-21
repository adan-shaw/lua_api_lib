local lua_string_lib = require "lua_string_lib"

--string_dump_test 装载测试函数
local function string_dump_test()
  print "it's okay!!";
end


--测试函数(指针优化版)
local function plua_string_test()
  --1.单字符与数字间的转换
  lua_string_lib.byte("abc",1);--a
  lua_string_lib.byte("abc",-1);--c

  lua_string_lib.char(97);-->a 的asc 码
  
  --2.将字符串函数, 转换为二进制码--> 用于网络传输函数的操作(即是序列化...)
  local func_point = lua_string_lib.dump(string_dump_test);--封包
  local load_func = loadstring(func_point);--反装载
  load_func();--执行函数
  
  --3.匹配字符串--返回第一个匹配字符串 的起始及终点位置的索引, 否则返回nil
  print(lua_string_lib.find("aabc","a"));--1 1
  print(lua_string_lib.find("abc","ab"));--1 2
  print(lua_string_lib.find("abc","ac"));--nil
  --返回第一个匹配的字符串--仅一串
  print(lua_string_lib.match("aaaa","aa"));
  --string.gmatch--返回一个迭代器函数(不会用)
  
  --4.查找字符串
  print(lua_string_lib.sub("abc",1,1));--a
  print(lua_string_lib.sub("abc",1,2));--ab
  print(lua_string_lib.sub("abc",1,3));--abc
  
  --5.字符串查找替换
  print(lua_string_lib.gsub("abc","a","d"));--dbc -- 默认全部替换
  print(lua_string_lib.gsub("abca","a","d",1));--dbca--只替换一个
  print(lua_string_lib.gsub("abcaaaa","a","d",2));--dbcdaaa--替换2个
 
  --*****************************************************************
  --高级用法...
  --*****************************************************************
  x = lua_string_lib.gsub("home = $HOME, user = $USER", "%$(%w+)", os.getenv);
  print(x);--获取环境变量: $HOME and $USER, 格式基本都是: %$(%w+)
  --> x="home = /home/roberto, user = roberto"
     
  local t = {name="lua", version="5.3"};
  x = lua_string_lib.gsub("$name-$version.tar.gz", "%$(%w+)", t);
  print(x);--从一个table 里面获取变量字符串, 格式基本都是: %$(%w+)
  --> x="lua-5.3.tar.gz" 
  --*****************************************************************
  
  --6.字符串大小写转换
  print(lua_string_lib.lower("WWcA"));--将str 中的大写字母全部转换成小写
  print(lua_string_lib.upper("aaWSb"));--将str 中的小写字母转全部换成大写
  
  --7.返回字符串长度
  print(lua_string_lib.len("fuck you bitch"));
  
  --8.字符串拼接
  local cat1 = "cat1";
  local cat2 = "cat2";
  print(cat1..cat2);--.. 两点法, 简单拼接
  
  --9.re pint 自我打印--版本不同, 很纠结... 有的版本是不一样的, 慎用
  print(lua_string_lib.rep("abc", 5))--ababababab
  
  --10.字符串序列反转
  print(lua_string_lib.reverse("abc"))--cba
  
  --11.
  --local a = "xxx";--5.3 特有, 不建议用
  --string.pack(a,a);
  --string.pack(a,"c","b","a");
  --print(a);
  
  --12.字符串格式化
  print(lua_string_lib.format("i want %d %s", 5, "apples"))--i want 5 apples
  

end
--执行自测函数(指针优化版)
plua_string_test();



--测试函数(正常版)
local function lua_string_test()
  --1.单字符与数字间的转换
  string.byte("abc",1);--a
  string.byte("abc",-1);--c

  string.char(97);-->a 的asc 码
  
  --2.将字符串函数, 转换为二进制码--> 用于网络传输函数的操作(即是序列化...)
  local func_point = string.dump(string_dump_test);--封包
  local load_func = loadstring(func_point);--反装载
  load_func();--执行函数
  
  --3.匹配字符串--返回第一个匹配字符串 的起始及终点位置的索引, 否则返回nil
  print(string.find("aabc","a"));--1 1
  print(string.find("abc","ab"));--1 2
  print(string.find("abc","ac"));--nil
  --返回第一个匹配的字符串--仅一串
  print(string.match("aaaa","aa"));
  --string.gmatch--返回一个迭代器函数(不会用)
  
  --4.查找字符串
  print(string.sub("abc",1,1));--a
  print(string.sub("abc",1,2));--ab
  print(string.sub("abc",1,3));--abc
  
  --5.字符串查找替换
  print(string.gsub("abc","a","d"));--dbc -- 默认全部替换
  print(string.gsub("abca","a","d",1));--dbca--只替换一个
  print(string.gsub("abcaaaa","a","d",2));--dbcdaaa--替换2个
 
  --*****************************************************************
  --高级用法...
  --*****************************************************************
  x = string.gsub("home = $HOME, user = $USER", "%$(%w+)", os.getenv);
  print(x);--获取环境变量: $HOME and $USER, 格式基本都是: %$(%w+)
  --> x="home = /home/roberto, user = roberto"
     
  local t = {name="lua", version="5.3"};
  x = string.gsub("$name-$version.tar.gz", "%$(%w+)", t);
  print(x);--从一个table 里面获取变量字符串, 格式基本都是: %$(%w+)
  --> x="lua-5.3.tar.gz" 
  --*****************************************************************
  
  --6.字符串大小写转换
  print(string.lower("WWcA"));--将str 中的大写字母全部转换成小写
  print(string.upper("aaWSb"));--将str 中的小写字母转全部换成大写
  
  --7.返回字符串长度
  print(string.len("fuck you bitch"));
  
  --8.字符串拼接
  local cat1 = "cat1";
  local cat2 = "cat2";
  print(cat1..cat2);--.. 两点法, 简单拼接
  
  --9.re pint 自我打印--版本不同, 很纠结... 有的版本是不一样的, 慎用
  print(string.rep("abc", 5))--ababababab
  
  --10.字符串序列反转
  print(string.reverse("abc"))--cba
  
  --11.
  --local a = "xxx";--5.3 特有, 不建议用
  --string.pack(a,a);
  --string.pack(a,"c","b","a");
  --print(a);
  
  --12.字符串格式化
  print(string.format("i want %d %s", 5, "apples"))--i want 5 apples
  

  
end
--执行自测函数(正常版)
lua_string_test();