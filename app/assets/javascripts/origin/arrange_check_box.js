//在庫の有無でradio_button_tagのチェックを外したり、disabledしたりする。
function arrangeCheckBoxByHavingStockSelectTag($this_select_tag) {
  var n = $this_select_tag.children('option:selected').val();
  var $this_tr = $this_select_tag.closest('tr');
  var $this_taobao_url_input = $this_tr.find('.taobao_url_input');
  var $this_taobao_url_input = $this_taobao_url_input.val();
  var $this_submit_check_box = $this_tr.find('.submit_check_box');
  if ($this_taobao_url_input == ""){
    switch (n) {
      case '0':
        $this_select_tag.addClass('bg-secondary text-white');
        break;
      case '1':
        $this_select_tag.removeClass('bg-secondary text-white');
        break;
    }
  } else {
    switch (n) {
      case '0':
        $this_select_tag.addClass('bg-secondary text-white');
        $this_submit_check_box.prop('checked', false);
        $this_submit_check_box.prop('disabled', true);
        break;
      case '1':
        $this_select_tag.removeClass('bg-secondary text-white');
        $this_submit_check_box.prop('disabled', false);
        break; 
    }
  }
  //applyAlwaysOneCheckInAllItemRowFunction()
}
//インプットの有無でradio_button_tagのチェックを外したり、disabledしたりする。
function arrangeCheckBoxByTaobaoUrlInput($this_taobao_url_input){
  var this_taobao_url_input_val = $this_taobao_url_input.val();
  var $this_tr = $this_taobao_url_input.closest('tr');
  var $this_select_tag = $this_tr.find('.have_stock');
  var n = $this_select_tag.children('option:selected').val();
  var $this_submit_check_box = $this_tr.find('.submit_check_box');
  if (n == '1'){
    if (this_taobao_url_input_val == ""){
      $this_submit_check_box.prop('checked', false);
      $this_submit_check_box.prop('disabled', true);
    } else {
      $this_submit_check_box.prop('disabled', false);
    }
  }
}
