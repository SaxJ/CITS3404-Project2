$('.show_users_btn').click(function() {
    var btn = $('.show_users_btn');
    if (!btn.hasClass('active')) {
        btn.addClass('active');
        $('.users').addClass('shown');
        btn.text('Hide Users');
    } else {
        btn.removeClass('active');
        $('.users').removeClass('shown');
        btn.text('Show Users');
    }
});


$('#add_workspace_user_button').click(function(e) {
    if ($('#add_workspace_user_button').hasClass('expanded') && !$(e.target).hasClass('close')) {
        return;
    }
    $('#add_workspace_user_button .close').toggleClass('shown');
    $('#add_workspace_user_button .plus').toggleClass('shown');
    $('#add_workspace_user_button form').toggleClass('shown');
    $('#add_workspace_user_button').toggleClass('expanded');
});