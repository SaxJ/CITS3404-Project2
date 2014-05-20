$('.show_users_btn').click(function() {
    var btn = $('.show_users_btn');
    if (!btn.hasClass('active')) {
        btn.addClass('active');
        $('.users').addClass('shown');
        btn.innerHTML = 'Hide Users';
    } else {
        btn.removeClass('active');
        $('.users').removeClass('shown');
        btn.innerHTML = 'Show Users';
    }
})