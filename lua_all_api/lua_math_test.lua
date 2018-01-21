local lua_math_lib = require "lua_math_lib";--引用优化api lua math库
local lua_os_lib = require "lua_os_lib"
--测试函数(指针优化版)
local function plua_math_test()
  --1.随机数
  lua_math_lib.randomseed(lua_os_lib.time());--设置随机数种子
  print(lua_math_lib.random(5,90));--生成[5,59] 的随机数
  print(lua_os_lib.time());--直接在区间[0,os.time()] 中随机一个数
  
  --2.
  print(lua_math_lib.abs(-2018.111));--取绝对值
  print(lua_math_lib.pow(2,16));--计算x的y次幂
  print(lua_math_lib.sqrt(65536));--开平方
  print(lua_math_lib.modf(65536.12345));--整数和小数部分分拆返回
  print(lua_math_lib.log(54.598150033144));--返回以指定底的 x 的对数, 默认的 base 是 e
  print(lua_math_lib.log(2,2));--log 2 为底的2
  print(lua_math_lib.exp(3));--e的x次方
  
  --print(math.tointeger(123.12));--如果 x 可以转换为一个整数, 返回该整数. 否则返回 nil--lua53 特有
  --print(math.type(123.12));--如果 x 是整数, 返回"integer", 如果它是浮点数, 返回"float"..如果 x 不是数字, 返回 nil
  --print(math.type(123));
  --print(math.ult(123.12,124.12));--无符号比较大小, 绝对值大小比较
  --print(math.ult(123.12,123.122));--无符号比较大小, 绝对值大小比较
  
  print(lua_math_lib.pi);--返回圆周率
  print(lua_math_lib.sin(30));--正弦
  print(lua_math_lib.cos(60));--余弦
  print(lua_math_lib.tan(45));--正切
  print(lua_math_lib.asin(0.5));--反正弦
  print(lua_math_lib.acos(0.5));--反余弦
  print(lua_math_lib.atan(1));--反正切
  
  print(lua_math_lib.ceil(8.1));--向上取整(多出0.1 也会+1)
  print(lua_math_lib.ceil(8.0));
  print(lua_math_lib.floor(8.9));--向下取整(多出0.9 也不会+1)
  print(lua_math_lib.max(1,2,3,4,5));--一堆数的最大值
  print(lua_math_lib.min(1,2,3,4,5));--一堆数的最小值
  --print(math.maxinteger(1.1,2.2,3.3,4.4,5.5));--最大值的整数部分
  --print(math.mininteger(1.1,2.2,3.3,4.4,5.5));--最小值的整数部分

  print(lua_math_lib.rad(180));--角度转弧度
  print(lua_math_lib.deg(lua_math_lib.pi));--弧度转角度

  --print(math.fmod());--x 除以 y, 将商向零圆整后的余数.(integer/float) 
  print(lua_math_lib.huge);--浮点数HUGE_VAL, 这个数比任何数字值都大

end
--执行自测函数(指针优化版)
plua_math_test();



--测试函数(正常版)
local function lua_math_test()
  --1.随机数
  math.randomseed(os.time());--设置随机数种子
  print(math.random(5,90));--生成[5,59] 的随机数
  print(os.time());--直接在区间[0,os.time()] 中随机一个数
  
  --2.
  print(math.abs(-2018.111));--取绝对值
  print(math.pow(2,16));--计算x的y次幂
  print(math.sqrt(65536));--开平方
  print(math.modf(65536.12345));--整数和小数部分分拆返回
  print(math.log(54.598150033144));--返回以指定底的 x 的对数, 默认的 base 是 e
  print(math.log(2,2));--log 2 为底的2
  print(math.exp(3));--e的x次方
  
  --print(math.tointeger(123.12));--如果 x 可以转换为一个整数, 返回该整数. 否则返回 nil--lua53 特有
  --print(math.type(123.12));--如果 x 是整数, 返回"integer", 如果它是浮点数, 返回"float"..如果 x 不是数字, 返回 nil
  --print(math.type(123));
  --print(math.ult(123.12,124.12));--无符号比较大小, 绝对值大小比较
  --print(math.ult(123.12,123.122));--无符号比较大小, 绝对值大小比较
  
  print(math.pi);--返回圆周率
  print(math.sin(30));--正弦
  print(math.cos(60));--余弦
  print(math.tan(45));--正切
  print(math.asin(0.5));--反正弦
  print(math.acos(0.5));--反余弦
  print(math.atan(1));--反正切
  
  print(math.ceil(8.1));--向上取整(多出0.1 也会+1)
  print(math.ceil(8.0));
  print(math.floor(8.9));--向下取整(多出0.9 也不会+1)
  print(math.max(1,2,3,4,5));--一堆数的最大值
  print(math.min(1,2,3,4,5));--一堆数的最小值
  --print(math.maxinteger(1.1,2.2,3.3,4.4,5.5));--最大值的整数部分
  --print(math.mininteger(1.1,2.2,3.3,4.4,5.5));--最小值的整数部分

  print(math.rad(180));--角度转弧度
  print(math.deg(math.pi));--弧度转角度

  --print(math.fmod());--x 除以 y, 将商向零圆整后的余数.(integer/float) 
  print(math.huge);--浮点数HUGE_VAL, 这个数比任何数字值都大
  
end
--执行自测函数(正常版)
lua_math_test();
