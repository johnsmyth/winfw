#
# Cookbook Name:: win_util
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#


winfw_firewall_rule "allow port 11180 for inbound http" do
  action      :create
  protocol    "tcp"
  local_port  "11180"
  dir         "in"
  fw_action   "allow"
end

winfw_firewall_rule "allow port 11443 for inbound https" do
  action      :create
  protocol    "tcp"
  local_port  "11443"
  dir         "in"
  fw_action   "allow"
end


winfw_firewall_rule "allow port 11180 for inbound http" do
  action      :delete
end


winfw_firewall_rule "test https delete rule by port and protocol"  do
  action      :delete
  name        "all"
  protocol    "tcp"
  local_port  "11443"
  dir         "in"
  fw_action   "allow"
end


