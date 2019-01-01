# Expression_Calculator
    该行表达式计算器支持整数和浮点数类型（实质上全部使用double类型）。在算符方面支持加减乘除括号并且按照优先级计算。每行输入一个表达式，且表达式结尾需输入等号；同时还可支持以回车或分号分隔的多个表达式。（即完成了要求1-5）

    LEX文件第一个部分首先定义了YYSTYPE宏，避免被头文件中先定义；头文件包括了一个通过YACC/BISON生成的.tab.h文件和必要的C语言库。设置了必要的标记（包括数字、算符、分隔符、空格）之后，分别为它们设置了不同的模式，其中数字用atof函数转换并返回一个终端符号；算符返回自己本身的字符；分隔符返回另一个终端符号；空格不做处理，从而忽略掉用户在使用时输入的空格。最后一部分补充了yywrap函数从而能够解析多个文件。

    YACC文件第一部分同样定义了宏、包括了必要的头文件,同时声明了最重要的两个内置函数yylex和yyerror。语法规则部分使用multirow来实现多行表达式，使用row来实现输出结果，使用expr、term、fac的正则定义来实现括号和加减乘除的运算（包括实现优先级，fac相当于元表达式一定是数字，通过乘除term实现乘除的高优先级，最后再用term加减expr）。其中在进行除法运算时会判断是否犯下除以0的错误。最后的C代码部分定义了main函数，其中包括了一段输出为用户说明本计算器的用法；定义了yyerror函数从而显示错误信息。
    
    编译过程中，考虑到头文件的因素，应将编译的命令按照顺序执行：

> bison -d cal.y

> flex cal.lex

> gcc cal.tab.c lex.yy.c -o calculator

    然后即可运行程序calculator。先用编译YACC文件生成C文件和头文件cal.tab.h（只有加上-d才能生成头文件），从而再编译包括了上述头文件的LEX文件生成lex.yy.c，最后通过gcc编译生成我们的计算器（将YACC生成的C文件放在前面，因为该文件里面的定义可能会被后者用到）。

