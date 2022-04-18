# 2021年我是怎么搞java的

## java基础

1. 环境（jdk，jre，ide），语法，基本数据类型：

   - 整数类型：byte，short，int，long
   - 浮点数类型：float，double
   - 字符类型：char
   - 布尔类型：boolean
   - 数组：`int[] ns = new int[] { 68, 79, 91, 85, 62 };`

2. 面向对象：

   - 封装：类+private/protected实现对外屏蔽内部细节

   - 继承：extends。java不允许多继承，一个类只能有一个父类；对比python，允许多继承，会有[钻石继承](https://zhuanlan.zhihu.com/p/106963767)的问题

   - 多态：子类可以通过覆写，表现出与父类不同的行为。手段即为方法覆写（Override），方法签名相同。

   - 方法重载（Overload）：同名不同参的方法，方法签名不同。

   - public/private/protected/package省略/的作用域问题

     - public: 公开，可被其他任何类访问
     - private：仅类内部访问（包含嵌套类）
     - protected：仅子类可访问
     - package：省略上面三个关键字时，作用域为package级别，同包内可见

   - getter/setter：对外提供操作内部字段的方法（字段设置为private，但是通过public级别的方法暴露操作字段的途径）

   - 内部类：

     - 普通类嵌套：内部类的实例化需要依赖外部类的实例。目前项目中未用到，仅了解。

     - [匿名内部类](https://www.cnblogs.com/chenssy/p/3390871.html)：无名字，继承一个普通类或实现一个接口。

       - 应用1：线程启动前的任务定义

         ```java
         Runnable r = new Runnable() {
                     @Override
                     public void run() {
                         System.out.println("Hello, " + Outer.this.name);
                     }
                 };
         ```

       - 应用2：简化集合初始化和实例化代码

         快速创建一个有初始值的hashmap

         ```java
         HashMap<String, String> map3 = new HashMap<>() {
                     {
                         put("A", "1");
                         put("B", "2");
                     }
                 };
         ```

         调用方法时快速准备传参

         ```java
         volumeMapper.updateIgnoreNull(new VolumeDO() {{
                                             setId(volumeDO.getId());
                                         }});
         ```

     - 静态内部类：内部类用static修饰，可以直接实例化。作用：即与外部类划清界限（整合进外部类会有悖于单一职责），但又不完全与外部类割裂（告诉类的使用者内部类仅限于特定用处使用）。例如k8s的service对象中会包含一部分描述其端口映射的信息，这部分可以抽象成静态内部类。

   - 类型强转：[**对于非基础类型，强转后的新变量是引用，而不是新值**](https://stackoverflow.com/a/13405443/6792174)。

3. 集合类：

   - list：ArrayList（基于数据的有序列表），LinkedList（基于链表的有序列表）
   - map：HashMap
   - set：HashSet（无序），TreeSet（有序）
   - queue：LinkedList也实现了Queue接口，可以用来做队列；另外还有双端队列DeQue和优先级队列PriorityQueue

4. 函数式编程&stream表达式

   - 方法引用语法：`SomeClass::someFunction`

   - 常用stream操作：map-对象转换，filter-过滤对象，forEach-遍历。关于forEach遍历需要注意两个细节。
     - [ foreach能否修改数据？_千千-CSDN博客_javaforeach改变值](https://blog.csdn.net/n950814abc/article/details/87468067)
     - [java - How to put continue in side forEach loop in java8 - Stack Overflow](https://stackoverflow.com/questions/38948817/how-to-put-continue-in-side-foreach-loop-in-java8)
     
   - stream输出的目标，可以用Collectors的各个方法将结果组装成需要的输出结构，比如`Collectors.toList`,`Collectors.joining`,`Collectors.toMap`,`Collectors.groupingBy`等

   - 使用`Collectors.groupingBy`快速对集合进行分组整理，并快速映射成需要的格式

     ```java
     Map<String, List<String>> circuitNbrs = crmOrderRequestVO.getVmProduct().getVmPublicNetworkInfo().stream()
                         .collect(Collectors.groupingBy(
                                         (internetIp) -> String.format("BANDWIDTH_%s", internetIp.getVmPublicNetworkBw()).toUpperCase(),
                                         Collectors.mapping(CrmOrderProductVO.InternetIp::getCircuitNbr, Collectors.toList())
                                 )
                         );
     // {BANDWIDTH_200M=[123456], BANDWIDTH_100M=[123456, 1234599999]}
     ```

5. 线程池

   - 意义：分散建立线程有弊端：1.性能低下2.缺乏中心化的管理机制。线程池可以解决这些弊端。
   - 细节有待继续深入学习。[Java线程池实现原理及其在美团业务中的实践 - 美团技术团队 (meituan.com)](https://tech.meituan.com/2020/04/02/java-pooling-pratice-in-meituan.html)

6. 反射

   - 一点私货：还没毕业的某年，在宿舍，和舍友讨论一段python代码，费解是否能在运行期动态获取一个对象的信息，从而不需要写代码时一个一个判断分别处理，印象中当时学习一通发现python的反射主要是通过`getattr` 、`hasattr`等方法操作对象的属性，最终没有继续研究，不了了之。但是那个夜晚给我留下了很深的印象。

   - 今年学了java，恰好有个需求可以用反射的方法快速实现：一个订单相关接口的入参类有很多属性，对应不同的订单资源。用户的订单可以仅涉及其中的部分资源。如果不用反射，我需要挨个判断每个参数是否传了值，然后逐项处理，过程想想都会觉得非常无聊。能否用一段通用的代码，一次性完成所有参数的解析和处理呢？以下为这部分的相关代码：逻辑很简单，拿到所有的参数属性，遍历，如果不为空，就处理。如此一来不需要逐项在代码中遍历参数，写重复的逻辑。

     ```java
     Queue<Field> fields = new LinkedList<>(Arrays.asList(crmOrderProductVO.getClass().getDeclaredFields()));
             while (!fields.isEmpty()) {
                 Field field = fields.poll();
                 // 跳过无关字段
                 if (!field.getName().startsWith(vmPrefix) && !field.getName().startsWith(cntrPrefix)) {
                     continue;
                 }
                 // 容器调用时跳过虚机字段，反之亦然;并跳过gpu和公网ip带宽相关字段单独处理
                 if (field.getName().startsWith(fieldFilter) || field.getName().endsWith(gpuSuffix)
                         || field.getName().endsWith(bandwidthSuffix)) {
                     continue;
                 }
     
                 field.setAccessible(true);
                 Object value = field.get(crmOrderProductVO);
                 if (value != null) {
                     // 根据fieldName拿到resourceCode
                     if (!OrderConstants.PRODUCT_VO_FIELDS_2_RESOURCE_CODE_MAP.containsKey(field.getName())) {
                         throw new IllegalArgumentException("不受支持的资源类型");
                     }
                     // 检查子订单的状态，防止停机的子订单被扩容
                     if (resourceOrderVO.getOrderState().equals(TcConstants.ORDER_PAUSED)) {
                         throw new IllegalArgumentException("要变更的子订单状态为停机，请先复机后再变更");
                     }
                     String resourceCode = OrderConstants.PRODUCT_VO_FIELDS_2_RESOURCE_CODE_MAP.get(field.getName());
                     doModify(keptSnapshots, resourceCode, resourceOrderVO, (int) value, fieldFilter);
                 }
                 field.setAccessible(false);
             }
     ```

7. 泛型

   从python转写java，泛型是需要全新学习的东西。一开始有点不太理解，后来习惯了就发现了好处。一开始接触泛型需要一段时间去理解，尤其是看到有通配符（各种? T）之类的泛型时会感觉莫名其妙。在知乎看到一个回答印象很深刻：[Java 泛型  中 super 怎么 理解？与 extends 有何不同？ - 知乎 (zhihu.com)](https://www.zhihu.com/question/20400700/answer/117464182)，里面把泛型类比成盘子，十分形象好理解。

   后来在项目中除了一般的使用泛型外，写了一段有通配符的和泛型相关的代码，加深了印象：

   ```java
   // 原有方法签名
   public void fillNodeAreaData(Set<Integer> mecNodeIds, Consumer<Map<Integer, MecNodeResponse>> consumer) {}
   
   // 该方法的调用：第一个参数输入待处理的id，第二个参数用一个lambda消费该方法的结果
   meoClientHelp.fillNodeAreaData(nodeIds, integerMecNodeResponseMap -> result.forEach(
                   securityGroupListResponseVO -> {
                       MecNodeResponse node = integerMecNodeResponseMap.get(securityGroupListResponseVO.getMecNodeId());
                       if (node != null) {
                           securityGroupListResponseVO.setAreaData(node.getMecNodeName(), node.getCityName(), node.getAreaName(), node.getProvinceName());
                       }
                   }
           ));
   
   // 以上方法的弊端是调用稍显复杂，且其第二个参数的lambda函数体内部消费相关代码重复度很高，可以进一步提取抽象。所以就有了包装该方法的下面的代码
   public <T extends CommonParent> void setNodeAreaData(List<T> tList) {
           fillNodeAreaData(tList.stream().map(T::getNodeId).collect(Collectors.toSet()),
                   integerMecNodeResponseMap -> tList.forEach(
                           T -> {
                               MecNodeResponse mecNodeResponse = integerMecNodeResponseMap.get(T.getNodeId());
                               ......
                           }
                   ));
       }
   //包装后的方法使用泛型限制了参数的类型
   ```

## spring基础

1. 注入
   1. ioc：依赖反转，将类的实例过程抽出去，由sping负责，业务需要用到时注入到实例里直接使用即可。
   2. aop：用法类似于python中的装饰器，抽取出通用的逻辑。
2. mybatis：可以用代码生成器根据数据库设计快速生成通用的基本mapper；设计时提高通用性，减少与业务逻辑耦合，方便后续开发的复用；插件：free mybatis plugin。
3. mvc架构：单个微服务项目的工程目录结构如何组织，目标是方便扩展。同一功能模块的类尽量减少包的跨度，避免反复跳转目录查找类文件，尽量一目了然。
4. 日志：slf4j的基本使用；如何打印日志可以最大限度地方便调试；异常时的日志避免调用栈信息丢失；
5. 异常管理：使用RestControllerAdvice注解实现全局异常捕捉，统一返回
6. spring cloud：feign实现微服务调用及fallback；使用filter实现网关微服务，功能包括接口鉴权、身份注入、限流、Hystrix(超时控制/熔断/fastfail)、审计日志生成、请求的缓存控制。
7. 中间件及api：
   - redis：数据结构，应用场景
   - rocketMq：概念，意义，注意事项
8. 监听器：EventListener注解监听事件，配合ApplicationContext类广播事件。像轻量级的消息队列，更侧重代码的解耦/异步化。

## 其他备忘

- 接口异步化：线程池/监听器/消息队列/CompletableFuture.runAsync()

- swagger：集成swagger，代码即文档。

- maven：[解决依赖冲突问题](http://www.heartthinkdo.com/?p=2916)，插件：Dependency Analyzer/maven helper

- 代码质量：插件：alibaba java coding guidelines/qaplug

- 功能设计：

  - 学习k8s调度器和kubelet的延时重启策略，用在微服务调用中

    ![image-20211227170149729](https://cdn.wubw.fun/typora/211227-170149-image-20211227170149729.png)

- 项目整体架构设计，微服务划分，互调用逻辑：使用单体仓库效率更高，可以避免多仓库导致的工作量倍增，逻辑的复杂化。

- 序列化与反序列化：[用gson库借助json实现深拷贝](https://developer.aliyun.com/article/609864)

- 线程安全问题

  - hashmap vs ConcurrentHashMap： [HashMap? ConcurrentHashMap? 相信看完这篇没人能难住你！ | crossoverJie's Blog](https://crossoverjie.top/2018/07/23/java-senior/ConcurrentHashMap/)

## 参考

[Java教程 - 廖雪峰的官方网站 (liaoxuefeng.com)](https://www.liaoxuefeng.com/wiki/1252599548343744)

《head first design pattern》
