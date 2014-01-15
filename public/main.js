Zepto(function($){
  $('.xo').on('click', 'span', function(){
    $.ajax({
      type: 'POST',
      url: '/choice',
      data: { side: $(this).html() },
      success: function(data){
        $('.choice').hide();
        $('.board').show();
      }
    })
  });
})
