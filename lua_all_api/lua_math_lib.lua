local lua_math_lib = {};

lua_math_lib.random = math.random;--生产随机数
lua_math_lib.randomseed = math.randomseed;--设随机数种子

lua_math_lib.abs = math.abs;--取绝对值
lua_math_lib.pow = math.pow;--计算x的y次幂
lua_math_lib.sqrt = math.sqrt;--开平方
lua_math_lib.modf = math.modf;--整数和小数部分分拆返回
lua_math_lib.log = math.log;--返回以指定底的 x 的对数, 默认的 base 是 e
lua_math_lib.exp = math.exp;--e的x次方

--lua_math_lib.tointeger = math.tointeger;--如果 x 可以转换为一个整数, 返回该整数. 否则返回 nil -- lua53 特有
--lua_math_lib.type = math.type;--如果 x 是整数, 返回"integer", 如果它是浮点数, 返回"float"..如果 x 不是数字, 返回 nil -- lua53 特有 
--lua_math_lib.ult = math.ult;--无符号比较大小, 绝对值大小比较 -- lua53 特有

--三角函数
lua_math_lib.pi = math.pi;--返回圆周率
lua_math_lib.sin = math.sin;--正弦
lua_math_lib.cos = math.cos;--余弦
lua_math_lib.tan = math.tan;--正切
lua_math_lib.asin = math.asin;--反正弦
lua_math_lib.acos = math.acos;--反余弦
lua_math_lib.atan = math.atan;--反正切

lua_math_lib.ceil = math.ceil;--向上取整(多出0.1 也会+1)
lua_math_lib.floor = math.floor;--向下取整(多出0.9 也不会+1)
lua_math_lib.max = math.max;--一堆数的最大值
lua_math_lib.min = math.min;--一堆数的最小值
--lua_math_lib.maxinteger = math.maxinteger;--最大值的整数部分--lua53 特有
--lua_math_lib.mininteger = math.mininteger;--最小值的整数部分

lua_math_lib.rad = math.rad;--角度转弧度
lua_math_lib.deg = math.deg;--弧度转角度

--lua_math_lib.fmod = math.fmod;--x 除以 y, 将商向零圆整后的余数.(integer/float)--少用
lua_math_lib.huge = math.huge;--浮点数HUGE_VAL, 这个数比任何数字值都大

return lua_math_lib;

--lua 里面随机数算法基本很烂, 每次算出来都会一样的, 同一个种子的话...
--如果以时间为种子代入随机数算法, 则会出现问题:
--[[
local function do_random(_table)
  --执行乱序
  local math_random = math.random;
  local len = #_table;
  local len2 = len - 1;
  local tmp = 0;
  local rand = 0;
  for i=1,len do
    --整除为0, 但是table 没有0 element, 所以这里容易取空nil
    rand = math_random(os.time())%len2+1--防止刚好整除=0
    --交换
    tmp = _table[rand]
    _table[rand] = _table[i]
    _table[i] = tmp
  end
end


--
--同一lua vm 同一时刻内运行这个脚本可能得到相同的随机数, 因为时间种子设定了, 就不会改动...
--你要高频率的改动, 你需要不停转换种子
math.randomseed(os.time())--如果有需要你可以每次都更换种子, 防止随机数僵硬...
math.random(1, 999999)--直接设置范围就不用求余了
--
--高频切换版本--随机率最高
rand = math.random(os.time())%len2+1--防止刚好整除=0
--
randomseed  设随机数种子  

]]
