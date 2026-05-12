def dae [option: string] {
    match $option {
        "on" => { sudo /run/current-system/sw/bin/systemctl start dae.service }
        "off" => { sudo /run/current-system/sw/bin/systemctl stop dae.service }
        "stat" => { /run/current-system/sw/bin/systemctl status dae.service }
        "test" => {
            let start = date now
            let result = (curl --max-time 10 https://google.com | complete)
            let duration = (date now) - $start

            if $result.exit_code == 28 {
                print $"(ansi red_bold)Timeout after 10s(ansi reset)"
                print ""
            } else if $result.exit_code == 0 {
                print $"curl google.com returned within (ansi green_bold)($duration)(ansi reset)"
            } else {
                print $"(ansi red_bold)curl failed, exit code = ($result.exit_code)(ansi reset)"
            }
        }
        _ => {
        }
    }
}
