# README

1. clone this repo
2. bundle install
3. rails db:seed
4. foreman s

project page url:  /projects/1
event page url: /teams/1/events


## 几点要说的
* 我知道有 activity 等一些类似开源库，但是我认为这里的应该是考察代码能力，就没用用开源来实现，另外我觉得这个开源库设计的并不好，详情见下条

* 可以使用 after_xxx callback 实现 events，这种实现方法代码量虽然更少，但是我认为我的实现方法更好一些
after_callback 是跳出的逻辑，导致代码可读性很差，还增加了耦合
如果有需要 skip callback 的需求，必须使用 skip callback 的存储方式，很麻烦
批量行为时，如果 callback 多了，运行很慢
以下有两篇文章同样证明了这一点:
http://blog.arkency.com/2016/05/domain-events-over-active-record-callbacks/
https://medium.com/spritle-software/rails-5-activerecord-suppress-a-step-too-far-d7ec2e4ed027#.lb955smu6

* tower 的 todo 的 due_at 是用的时间戳来实现的，为了和 tower 设计趋同我也用时间戳来实现，但我不是很赞同（有可能是不理解背后的原因）；因为我认为 due at 是一个不带具体时间日期，日期本身是不应该有时区概念的，同一个时间 12月30日，在中国美国日本看都应该是12月30日，而不应该是 12月29，或者31日
