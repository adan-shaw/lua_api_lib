--这个模块没有库, 只是一些测试样例

--[[
lua 函数调用理念:
first: 每个函数被调用, lua 都会为其分配2 个参数栈, 传入栈和返回栈, 是独立的, 否则你怎样在函数中: 同时引用传入参数和 一边操作, 一边编写返回栈??? 
1. 形参传入: 创建一个参数传入栈, 装载传入参数
2. 参数返回: 创建一个参数返回栈, 装载返回参数

函数返回时, 形参传入栈应该已经没有存在的意义了...
指令读到下一句的时候, 参数返回栈也应该没有存在意义了... 参数已经返回了, 指令已经读到下一句了, 你不用变量装住返回参数栈, lua vm 就给你自动回收!!
 
]]

--1. 多参数传递--实质是传递一个栈, lua 每次函数调用都创建一个栈, 用来存放参数, 但是传递多参数, 并不能拆散这个栈, 
--   因此你不能期待, 你能用一个table 递归装载所有的变量, 真是要传递的时候, 你不如传递一个table, 为什么要传递多参数 ??
local function multi_parameter_func(...)
  print("multi print",...);--多参数二次传递

end
--测试多参数传递
multi_parameter_func("1","2","","3");


--2.lua 内嵌函数 -- 不能带函数名!
local son_func = coroutine.wrap(
  function()
    print "test m2_coroutine";
  end
)


--3.全局函数 -- 不带local 即可
function static_func()
  print "static function test";
end
--测试全局函数
static_func();



--4.这个东西可以用来拆解多参数
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


