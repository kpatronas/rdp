# rdp
RDP Over SSH 

A simple RDP over SSH cli tool for Linux, requires xfreerdp and ssh keys

## Configuration example
Configuration must exist in  $HOME/.rdp/rdp.cfg
```
declare -A RDP_HOSTS
RDP_HOSTS[rdp_host]="domain comment ssh_gateway_host username password"
RDP_HOSTS[rdp_host1]="domain comment1 ssh_gateway_host1 username1 password2"
RDP_HOSTS[rdp_host2]="domain comment2 ssh_gateway_host2 username1 password2"
```
* domain: The windows domain
* comment: just a comment
* ssh_gateway_host: the ssh gateway to connect through
* username: the rdp host username
* password: the rdp host password
* rdp_host: the rdp hostname

# Examples
## List all hosts

Entering rdp will print all configured rdp hosts
```
$ rdp
host         domain   description  gateway
----         ------   -----------  -------
grvapp1      prod     production   ssh_gw1
grvapp2      test     test         ssh_gw2
```

## Connect to RDP host
```
$ rdp grvapp1
```
