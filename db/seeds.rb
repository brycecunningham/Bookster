(ActiveRecord::Base.connection.tables.map!(&:camelize).map!(&:singularize) - [ 'SchemaMigration' ]).each do |t|
  t.constantize.destroy_all
end

require 'pp'
require 'uri'
require 'multi_json'
file = File.expand_path('../books.json', __FILE__)
json = File.read(file)
records = MultiJson.load(json, :symbolize_keys => true)
@pb = ProgressBar.create :title => 'books', :total => records.count
records.each_with_index do |record,idx|
  category = Category.where(:name => record[:category]).first
  if !category
    category = Category.new(:name => record[:category])
    category.picture = File.open(Rails.root.join('private','category_images',"#{record[:category].underscore.downcase}.jpg"),'rb')
    category.save!
  end
  book = Book.new({
    :title => record[:title],
    :category => category,
    :year => record[:year],
    :pages => record[:pages],
    :description => record[:description],
    :author => record[:author]
  })
  if record[:image]
    begin
      img = HTTParty.get(record[:image])
      book.picture = StringIO.new(img) unless img.blank?
      book.picture = nil unless book.picture_content_type =~ /\Aimage\/.*\Z/
    rescue Exception => e
      Kernel.warn e
    end
  end
  book.save!

  @pb.increment
end
Kernel.sleep 2