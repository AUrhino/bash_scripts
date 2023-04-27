#!/bin/bash
# Setup auditd on Ubuntu, Debian machines.
#
# Examples:
# 	aureport --tty #show root logons
#   ausearch -ue 0 -ts today # to view root commands:
#   ausearch -ua <userid> # to view user commands:
# to view root commands:
# 	ausearch -ue 0
#
# * Auditing root commands (real uid)
#     ausearch -ue 0  # all root commands
#     ausearch -ua 1000  # all commands by auid=1000

# Install the auditd package
apt-get update
apt-get install -y auditd

# Delete the line pam_tty_audit.so
sed -i '/pam_tty_audit.so/d' /etc/pam.d/sshd
echo 'session required pam_tty_audit.so enable=*' >> /etc/pam.d/sshd

# add this line to the bottom of the file
echo 'session required pam_tty_audit.so enable=* enable=root' >> /etc/pam.d/sshd

# add a couple more required lines:
echo '-a exit,always -F arch=b64 -F euid=0 -S execve' >> /etc/audit/rules.d/audit.rules
echo '-a exit,always -F arch=b32 -F euid=0 -S execve' >> /etc/audit/rules.d/audit.rules
echo 'Check that it worked'
grep -- '-a exit,always -F arch=b64 -F euid=0 -S execve' /etc/audit/rules.d/audit.rules

# reload service so this change is reflected
systemctl restart auditd

echo 'Setup complete. You must reboot.'
