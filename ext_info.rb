RetroEM::Views.register_extension('ssh_pubkeys', :user, :options)

RetroAM.permission_map do |map|
  code = map['code']
  code.permission :write, :label => N_('Write')
  code.permission :admin, :label => N_('Administrate')
end
