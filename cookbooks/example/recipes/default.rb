#
# Cookbook:: example
# Recipes:: default

# Create resources
(0..100).each do |x|
    random_string = (0...8192).map { (65 + rand(26)).chr }.join

    file x do
      content random_string
      path windows? ? "C:\\#{x}" : "/tmp/#{x}"
    end

    registry_key "HKEY_CURRENT_USER\\ChefTest" do
      values [{
          :name => x.to_s,
          :type => :string,
          :data => random_string,
      }]
      action :create
      only_if { windows? }
    end
end

# Destroy resources
(0..100).each do |x|
    file x do
      action :delete
      path windows? ? "C:\\#{x}" : "/tmp/#{x}"
    end

    registry_key "HKEY_CURRENT_USER\\ChefTest" do
      values [{
          :name => x.to_s,
          :type => :string,
          :data => "",
      }]
      action :delete
      only_if { windows? }
    end
end
