--< *** 注意: 基础库是不能做指针优化的, 切忌切忌!!  ***>

-- -- -- < 1 >杂项类 -- -- --
--1.0: local 优化基本模式是:
local math = require "math"
local os = require "os"
local string = require "string"
local table = require "table"
local io = require "io"
--local file = require "file"--没有
local package = require "package"
--local utf8 = require "utf8"-没有
local coroutine = require "coroutine"
--这些基本包, lua 支持直接require local 包装成table, 但是你仍然可以用这个库里面的东西, 更全更详细一点
--注意: 对于table 操作, 只要local table 里面有的, 如table.insert, table.remove, 你能用就用, 
--因为直接[] 下标添加可能跟直接全局table.insert 一样, 这样就不是local 了..
--但是如果你已经local table, 直接用就没错了

--1.1: _G 全局变量table --> _G._G=_G, 永恒单一... (局部变量local 只在本文件中有效)
_G.add_val = "just a test message";
--[[
1.全局变量的原形: 其实本质上也是一个table, 它把我们创建的全局变量都保存到一个table里了... 
这个table 默认的名字是: _G, 你可以通过setfenv(1, new_table_name) 更改全局变量table; 
setfenv 参数解析: 
1).第一个参数, 可以是即将要改变环境的函数, 也可以是一个数字. 
数字1代表当前函数, 数字2代表调用当前函数的函数,后面以此类推... 

2).第二个参数, 新的全局环境table... 

PS: 全局函数的作用域是--整个lua 虚拟机, 全局变量不会被lua 自动回收或显式回收, 言外之意是:
全局变量是不会被回收的
]]

--1.2: _VERSION lua 版本字符串
print(_VERSION);

--1.3: assert(); 断言
assert(os.time(),"assert fail message");

--1.4: 中止上一次保护函数调用, 将错误对象 message 返回. 函数 error 永远不会返回...
error(os.time(),"os.time() error message");

--1.5: 接收任意数量的参数, 并将它们的值打印到 stdout ...
print "output to stdout";

--1.6: lua 垃圾回收机--手动控制器
local a = collectgarbage();collectgarbage("collect");--做一次完整的垃圾收集循环。 这是默认选项。 
collectgarbage("stop");--停止垃圾收集器的运行。 在调用重启前，收集器只会因显式的调用运行。
collectgarbage("restart");--重启垃圾收集器的自动运行
collectgarbage("count");--以 K 字节数为单位返回 Lua 使用的总内存数。 这个值有小数部分，所以只需要乘上 1024 就能得到 Lua 使用的准确字节数（除非溢出）。 
collectgarbage("step");--单步运行垃圾收集器。 步长“大小”由 arg 控制。 传入 0 时，收集器步进（不可分割的）一步。 传入非 0 值， 收集器收集相当于 Lua 分配这些多（K 字节）内存的工作。 如果收集器结束一个循环将返回 true 。 
collectgarbage("setpause");--将 arg 设为收集器的 间歇率 （参见 §2.5）。 返回 间歇率 的前一个值。
collectgarbage("setstepmul");--将 arg 设为收集器的 步进倍率 （参见 §2.5）。 返回 步进倍率 的前一个值。 
collectgarbage("isrunning");--返回表示收集器是否在工作的布尔值 （即未被停止）。

--注意: lua vm 里面要加速<块内存变量>重用, 可以在使用完之后调用 value_name = nil, 直接将变量设置为垃圾, 
--     string, table, 等都是块内存, number 则不会被回收


-- -- -- < 2 >装载类 -- -- --
--2.0: require 同一个文件, 一个lua 机里面只装载一份, 重复就返回preload 库中的存档, 自动执行

--2.1: dofile 装载一个文件并执行它, 类似require
local dofile_tbl = dofile("./dofile_text.lua");--需要带后缀
--require 是一次性装载, 只保存一份, 并且自动执行...
--dofile 装一次得一份, 无限叠加, 自动执行

--require 是一次性装载, 只保存一份, 并且自动执行...
--loadfile 装一次得一份, 无限叠加, 不会自动执行


--2.2: 加载一个代码块(chunk), 并执行它...返回空串"", nil, 或是不返回值时, 都表示代码块结束
local test_load = print(load("return 123"));


--2.3: 和 load 类似, 不过是从文件filename 或标准输入(如果文件名未提供)中获取代码块...(但是不执行, 只是装载--类似require) 
local loadfile_tbl = loadfile("./loadfile_text.lua");--需要带后缀
--require 是一次性装载, 只保存一份, 并且自动执行...
--loadfile 装一次得一份, 无限叠加, 不会自动执行


--2.4: pcall 保护模式下运行函数:
--      传入参数, 以<保护模式>调用函数func... 这意味着func 中的任何错误不会抛出 
--      取而代之的是: pcall 会将错误捕获到, 并返回一个状态码... 
--      第一个返回值是状态码(一个布尔量), 当没有错误时, 其为真. 
--      此时, pcall 同样会在状态码后返回所有调用的结果...
--
--      在有错误时, pcall 返回false 加错误消息... 
--local err_no = pcall(func_name);


--2.5: xpcall 与pcall 类型, 只是可以额外设置多一个报错消息...
--local err_no = xpcall(func_name,"xpcall error message!!");



-- -- -- < 3 >元表操作类 -- -- --
--3.1:--如果 object 不包含元表，返回 nil。 否则: 1.如果在该对象的元表中有 "__metatable" 域时返回其关联值; 2.没有时返回该对象的元表。 
local met_table = {};--含元表的table
local __metatable = getmetatable(met_table);
--3.2:
--setmetatable

--3.3:
--rawequal

--3.4:
--rawget

--3.5:
--rawlen

--3.6:
--rawset



-- -- -- < 4 >表迭代器类 -- -- --
--4.1: 将迭代键值对(1,t[1]), (2,t[2]), ... , 直到第一个空键--nil key --> return
local t = {1, 2, 3};
for k,v in ipairs(t) do print(k,v); end


--4.2: 可以用来判断一个表是否为空...
local n_test = {1,nil,"str"};
local n_tmp = nil;
--if n_test ~= nil and type(n_test) == "table" then -- 这句话时很废物的, 是table 就肯定不是nil, nil 也是一个类型
if type(n_test) == "table" then
  local n_tmp = next(n_test, n_tmp);--第二参数 = nil 时, 返回第一个非空key 指向的值(初始键).如果table = nil 则next() 返回nil
                                    --直到遇到最后一个key 之后, next() 返回nil...
                                    --如果不提供第二个参数, 将认为它就是 nil...
  if n_tmp ~= nil then
    print "table is not a {}";--用来判断table 是否为 {}, 有些时候type() = "table", 但table 可能等于{} or 有乱键
  end
end


--4.3: 如果table 有元方法 __pairs, 以table 为参数调用它, 并返回其返回的前三个值...
--     否则, 返回三个值: 1.next() 2.table point 3.nil
local met_table = {};--必须先含有元方法
local v1,v2,v3 = pairs(met_table);--自动取3值



-- -- -- < 5 >拆解, 数字, 类型相关类 -- -- --
--5.1: 如果 index 是个数字, 那么返回参数中第 index 个之后的部分;负的数字会从后向前索引(-1 指最后一个参数). 
--     否则index 必须是字符串 "#".. 此时 select 返回参数的个数
--这个东西可以用来拆解多参数
local function multi_parameter_fxx(...)--拆解多参数, 可以拆解任何类型
  local val_count = select("#",...);--拆解参数栈所需的操作--返回参数栈的总数量
  for i=1, val_count do
    local val = select(i,...);--选定某个栈位置的参数
    print(val);
  end
end
--测试多参数传入拆解函数
multi_parameter_fxx(1,2,3,4,5,6,7,8,9);
--多类型参数测试
multi_parameter_fxx(1,"2","3",nil,5,6,7,8,9);

--5.2: 如果参数已经是一个数字, 或是一个可以转换为数字的字符串, tonumber 就返回这个数字: 否则返回 nil
local to_num = "nil";--反例
local to_num2 = "123";
tonumber(to_num);
tonumber(to_num2);

--5.3: 接受转换任何类型 to be a string
local to_str;
tostring(to_str);

--5.4: 将参数的类型编码为一个字符串返回, 函数可能的返回值有:
--"nil"(一个字符串，而不是 nil 值). "number" "string" "boolean" "table" "function" "thread" "userdata"。 
local get_type_val;
type(get_type_val);
