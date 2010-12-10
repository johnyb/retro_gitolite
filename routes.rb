RetroEM::Routes.draw do |map|
  map.namespace :admin do |admin|
    admin.resources :users, :has_many => :ssh_pubkeys
  end
  map.resources :ssh_pubkeys
end
