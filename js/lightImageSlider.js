var esf = esf || {};
esf.imageSlider = function() {
    esf.productImageSlider();
};

esf.productImageSlider = function(){
    var $autoPlaySlider = esf.autoPlaySlider;
    autoPlaySlider = $('.product-img-slider').lightSlider({
        item: 4,
        controls: true,
        speed: 2000,
        pause: 6000,
        auto: true,
        loop:true,
        enableDrag:false,
        responsive : [
            {
                breakpoint:1366,
                settings: {
                    item:3,
                    enableDrag:true
                }
            },
            {
                breakpoint:991,
                settings: {
                    enableDrag:true
                }
            },
            {
                breakpoint:800,
                settings: {
                    item:2,
                    enableDrag:true
                }
            },
            {
                breakpoint:767,
                settings: {
                    item:1,
                    enableDrag:true
                }
            }
        ]
    });
    //$('.product-img-slider').on('mouseenter',function(){
    //    autoPlaySlider.pause();
    //});
    //$('.product-img-slider').on('mouseleave',function(){
    //    autoPlaySlider.play();
    //});
};
//
//$(function(){
//    esf.imageSlider();
//});