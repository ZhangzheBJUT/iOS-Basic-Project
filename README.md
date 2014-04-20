##1.SQLite使用封装
#### 数据表结构
![](SqliteTool/01.png?raw=true)


![](SqliteTool/02.png?raw=true)

![](SqliteTool/03.png?raw=true)

详细说明见**SqliteTool**  
  `ZZDBHandler.h`和`ZZDBHandler.m` 实现了对SQLite的最基本操作的封装，包括数据库的打开、关闭、查询、更新等。  
  **Sqlite3DemoExample** 是一个使用ZZDBHandler来进行数据存储的例子。


##2.PDFParse Helper