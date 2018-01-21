local lua_coroutine_lib = {};--引用优化api lua 协程库
lua_coroutine_lib.create = coroutine.create;
lua_coroutine_lib.resume = coroutine.resume;
lua_coroutine_lib.yield = coroutine.yield;
lua_coroutine_lib.isyieldable = coroutine.isyieldable;
lua_coroutine_lib.status = coroutine.status;
lua_coroutine_lib.wrap = coroutine.wrap;
lua_coroutine_lib.running = coroutine.running;

--1.创建协程： 实际只是创建协程内存块, 内存块共享线程时间片, 来模拟多线程... 创建后并不会自动启动, 
--  协程不是真实线程, 协程启动还需要线程调入, 调用coroutine.resume() 就可以让协程想有时间片竞争权
--
--1.local m1_coroutine = coroutine.create(--创建一个协程内存块并返回该内存块的指针thread
--    function()
--      print "test";
--    end
--  )
--  
--2.coroutine.resume(m1_coroutine) 调协程入lua vm, 注意: 一个lua vm 永远只有一个线程, 协程有了使用权就有竞争性

--3.coroutine.isyieldable(m1_coroutine) 查看协程是否可以挂起(lua 5.3 才有的api)

--4.coroutine.yield(m1_coroutine) 执行挂起协程操作--(不能挂起主线程... 不能在非协程函数中调用)

--5.coroutine.status(m1_coroutine) 查看协程的状态--必须传入thread 类型
    --当协程正在运行 "running"
    --如果协程调用yield 挂起或是还没有开始运行 "suspended"
    --如果协程是活动的, 都并不在运行(即它正在延续其它协程) "normal"
    --如果协程运行完主体函数或因错误停止 "dead"
--6.local m2_coroutine = coroutine.wrap(--返回一个函数指针, 每次调用这个函数指针的时候, 协程才会被启动
--    function()                        --该函数创建的协程自动进入等待, 协程函数被调用时才会被唤醒
--      print "test";
--    end
--  )

--7.local id1_coroutine = coroutine.running(m1_coroutine) 返回一个正在跑的协程id 号

--**********************************************************************
--8.skynet 里面没有真实线程, 最高级别的其实只是skynet.newservice() 里面创建出来的lua vm 共享机
--  每个共享机都共同享有8 个默认工作线程的时间片使用权, 一旦阻塞就切换...
--  skynet 和lua vm 都是仿机器设计的虚拟程序中的优品
--**********************************************************************

return lua_coroutine_lib;
