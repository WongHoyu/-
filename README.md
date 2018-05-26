# - 第一次将项目提交到Github上
## - swift语言实践晋级第6章  Swift4.0版本！！书本是swift2.0，太老了。
### 三周完成这个项目 2018年5月26日提交！
#### 不会写markdown，很抱歉
+ 之前说的第一次点击进入编辑页面无法获取数据已经解决，在TypeDetailViewController的viewDidlog()里添加onUpdate()

+ 书本代码bug: 在TypeDetailViewController类中,进入`添加`页面，点击确认后是无法跟新数据的。  
  后来我把else注释掉，就可以无论是编辑还是添加任务，都需要reloadData()->跟新数据了。  
  下面代码为我修改后的代码
  
```Swift
   @IBAction func done(_ sender: Any) {
        //获取分类名称
        typeItem.name = textField.text!
        
        if isAdd {
            //将新的分类加进分类数组
            todoModel.onAddType(type: typeItem)
        }  
        
        //获取任务分类视图的导航控制器
        let navigation = self.tabBarController?.viewControllers![0] as! UINavigationController

        //获取任务分类视图
        let typeView = navigation.viewControllers.first as! TypeViewController

        //更新任务分类视图的数据
        typeView.tableView.reloadData()
```

+ 按着书本源码写，在添加任务界面按确定后，返回任务清单界面，数据却无法立刻更新。
我作了以下修改:  
在TodoListController类中，继承的ProtocolTodoDetail协议下的addItem方法:
```Swift
func addItem(item: TodoItem) {
        todoList?.items.append(item)
        //我添加了下面的方法，数据就会在跳转到这个界面时更新数据
        self.tableView.reloadData()
    }
```  

+ 时间bug修好了！原本的代码是写成这样的！  

```Swift  
    //日期样式    
    formatter.dateFormat = "YYYY年 MM月 DD日 HH:mm:ss"    
```  
+ 注意，写错的是`DD日`，因为日期格式化需要用小写，修改版本如下:  
```Swift  
    //日期样式, 修改后    
    formatter.dateFormat = "YYYY年 MM月 dd日 HH:mm:ss"  
```
  
+ 当写到保存数据到本地， 读取本地数据时，出现了错误抛出。还没找到原因。所以只用了假数据 
