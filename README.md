# winfw cookbook
This cookbook implements an lwrp for windows firewalls. This code has not been fully vetted for production deployment.  Currentlty, there is only a single firewall\_rule resource/provider.

# Requirements
This cookbook has only been tested on windows 2008R2.  It should work with other versions of windows but I have not tested them.  The firewall\_rule provider is basically a wrapper around netsh advfirewall.

# Usage
In your recipe, you can use the winfw\_firewall\_rule resource.  Currently, the supported actions are :create and :delete.  If the 'name' attribute is not specified, the name of the resource will be used as the rule name.  Attribute defaults match the netsh advfirewall defaults.



##Examples
```


winfw_firewall_rule "allow port 443 for inbound https" do
  action      :create
  protocol    "tcp"
  local_port  "443"
  dir         "in"
  fw_action   "allow"
end

winfw_firewall_rule "allow outbound ssh" do
  action      :create
  protocol    "tcp"
  remote_port  "22"
  dir         "out"
  fw_action   "allow"
end

winfw_firewall_rule "Block SQL Browser inbound traffic" do
  action      :create
  protocol    "tcp"
  local_port  "1434"
  dir         "in"
  fw_action   "block"
end


# Delete all rules named "allow port 80 for inbound http" 
winfw_firewall_rule "allow port 80 for inbound http" do
  action      :delete
end

#Delete all rules named "Block SQL Browser inbound traffic"
winfw_firewall_rule "Block SQL Browser inbound traffic" do
  action      :delete
end

#Delete all rules that allow inbound tcp on port 443 
winfw_firewall_rule "test https delete rule"  do
  action      :delete
  name        "all"
  protocol    "tcp"
  local_port  "443"
  dir         "in"
  fw_action   "allow"
end

#Delete all rules that allow outbound tcp on port 22 
winfw_firewall_rule "test delete of ssh rule" do
  action      :delete
  name        "all"
  protocol    "tcp"
  remote_port  "22"
  dir         "out"
  fw_action   "allow"
end

```


# Attributes

firewall_rule attributes are as follows:

*action      -  :create, :delete (default is  :create)
*name        - firewall rule name to create or delete.  You can use a name of 'all' in a delete to delete all rules that match other criteria
*description - firewall rule description
*local_ip    - can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by -
*local_port  - can by 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] } 
*remote_ip   - can be 'any', a specific address, a subnet in CIDR or ip/mask notation, or a range separated by -
*remote_port - can by 'any', an integer or one of {  rpc | rpc-epmap | iphttps | teredo | [ ,... ] } 
*dir         - { in | out }
*protocol    - can by 'any', an integer, or one of { | icmpv4 | icmpv6 | icmpv4:type,code | icmpv6:type,code | tcp | udp } 
*fw_action   - { allow | block | bypass }
*profile     - { public | private | domain | any | [ ,... ] } ]
*program     - the path to the program
*service     - the short name of the service, or 'any'
*interface_type - { any | wireless | lan | ras } ]


# Recipes

# Author

Author:: YOUR_NAME (<YOUR_EMAIL>)
