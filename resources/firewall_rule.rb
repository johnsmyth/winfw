
actions :create, :delete
default_action :create

attribute :resource_name, :name_attribute => true, :kind_of => String, :required => true 
attribute :name, :kind_of => String, :default => nil
attribute :description, :kind_of => String

attribute :local_ip, :kind_of => String, :default => nil
attribute :local_port, :kind_of => String, :default => nil        #  { any | Integer | rpc | rpc-epmap | iphttps | teredo | [ ,... ] } ]

attribute :remote_ip, :kind_of => String, :default => nil
attribute :remote_port, :kind_of => String, :default => nil        #  { any | Integer | rpc | rpc-epmap | iphttps | teredo | [ ,... ] } ]

attribute :dir, :kind_of => String, :default => nil               # { in | out }
attribute :protocol, :kind_of => String, :default => nil          # { any | Integer | icmpv4 | icmpv6 | icmpv4:type,code | icmpv6:type,code | tcp | udp } 
attribute :fw_action, :kind_of => String, :default => nil                         # { allow | block | bypass }

attribute :profile, :kind_of => String, :default => nil                # { public | private | domain | any | [ ,... ] } ]
attribute :program, :kind_of => String                                 # ProgramPath\FileName ]
attribute :service, :kind_of => String, :default => nil                # { ServiceShortName | any } ]
attribute :interface_type, :kind_of => String, :default => nil        # { any | wireless | lan | ras } ]

attr_accessor :exists
