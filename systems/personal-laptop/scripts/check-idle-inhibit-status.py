#!/usr/bin/env python3

import json
import subprocess

def idle_inhibited(node):
    if node['type'] == "con":
        if node.get("inhibit_idle", False):
            return True
    
    return any(idle_inhibited(n) for n in node.get("nodes", []))

def run():
    output = subprocess.check_output(['swaymsg', '-t', 'get_tree'])
    if idle_inhibited(json.loads(output)):
        print("🖥️🔒❌")
    else:
        print("🖥️🔒✅")


if __name__ == "__main__":
    run()
