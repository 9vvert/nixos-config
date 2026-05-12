def dae [option:string] {
    match option {
        "on" => { sudo systemctl start dae }
        "off" => { sudo systemctl stop dae }
        "stat" => { systemctl status dae }
        "test" => { 
            let result = timeit { 
                curl --max-time 10 https://google.com out+err>| ignore 
            }
            
            if $result.exit_code == 28 {
                print $"(ansi red_bold)Timeout after 10s(ansi red_bold)"
                print ""
            } else if $result.exit_code == 0 {
                print $"curl google.com returned within(ansi green_bold) ($result.duration)s(ansi green_bold)"
            } else {
                print $"(ansi red_bold)curl failed, exit code = ($result.exit_code)(ansi reset)"
            }
        }
        _ => {
            
        }
    }
}