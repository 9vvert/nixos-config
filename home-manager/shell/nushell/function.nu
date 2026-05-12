def launch [...args: string] {
    let cmd = ($args | str join " ")

    if ($cmd | is-empty) {
        print "usage: launch <command> [args...]"
        return
    }

    sh -c $"nohup ($cmd) >/dev/null 2>&1 &"
}