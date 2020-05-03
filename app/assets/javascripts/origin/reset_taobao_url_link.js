function resetTaobaoUrlLink() {
  $('.basic_item_unit_tbody tr').each(function(index, tr_element) {
    var taobao_url = $(tr_element).find('.taobao_url_input').val();
    $(tr_element).find('.fontawsome_taobao_url_link').attr('href', taobao_url);
  })
}
