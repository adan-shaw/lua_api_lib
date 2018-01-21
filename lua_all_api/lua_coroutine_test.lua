local lua_coroutine_lib = require "lua_coroutine_lib"

--测试函数(指针优化版)
local function pcoroutine_test()
  --1.创建一个协程内存块并返回该内存块的指针
  local m1_coroutine = lua_coroutine_lib.create(
    function()
      print "test m1_coroutine";
      lua_coroutine_lib.yield();--挂起协程1
      print "test m11_coroutine";--挂起之后并不会输出
    end
  )
  if m1_coroutine == nil or type(m1_coroutine) ~= "thread" then
    print("lua_coroutine_lib >>: coroutine.create() fail");
  end
  print(type(m1_coroutine),m1_coroutine);
  
  --2.创建并马上调入lua vm 线程版本, 相当与create + resume
  local m2_coroutine = lua_coroutine_lib.wrap(
    function()
      print "test m2_coroutine";
    end
  )
  if m2_coroutine == nil or type(m2_coroutine) ~= "function" then
    print("lua_coroutine_lib >>: coroutine.wrap() fail");
  end
  print(type(m2_coroutine),m2_coroutine);
  m2_coroutine();--执行协程函数
  
  --3.执行m1_coroutine-->结果: test m2_coroutine 比 test m1_coroutine 早打印
  print(lua_coroutine_lib.resume(m1_coroutine));
  
  --4.查看协程是否可以挂起--同样只能传入thread 类型
  --print(coroutine.isyieldable(m1_coroutine));--5.3 才有, 5.1 不支持
  
  --5.执行挂起协程操作(不能挂起主线程... 不能在非协程函数中调用)
  --coroutine.yield();
  
  --6.查看协程的状态--必须传入thread 类型
  print(lua_coroutine_lib.status(m1_coroutine));
  
  --7.返回一个正在跑的协程id 号--少用!!
  local id1_coroutine = lua_coroutine_lib.running(m1_coroutine);
  print(id1_coroutine);
 
  --8.唤醒已经挂起的协程1
  print(lua_coroutine_lib.resume(m1_coroutine));
end
--执行自测函数(指针优化版)
pcoroutine_test();



--测试函数(正常版)
local function coroutine_test()
  --1.创建一个协程内存块并返回该内存块的指针
  local m1_coroutine = coroutine.create(
    function()
      print "test m1_coroutine";
      coroutine.yield();--挂起协程1
      print "test m11_coroutine";--挂起之后并不会输出
    end
  )
  if m1_coroutine == nil or type(m1_coroutine) ~= "thread" then
    print("lua_coroutine_lib >>: coroutine.create() fail");
  end
  print(type(m1_coroutine),m1_coroutine);
  
  --2.创建并马上调入lua vm 线程版本, 相当与create + resume
  local m2_coroutine = coroutine.wrap(
    function()
      print "test m2_coroutine";
    end
  )
  if m2_coroutine == nil or type(m2_coroutine) ~= "function" then
    print("lua_coroutine_lib >>: coroutine.wrap() fail");
  end
  print(type(m2_coroutine),m2_coroutine);
  m2_coroutine();--执行协程函数
  
  --3.执行m1_coroutine-->结果: test m2_coroutine 比 test m1_coroutine 早打印
  print(coroutine.resume(m1_coroutine));
  
  --4.查看协程是否可以挂起--同样只能传入thread 类型
  --print(coroutine.isyieldable(m1_coroutine));--5.3 才有, 5.1 不支持
  
  --5.执行挂起协程操作(不能挂起主线程... 不能在非协程函数中调用)
  --coroutine.yield();
  
  --6.查看协程的状态--必须传入thread 类型
  print(coroutine.status(m1_coroutine));
  
  --7.返回一个正在跑的协程id 号--少用!!
  local id1_coroutine = coroutine.running(m1_coroutine);
  print(id1_coroutine);
 
  --8.唤醒已经挂起的协程1
  print(coroutine.resume(m1_coroutine));
end
--执行自测函数(正常版)
coroutine_test();



