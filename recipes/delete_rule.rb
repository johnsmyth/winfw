#
# Cookbook Name:: win_util
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#


winfw_firewall_rule "allow port 80 for inbound http" do
  action      :delete
end

#winfw_firewall_rule "allow port 443 for inbound https" do
  #action      :delete
#end

#winfw_firewall_rule "allow outbound ssh" do
  #action      :delete
#end


winfw_firewall_rule "Block SQL Browser inbound traffic" do
  action      :delete
end

winfw_firewall_rule "test https delete rule"  do
  action      :delete
  name        "all"
  protocol    "tcp"
  local_port  "443"
  dir         "in"
  fw_action   "allow"
end

winfw_firewall_rule "test delete of ssh rule" do
  action      :delete
  name        "all"
  protocol    "tcp"
  remote_port  "22"
  dir         "out"
  fw_action   "allow"
end

