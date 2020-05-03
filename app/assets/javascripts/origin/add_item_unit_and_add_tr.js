function addItemUnitFunction($item_units){
  var $last_item_unit = $item_units.children('.basic_item_row:last');
  var $a_url_input_of_last_item_unit = $last_item_unit .find('.taobao_url_input:first');
  var $name_of_a_url_input = $a_url_input_of_last_item_unit.attr('name');
  var $name_of_a_url_input_array = $name_of_a_url_input.split('][');
  var last_item_unit_id = $name_of_a_url_input_array[0].slice(-1);
  var next_item_unit_id = String(Number(last_item_unit_id) + 1);
  var new_item_unit_html = `
    <div class="row mx-2 basic_item_row">
    <div class="col mb-5">
    <div class="h5 basic_item_unit_and_trash">
    <div class="d-inline basic_item_unit_title">商品 ${next_item_unit_id + 1}</div>
    <div class="btn btn-sm btn-outline-danger basic_item_unit_remove_btn">
    <i class="fas fa-trash-alt"></i>
    </div>
    </div>
    <table class="table table-bordered">
    <thead class="thead-light">
    <tr>
    <th class="first_candidate_select text-center">
    優先
    <i class="fas fa-question-circle" data-delay-hide="100" data-delay-show="200" data-placement="top" data-toggle="tooltip" title="" data-original-title="優先的に購入してほしい店舗に、1つだけチェックをいれてください。"></i>
    </th>
    <th>URL</th>
    <th>在庫</th>
    <th>削除</th>
    </tr>
    </thead>
    <tbody class="basic_item_unit_tbody">
    <tr>
    <td class="text-center align-middle">
    <input type="radio" name="first_candidate_select[${next_item_unit_id}]" id="first_candidate_select_${next_item_unit_id}_0" value="0" class="submit_check_box">
    </td>
    <td class="text-center align-middle">
    <div class="input-group">
    <input type="text" name="taobao_url[${next_item_unit_id}][0][0][0]" id="taobao_url_${next_item_unit_id}_0_0_0" class="form-control taobao_url_input">
    <div class="input-group-append">
    <span class="input-group-text" id="basic-addon2">
    <a target="_blank" class="fontawsome_taobao_url_link" href=""><i class="fas fa-external-link-alt"></i>
    </a></span>
    </div>
    </div>
    </td>
    <td class="text-center align-middle">
    <select name="have_stock[${next_item_unit_id}][0]" id="have_stock_[${next_item_unit_id}]_0" class="have_stock form-control"><option selected="selected" value="1">在庫有り</option>
    <option value="0">在庫無し</option></select>
    </td>
    <td class="text-center align-middle">
    <div class="btn btn-sm btn-outline-danger tr_remove_btn">
    <i class="fas fa-trash-alt"></i>
    </div>
    </td>
    </tr>
    <tr>
    <td class="text-center align-middle">
    <input type="radio" name="first_candidate_select[${next_item_unit_id}]" id="first_candidate_select_${next_item_unit_id}_1" value="1" class="submit_check_box">
    </td>
    <td class="text-center align-middle">
    <div class="input-group">
    <input type="text" name="taobao_url[${next_item_unit_id}][0][1][0]" id="taobao_url_${next_item_unit_id}_0_1_0" class="form-control taobao_url_input">
    <div class="input-group-append">
    <span class="input-group-text" id="basic-addon2">
    <a target="_blank" class="fontawsome_taobao_url_link" href=""><i class="fas fa-external-link-alt"></i>
    </a></span>
    </div>
    </div>
    </td>
    <td class="text-center align-middle">
    <select name="have_stock[${next_item_unit_id}][1]" id="have_stock_[${next_item_unit_id}]_1" class="have_stock form-control"><option selected="selected" value="1">在庫有り</option>
    <option value="0">在庫無し</option></select>
    </td>
    <td class="text-center align-middle">
    <div class="btn btn-sm btn-outline-danger tr_remove_btn">
    <i class="fas fa-trash-alt"></i>
    </div>
    </td>
    </tr>
    <tr>
    <td class="text-center align-middle">
    <input type="radio" name="first_candidate_select[${next_item_unit_id}]" id="first_candidate_select_${next_item_unit_id}_2" value="2" class="submit_check_box">
    </td>
    <td class="text-center align-middle">
    <div class="input-group">
    <input type="text" name="taobao_url[${next_item_unit_id}][0][2][0]" id="taobao_url_${next_item_unit_id}_0_2_0" class="form-control taobao_url_input">
    <div class="input-group-append">
    <span class="input-group-text" id="basic-addon2">
    <a target="_blank" class="fontawsome_taobao_url_link" href=""><i class="fas fa-external-link-alt"></i>
    </a></span>
    </div>
    </div>
    </td>
    <td class="text-center align-middle">
    <select name="have_stock[${next_item_unit_id}][2]" id="have_stock_[${next_item_unit_id}]_2" class="have_stock form-control"><option selected="selected" value="1">在庫有り</option>
    <option value="0">在庫無し</option></select>
    </td>
    <td class="text-center align-middle">
    <div class="btn btn-sm btn-outline-danger tr_remove_btn">
    <i class="fas fa-trash-alt"></i>
    </div>
    </td>
    </tr>
    </tbody>
    </table>
    <div class="d-block" style="margin-left: 80px; margin-right: 250px;">
    <div class="btn btn-sm btn-outline-success btn-block text-center add_input_btn add_input_btn_${next_item_unit_id}">
    <i class="fas fa-arrow-alt-circle-up fa-lg"></i>
    買付先URL追加
    </div>
    </div>
    </div>
    </div>
  `
  $item_units.append(new_item_unit_html);
  afterPushButtonToAddTrFunction(`.add_input_btn_${next_item_unit_id}`)
  $('[data-toggle="tooltip"]').tooltip()
}
//追加したDOM用のTr追加関数
function afterPushButtonToAddTrFunction(add_input_btn_i) {
  $(add_input_btn_i).on('click', function(e){
    $add_btn = $(e.target);
    $this_table = $add_btn.closest('.d-block').prev('.table');
    addTrFunction($this_table);
  })
}
//TaobaoUrlを入力するフォームの1行を追加する関数 
function addTrFunction($this_table) {
  $this_tbody = $this_table.children('.basic_item_unit_tbody');
  $this_table_last_tr = $this_table.find('tr:last');
  $this_table_radio_button = $this_table_last_tr.find('.submit_check_box');
  $last_taobao_url_input = $this_table_last_tr.find('.taobao_url_input');
  // 最後のcheckboxのnameから追加のcheckboxのnameを作る
  var $this_table_radio_button_name = $this_table_radio_button.attr('name');
  var $last_radio_button_id = $this_table_radio_button.attr('id');
  var $this_table_radio_button_name_split_array = $last_radio_button_id.split('_');
  var last_tr_id = $this_table_radio_button_name_split_array[4];
  var new_tr_id = String(Number(last_tr_id) + 1);
  var this_item_unit_id = $this_table_radio_button_name_split_array[3];
  // 最後のinputのnameから追加のinputのnameを作る
  var last_taobao_url_input_name = $last_taobao_url_input.attr('name');
  var last_taobao_url_input_name_split_array = last_taobao_url_input_name.split('][');
  var new_taobao_url_input_name_split_array = last_taobao_url_input_name_split_array;
  new_taobao_url_input_name_split_array[2] = String(Number(last_taobao_url_input_name_split_array[2]) + 1);
  new_taobao_url_input_name_split_array[3] = '0]'
  var new_taobao_url_input_name = new_taobao_url_input_name_split_array.join('][');
  // 最後のinputのideから追加のinputのideを作る
  var last_taobao_url_input_id = $last_taobao_url_input.attr('id');
  var last_taobao_url_input_id_split_array = last_taobao_url_input_id.split('_');
  var new_taobao_url_input_id_split_array = last_taobao_url_input_id_split_array;
  new_taobao_url_input_id_split_array[4] = String(Number(last_taobao_url_input_id_split_array[4]) + 1);
  new_taobao_url_input_id_split_array[5] = "0";
  var new_taobao_url_input_id = new_taobao_url_input_id_split_array.join('_');
  var add_new_input_html =`
    <tr>
    <td class="text-center align-middle">
    <input type="radio" name="${$this_table_radio_button_name}" id="first_candidate_select_${this_item_unit_id}_${new_tr_id}" value="${new_tr_id}" class="submit_check_box">
    </td>
    <td class="text-center align-middle">
    <div class="input-group">
    <input type="text" name="${new_taobao_url_input_name}" id="${new_taobao_url_input_id}" class="form-control taobao_url_input">
    <div class="input-group-append">
    <span class="input-group-text" id="basic-addon2">
    <a target="_blank" class="fontawsome_taobao_url_link" href=""><i class="fas fa-external-link-alt"></i>
    </a></span>
    </div>
    </div>
    </td>
    <td class="text-center align-middle">
    <select name="have_stock[${this_item_unit_id}][${new_tr_id}]" id="have_stock_${this_item_unit_id}_${new_tr_id}" class="have_stock form-control"><option selected="selected" value="1">在庫有り</option>
    <option value="0">在庫無し</option></select>
    </td>
    <td class="text-center align-middle">
    <div class="btn btn-sm btn-outline-danger tr_remove_btn">
    <i class="fas fa-trash-alt"></i>
    </div>
    </td>
    </tr>
  `
  $this_tbody.append(add_new_input_html);
}
