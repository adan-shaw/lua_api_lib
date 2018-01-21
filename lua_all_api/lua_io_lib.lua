local lua_io_lib = {};--引用优化api lua io库

--使用显式的文件句柄: 你可以自由设置file path, 打开n 个file
--使用显式文件句柄, io.open 会返回一个文件句柄, 且所有的操作都由该文件句柄的方法来提供
--表io 中也提供了三个 和 C 中含义相同的预定义文件句柄： io.stdin， io.stdout， 以及 io.stderr

--除非另有说明, I/O 函数在出错时都返回 nil (第二个返回值为错误消息, 第三个返回值为系统相关的错误码)
--成功时返回与 nil 不同的值...
--在非POSIX 系统上, 根据错误码取出错误消息的过程可能并非线程安全的, 因为这使用了 C 的全局变量 errno

--注意: io 库也是基于file 库说明, 类似io.output():flush() 的调用是成立的, 这样你就可以很轻松地控制冲刷缓冲区大小了



--标准流(由于lua 机是单线程的, 所以这三个流实际是全局唯一的)
lua_io_lib.stderr = io.stderr;
lua_io_lib.stdin = io.stdin;
lua_io_lib.stdout = io.stdout;

lua_io_lib.open = io.open;
--[[
io.open() 这个函数用字符串mode 指定的模式打开一个文件, 返回新的文件句柄...
当出错时, 返回nil 加错误消息...
mode 字符串可以是下列任意值：
  "r": 读模式（默认）
  "w": 写模式
  "a": 追加模式
  "r+": 更新模式, 所有之前的数据都保留
  "w+": 更新模式, 所有之前的数据都删除
  "a+": 追加更新模式, 所有之前的数据都保留, 只允许在文件尾部做写入
  
mode 字符串可以在最后加一个 'b', 这会在某些系统上以二进制方式打开文件 
]]
lua_io_lib.close = io.close;--等价于file:close(), 不给出file 时将关闭默认输出文件
lua_io_lib.read = io.read;--等价于 io.input():read(···)
lua_io_lib.write = io.write;--io.output():write(···)
lua_io_lib.input = io.input;--用文件名调用它时, (以文本模式)来打开该名字的文件, 并将文件句柄设为默认输入文件...
                            --如果用文件句柄去调用它, 就简单的将该句柄设为默认输入文件...
                            --如果调用时不传参数, 它返回当前的默认输入文件
                            
lua_io_lib.output = io.output;--类似于io.input, 不过都针对默认输出文件操作
lua_io_lib.flush = io.flush;--io.output():flush()

lua_io_lib.type = io.type;--检查obj 是否是合法的文件句柄: 如果 obj 它是一个打开的文件句柄, 返回字符串 "file"...
                          --如果 obj 是一个关闭的文件句柄, 返回字符串 "closed file"...
                          --如果 obj 不是文件句柄, 返回 nil 

lua_io_lib.popen = io.popen;--这个函数和系统有关, 不是所有的平台都提供--少用
lua_io_lib.tmpfile = io.tmpfile;--返回一个临时文件的句柄, 这个文件以更新模式打开, 在程序结束时会自动删除

lua_io_lib.lines = io.lines;--以读模式打开指定的文件名并返回一个迭代函数：
                            --此迭代函数的工作方式和用一个已打开的文件去调用file:lines(···) 得到的迭代器相同...
                            --
                            --当迭代函数检测到文件结束, 它不返回值(让循环结束)并自动关闭文件...
                            --调用io.lines() （不传文件名） 等价于 io.input():lines("*l")
                            --即: 它将按<行迭代>标准输入文件, 在此情况下, 循环结束后它不会关闭文件...
                            --在出错的情况下, 函数抛出错误而不是返回错误码


return lua_io_lib;

