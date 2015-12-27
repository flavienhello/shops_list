namespace :shops do

  task :import, [:file_path, :override] => :environment do |t, args|
    # Defaults
    args.with_defaults(file_path: 'shopmium.csv', override: false)

    # Construct file path
    file_path = Rails.root.join(args[:file_path])
    @override = args[:override]

    puts "\n   ---"
    puts "opening file: #{file_path}"
    puts "options override: #{@override}"

    # Open csv file
    csv_file = CSV.read(file_path, :encoding => 'ISO-8859-1')
    raise Exception, "The file could not be found or is empty" if csv_file.count.zero?


    construct_database( csv_file )

  end


  def construct_database( csv_file )

    # Construct a hash from the header so it can be moved in the future
    # { 0: "chain", 1: "address"...etc }
    @hash_header = Hash[ csv_file.first.map.each_with_index { |val,index | [val.squish, index] } ].symbolize_keys
    csv_file.shift

    # The fields we want to extract, could be change later to let the user select the one he want to populate
    @fields_to_extract = [:chain, :name, :latitude, :longitude, :address, :city, :zip, :phone, :country_code]

    csv_file.each_with_index do |row, index|
      construct_shop( row, index )
    end

  end


  def construct_shop( row, index )

    name_index = @hash_header[:name]
    raise Exception, "The first row does not contain any name column" if name_index.nil?

    puts "\n  --"
    puts "Making Shop for row: #{index}, name: #{row[name_index]}"
    shop = Shop.find_by name: row[ name_index ]

    # construct_shop_hash
    shop_hash = Hash[ @fields_to_extract.map.each{|field| [field, row[@hash_header[field]] ] } ].symbolize_keys

    if shop && @override == false
      puts "Shop already exist, skipping it !"
      return
    elsif shop && @override == true
      puts "Shop already exist updating field with:"
      puts shop_hash
    elsif shop.nil?
      puts "Shop doesnt exist creating a new one with:"
      puts shop_hash

      new_shop = Shop.new shop_hash
      new_shop.save
      raise Exception, "An error occured while saving the model, line: #{index}" if new_shop.nil?

    else
      raise Exception, "That case should not happen"
    end

    binding.pry
    exit
  end


end
