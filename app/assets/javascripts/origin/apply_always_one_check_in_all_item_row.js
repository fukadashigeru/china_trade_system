// 必ずラジオボタンにチェックを入れる処理
function applyAlwaysOneCheckInAllItemRowFunction(){
  $('.basic_item_row').each(function(index, item_row){
    $item_row = $(item_row);
    applyAlwaysOneCheckInItemRowFunction($item_row);
  })
}
function applyAlwaysOneCheckInItemRowFunction($item_row){
  var $all_submit_check_box = $item_row.find('.submit_check_box');
  var all_check_situation_array = [];
  $all_submit_check_box.each(function(index, submit_check_box){
    var $submit_check_box = $(submit_check_box);
    var check_situation = $submit_check_box.prop('checked');
    all_check_situation_array.push(check_situation)
  })
  if ($.inArray(true, all_check_situation_array) == -1) {
    var $item_unit_tbody = $item_row.find('.basic_item_unit_tbody')
    var $this_all_tr = $item_unit_tbody.find('tr');
    $this_all_tr.each(function(index, tr){
      var $this_tr = $(tr);
      var $this_taobao_url_input = $this_tr.find('.taobao_url_input');
      var $this_taobao_url_input_val = $this_taobao_url_input.val();
      var $this_select_tag = $this_tr.find('.have_stock');
      var n = $this_select_tag.children('option:selected').val();
      var $this_submit_check_box = $this_tr.find('.submit_check_box');
      if ($this_taobao_url_input_val != "" && n == '1'){
        $this_submit_check_box.prop('checked', true);
        return false;
      }
    })
  }
}
