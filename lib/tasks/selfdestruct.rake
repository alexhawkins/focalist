task :greet do
  puts "hello world"
end
#dependency (calls greet dask before ask task)
task :ask => :greet do
  puts "how are you?"
end

namespace :pick do
  desc "Pick a random Item as the winner"
  task :winner => :environment do
    puts "Item: #{pick(Item).description}"
  end

  desc "Pick a random List as the prize"
  task :prize => :environment do
    puts "List: #{pick(List).name}"
  end

  desc "Pric a random List and Item"
  task :all => [:prize, :winner]


  def pick(model_class)
    model_class.find(:last)
  end
end

desc "Delete items that are older than 7 days"
task delete_items: :environment do
  Item.where("created_at <= ?", Time.now - 7.days).destroy_all
end

