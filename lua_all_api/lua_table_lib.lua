--[[
1.table 有两种形态: array or hash 
  当key 全部为number 时, table 默认为array, 
  当key 有一个不为number 时, table 默认为hash
  
  table key 并非一定要统一类型, 而且只有统一为number 时才有hash 特性可用
  table key 全为number 时, 你可以执行排序和快速下表索引...
  在特性下操作table, 删除一个元素, 后面的元素会自动向前推一位
  
  table key 非number 时, 索引使用: table_name.key_name
  
  注意: 为了防止出错, table cp and 遍历的情况, 最好还是用ipairs 迭代器比较恰当
  
2.table 是一个hash, key 会自动排序(当key = number 时), value 不会自动排序...
  执行sort 重排序可以对value 进行排序(只对value=number 有效)
  
3.# 可以取table 的长度, 但是只对table_key = number 的时候有效
  遇到第一个nil 值或table 结束位key, 就返回以上所扫描的值
  
4.table 嵌套:
table 同样支持内嵌, 这会很有意思, 例如这样:
local config = {
                mysql = {},
                redis = {}, 
                redisrole = {}, 
                redisroleid = {}
}
return config


]]

local lua_table_lib = {};--引用优化api lua table库

lua_table_lib.concat = table.concat;--将table 里面所有的元素拼接成为一个string, 第二个参数为分隔符号
                                    
lua_table_lib.insert = table.insert;--table 原生插入操作
lua_table_lib.remove = table.remove;--table 原生删除操作(会引发整个table 缩进)
lua_table_lib.sort = table.sort;    --对value = number 的(hash 特性的table) 进行重排

--lua53 特有table 块cp
--lua_table_lib.move = table.move;  --cp table 中的[key1,key2] 下标内的值, cp到另一个table key=key3 的后面, 必须是正数number
                                    --可以自己复制自己~~!
--lua53 特有--数据打包和拆散
--lua_table_lib.pack = table.pack;    --自动用key = number 对一堆元素进行打包
--lua_table_lib.unpack = table.unpack;--解包key = number 的table, 按照多参数的模式返回...

return lua_table_lib;

--[[
将表"t"中从整数索引"f"到整数索引"e"之间(源区间)的元素,
复制到表"t1"中整数索引"t"及之后的位置(目标区间),
默认值为: "t" 自己复制自己, 目标区间与源区间可以重叠的...

t = {"12", 34, [8] = "56", m="78", n=90}
t1 = {}
table.move(t, 1, 8, 3, t1)
print("t: ")
for i,v in pairs(t) do print(i, v) end
print("t1: ")
for i,v in pairs(t1) do print(i, v) end
]]