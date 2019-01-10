// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on('turbolinks:load', function(){
    $('.scroll-to-job-btn').on('click', function(e) {
        e.preventDefault();
        var scrollTarget = $(this).data("tar");

        $('html, body').animate({
            scrollTop: $("#"+scrollTarget).offset().top
        }, 1000);
    });

    $('.abstract-toggle-action').text("show ");
    $('.abstract-collapse-toggle').on('click', function(e) {
        e.preventDefault();
        var togglePrefixId = $(this).attr('id')+"-prefix";
        if ($("#"+togglePrefixId).text() === "show ") {
            $("#"+togglePrefixId).text("close ")
        } else {
            $("#"+togglePrefixId).text("show ")
        }
    });

    $('.scroll-to-resource').on('click', function(e) {
        e.preventDefault();
        var scrollTarget = $(this).data("tar");

        $('html, body').animate({
            scrollTop: $("#" + scrollTarget).offset().top
        }, 1000);
    });
    $('.scroll-to-resources-list').on('click', function(e) {
        e.preventDefault();
        var scrollTarget = $(this).data("tar");

        $('html, body').animate({
            scrollTop: $("#" + scrollTarget).offset().top
        }, 1000);
    });

    if (window.location.pathname === '/redcap') {
        $.post('https://redcap.ucsf.edu/api/',
                { token:'',
                format: 'json',
                content: 'record',
                type: 'flat',
                returnFormat: 'json' },
                function(data){
            console.log(data.length);
            $('.spinner').css("display", "none");

        })
    }
});

