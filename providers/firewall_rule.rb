include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

use_inline_resources


action :create do
  if @current_resource.exists
    Chef::Log.debug "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create firewall rule #{ @new_resource }") do
      create_firewall_rule( @new_resource )
    end
  end
end

action :delete do
  if @current_resource.exists
    converge_by("Delete firewall rule #{ @new_resource }") do
      delete_firewall_rule ( @new_resource)
    end
  else
    Chef::Log.debug "#{ @current_resource } doesn't exist - can't delete."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::WinfwFirewallRule.new(@new_resource.resource_name)
  if( @new_resource.name) 
    @current_resource.name(@new_resource.name)
  else
    @current_resource.name(@new_resource.resource_name)
  end
  @current_resource.description(@new_resource.description)
  @current_resource.fw_action(@new_resource.fw_action)
  @current_resource.local_ip(@new_resource.local_ip)
  @current_resource.local_port(@new_resource.local_port)
  @current_resource.remote_ip(@new_resource.remote_ip)
  @current_resource.remote_port(@new_resource.remote_port)
  @current_resource.dir(@new_resource.dir)
  @current_resource.protocol(@new_resource.protocol)
  @current_resource.profile(@new_resource.profile)
  @current_resource.service(@new_resource.service)
  @current_resource.interface_type(@new_resource.interface_type)
  @current_resource.program(@new_resource.program)
  if rule_exists?(@current_resource)
    @current_resource.exists = true
  end
end


private

def create_firewall_rule( newresource )
  if rule_exists?( newresource) 
    Chef::Log.debug "Firewall rule exists: #{newresource.name} -- Skipping create..."
  
  else
     cmd_str = "netsh advfirewall firewall add rule name=\"#{new_resource.name}\" " 
     cmd_str += "description=\"#{newresource.description}\" " if  newresource.description
     cmd_str += "action=\"#{newresource.fw_action}\" " if newresource.fw_action
     cmd_str += "localip=\"#{newresource.local_ip}\" " if newresource.local_ip
     cmd_str += "localport=\"#{newresource.local_port}\" " if newresource.local_port
     cmd_str += "remoteip=\"#{newresource.remote_ip}\" " if newresource.remote_ip
     cmd_str += "remoteport=\"#{newresource.remote_port}\" " if newresource.remote_port
     cmd_str += "dir=\"#{newresource.dir}\" " if newresource.dir
     cmd_str += "protocol=\"#{newresource.protocol}\" " if newresource.protocol
     cmd_str += "profile=\"#{newresource.profile}\" " if newresource.profile
     cmd_str += "service=\"#{newresource.service}\" " if newresource.service
     cmd_str += "interfacetype=\"#{newresource.interface_type}\" " if newresource.interface_type
     cmd_str += "program=\"#{newresource.program}\" " if newresource.program
    Chef::Log.debug "Creating firewall rule with command: #{cmd_str}"
    execute "netsh advfirewall" do
      command cmd_str
    end
  end

end

def delete_firewall_rule( newresource)
  if rule_exists?( newresource) 
    cmd_str = "netsh advfirewall firewall delete rule name=\"#{newresource.name}\" " 
    cmd_str += "dir=\"#{newresource.dir}\" " if newresource.dir
    cmd_str += "profile=\"#{newresource.profile}\" " if newresource.profile
    cmd_str += "program=\"#{newresource.program}\" " if newresource.program
    cmd_str += "service=\"#{newresource.service}\" " if newresource.service
    cmd_str += "localip=\"#{newresource.local_ip}\" " if newresource.local_ip
    cmd_str += "localport=\"#{newresource.local_port}\" " if newresource.local_port
    cmd_str += "remoteip=\"#{newresource.remote_ip}\" " if newresource.remote_ip
    cmd_str += "remoteport=\"#{newresource.remote_port}\" " if newresource.remote_port
    cmd_str += "protocol=\"#{newresource.protocol}\" " if newresource.protocol

    Chef::Log.debug "Removing firewall rule with command: #{cmd_str}"
    execute "netsh advfirewall" do
      command cmd_str
    end
  else
    Chef::Log.debug "Firewall rule doesnt exist: #{newresource.name} -- Skipping delete..."
  end
end

def rule_exists?( new_resource)
  cmd_str = "netsh advfirewall firewall show rule name=\"#{new_resource.name}\" " 
  Chef::Log.debug "Checking existence of firewall rule with command: #{cmd_str}"
  cmd = shell_out("#{cmd_str}", { :returns => [0] })
  if (cmd.stderr.empty? && (cmd.stdout =~ /^.*Rule Name.*$/i))
    Chef::Log.debug "Firewall rule exists: #{new_resource.name}"
    return true
  end

  Chef::Log.debug "Firewall rule not found: #{new_resource.name}"
  return false
end

