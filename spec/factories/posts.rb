FactoryGirl.define do
  factory :post do
    caption 'Always pass on what you have learned.'
    image Rack::Test::UploadedFile.new(Rails.root + 'spec/support/images/yoda.jpg', 'image/jpg')
  end
end
