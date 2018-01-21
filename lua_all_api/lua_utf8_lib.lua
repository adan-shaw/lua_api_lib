local lua_utf8_lib = {};--引用优化api lua utf8库

lua_utf8_lib.char = utf8.char;--将number 转换为utf8 字符串
lua_utf8_lib.charpattern = utf8.charpattern;--用于精确匹配到一个utf8 字节序列的模式(是一个字符串, 并非函数)
                                            --"[\0-\x7F\xC2-\xF4][\x80-\xBF]*" (参见 §6.4.1)
                                            --它假定处理的对象是一个合法的utf8 字符串
                                             
lua_utf8_lib.codepoint = utf8.codepoint;--以整数形式返回str 中 从位置i 到j 间(包括两端)所有字符的编号-pos 
                                        --默认的i 为 1, 默认的j 为 i.. 如果碰上不合法的字节序列, 抛出一个错误..
                                         
lua_utf8_lib.codes = utf8.codes;--对传入字符串进行utf8 拆解, 返回一个utf8 字符集, 每个元素都是一个utf8 char
lua_utf8_lib.len = utf8.len;--返回字符串 s 中 从位置 i 到 j 间 （包括两端） UTF-8 字符的个数
lua_utf8_lib.offset = utf8.offset;
--[[
返回编码在s 中的第n 个字符的开始位置(按字节数) (从位置 i 处开始统计)...负n 则取在位置i 前的字符
当n 是非负数时, 默认的i 是1, 否则默认为#s + 1. 
因此, utf8.offset(s, -n) 取字符串的倒数第n 个字符的位置, 如果指定的字符不在其中或在结束点之后, 函数返回 nil

作为特例, 当n 等于0 时. 此函数返回含有s 第i 字节的那个字符的开始位置

这个函数假定s 是一个合法的utf8 字符串
]]

return lua_utf8_lib;