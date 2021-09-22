// 需求：
// 1.自动轮播(设置定时器，移动swiper联合图)
// 2.小圆点跟着对应图片移动，点击显示对应的图片
// 3.上下翻页切换图片，限流。

$(function() {
    var index = 0; // 设置全局的轮播下标
    var timer = null; // 记录定时器的编号
    // 获取大盒子box的宽度
    var boxWidth = $(".box").width();
    console.log(boxWidth);

    // 启动定时器
    autoPlay();

    // 小圆点点击事件
    $(".dot li").click(function() {
        console.log(this);
        // active显示在点击的小圆点上
        $(this).addClass("active").siblings().removeClass("active");
        // 获取小圆点的下标
        index = $(this).index();
        console.log(index);
        // 显示对应下标的图片
        $(".swiper").css({
            left: -boxWidth * index
        })
    })

    // 上翻页
    $(".left").click(function() {
        // 限流
        if ($(".swiper").is(":animated")) {
            return false;
        }
        // 点击一下，图片下标-1
        index--;
        move();
    })
    // 下翻页
    $(".right").click(function() {
        console.log($(".swiper").is(":animated"));
        if ($(".swiper").is(":animated")) {
            return false;
        }
        index++;
        move();
    })


    // 封装自动播放的函数
    function autoPlay() {
        // 启动前先清除定时器
        clearInterval(timer);
        // 设置定时器
        timer = setInterval(function() {
            index++;
            move();
        }, 3000)
    }

    // 封装联合图移动的函数
    function move() {
        // 移动到临界时判断
        if (index < 0) {
            // 下标小于0时，显示最后一张
            index = $(".dot li").length;
            // 联合图移动相应的距离
            $(".swiper").css({
                left: -boxWidth * index
            })
            // 过渡作用
            index--;
        }
        if (index > $(".dot li").length) {
            // 下标大于小圆点下标时，显示第一张
            index = 0;
            $(".swiper").css({
                left: 0
            });
            // 过渡作用
            index++;
        }
        // 判断是否是第五张 如果是第五张 把第一个点变为active状态
        $(".dot li").eq(index == $(".dot li").length ? 0 : index).addClass("active").siblings().removeClass("active");
        // 联合图轮播运动(向左挪)
        $(".swiper").stop().animate({
            left: -boxWidth * index
        }, function() {
            // 播到最后一张时，回到第一张
            if (index >= $(".dot li").length + 1) {
                index = 0;
                $(".swiper").stop().animate({
                    left: 0
                })
            }
        })
    }
});