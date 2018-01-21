local lua_table_lib = require "lua_table_lib"

--简单的table 打印测试函数(不是正式的)
local function print_tbl(source_tbl)
  --安检
  if type(source_tbl) ~= "table" then
    print "print_tbl >> not a table!!";
    return;
  end
  --打印
  for k,v in ipairs(source_tbl) do
    print("key:",type(k),k);
    print("val",type(v),v);
    print "";
  end
end

--测试函数(指针优化版)
local function plua_table_test()


end
--执行自测函数(指针优化版)
plua_table_test();



--测试函数(正常版)
local function lua_table_test()
  --1.table.concat 将所有table 元素拼接为string
  local t1 = {1,2,3};
  local str = table.concat(t1,",,,");--将所有元素拼接为string
  print(str);
  
  --2.table.insert 插入元素
  table.insert(t1,2);
  table.insert(t1,4,5);
  table.insert(t1,20);--默认在最后一位插入
  print_tbl(t1);
  
  --3.table.remove 删除元素--必须指定位置
  table.remove(t1,0);--找不到对象就不会执行任何操作
  table.remove(t1,1);
  table.remove(t1,3);
  print_tbl(t1);
  
  --4.table.sort 重新排序
  table.sort(t1);
  print_tbl(t1);
  
  --5.lua53 特有的table 操作
  --[[ 将表"t"中从整数索引"f"到整数索引"e"之间(源区间)的元素,
       复制到表"t1"中整数索引"t"及之后的位置(目标区间),
       默认值为: "t" 自己复制自己, 目标区间与源区间可以重叠的...
       ]]
  --[[
  local t = {"12", 34, [8] = "56", m="78", n=90}
  t1 = {}
  table.move(t, 1, 8, 3, t1)
  print("t: ")
  for i,v in pairs(t) do print(i, v) end
  print("t1: ")
  for i,v in pairs(t1) do print(i, v) end
  ]]
  
  --6.数据打包和拆散lua53 特有
  --[[
  --打包
  local ptbl = table.pack("p1","p2","p3","p4","p5");
  print_tbl(ptbl);
  --解包
  local p1,p2,p3,p4,p5 = table.unpack(ptbl);
  print(p1,p2,p3,p4,p5)
  --解包-指定段域
  p2,p3,p4 = table.unpack(ptbl,2,4);--指定段域版
  ]]
  
end
--执行自测函数(正常版)
lua_table_test();