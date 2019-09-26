require 'csv'

# rake import:users
namespace :import do
  desc "Import useers from csv"

  task orders: :environment do
    path = File.join Rails.root, "db/csv/csv_data.csv"
    puts "path: #{path}"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        quantity: row["quantity"],
        price: row["price"],
        trade_no: row["trade_no"],
        customer_name: row["customer_name"],
        postal: row["postal"],
        address: row["address"],
        phone: row["phone"],
        variation: row["variation"],
        remark: row["remark"],
      }
    end
    puts "start to create users data"
    begin
      Order.create!(list)
      puts "completed!!"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "raised error : unKnown attribute "
    end
  end
end