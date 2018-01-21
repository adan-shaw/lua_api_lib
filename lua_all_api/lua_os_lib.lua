local lua_os_lib = {};--引用优化--lua os 库

--时间类
lua_os_lib.clock = os.clock;--返回程序使用的按秒计CPU 时间的近似值
lua_os_lib.date = os.date;--返回一个包含日期及时刻的字符串或表
lua_os_lib.time = os.time;--当不传参数时, 返回当前时刻
lua_os_lib.difftime = os.difftime;--返回os.difftime(t1,t2)以秒计算的时刻t1 到t2 的差值

lua_os_lib.execute = os.execute;--相当于 system(""), 执行shell 命令
                                   --命令成功运行完毕, 第一个返回值=true. 否则第一个返回值=nil...
lua_os_lib.exit = os.exit;--调用ISO C函数exit 终止宿主程序, lua vm 寄宿的主程序也会退出
                             --返回true = EXIT_SUCCESS;返回false = EXIT_FAILURE

--文件操作类
lua_os_lib.remove = os.remove;--删除指定名字的文件, 如果函数失败, 返回 nil 加一个错误描述串及出错码
lua_os_lib.rename = os.rename;--文件或目录-->更名
lua_os_lib.tmpname = os.tmpname;--创建一个临时文件名--实际是创建一个临时字符串, 然后你再用这个字符串创建文件名


lua_os_lib.getenv = os.getenv;--返回进程环境变量 varname 的值, 如果该变量未定义, 返回 nil 
lua_os_lib.setlocale = os.setlocale;--少用


return lua_os_lib;

--[[
os.date会将日期格式化为一个字符串如下:
%a      一星期中天数的简写                      （Wed）
%A      一星期中天数的全称                      （Wednesday）
%b      月份的简写                                  （Sep）
%B      月份的全称                                  （September）
%c      日期和时间                                   （09/16/98 23:48:10）
%d      一个月中的第几天                        （16）[0 ~ 31]
%H      24小时制中的小时数                      （23）[00 ~ 23]
%I      12小时制中的小时数                       （11）[01 ~ 12]
%j      一年中的第几天                             （259）[01 ~ 366]
%M      分钟数                                       （48）[00 ~ 59]
%m      月份数                                       （09）[01 ~ 12]    
%P      "上午(am)" 或 "下午(pm)"               (pm)
%S      秒数                                          （10）[00 ~ 59]
%w      一星期中的第几天                         （3）[0 ~ 6 = 星期天 ~ 星期六]

%W　　一年中的第几个星期　　　　　　　　0 ~ 52
%x      日期                                          （09/16/98）
%X      时间                                          （23:48:10）
%y      两位数的年份                               （90）[00 ~ 99]
%Y      完整的年份                                 （2009）
%%      字符串'%'

print(os.date("today is %A, in %B"))      -->today is Tuesday, in May

]]