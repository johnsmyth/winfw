
describe 'winfw_tester' {
    It "Should create the ssl test rule" {
      netsh advfirewall firewall show rule='allow port 443 for inbound https' | Should Contain 'Ok\.'
    }


    It "Should create the ssl test rule 1" {
      netsh advfirewall firewall show rule='allow port 443 for inbound https' | Should Contain 'No rules match'
    }

}
