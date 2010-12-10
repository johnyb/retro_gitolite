#--
# Copyright (C) 2008 Dimitrij Denissenko
# Please read LICENSE document for more information.
#++
User.class_eval do
  has_many :ssh_pubkeys, :dependent => :destroy
end
