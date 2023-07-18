## Additional notes by mphho

In the Azure Portal, search for Virtual Machines.

1. Create a new virtual machine
- Resource group: linuxwordpress-rg
- Virtual machine name: linuxwordpressVM
- Region: East Asia (for Hong Kong)
- Availability options: No infrastructure redundancy required
- Security type: standard
- Image: Ubuntu Server 22.04 LTS - x64 Gen2
- VM architecture: x64
- Size: Standard_B1s (1 vcpus, 1 GiB memory)
- Authentication type: SSH public key
- Username: [yourusername]
- SSH public key source: Generate new key pair
- Key pair name: linuxwordpressKey

2. Next: Disks
- OS disk size: 30 GiB
- OS disk type: Standard SSD
- Leave everything else default

3. Next: Networking
- Virtual network: linuxwordpressVNet
- PublicIP: linuxwordpressIP
- Select inbound ports: HTTP, HTTPS, SSH
- Leave everything else default

4. Review + Create

Here's a script that can be used in the Azure CLI to create a VM with the same settings as above:
```
az group create --name linuxwordpress-rg --location "East Asia"
az vm create --resource-group linuxwordpress-rg --name linuxwordpressVM --image UbuntuLTS --size Standard_B1s --admin-username [yourusername] --generate-ssh-keys --public-ip-address linuxwordpressIP --vnet-name linuxwordpressVNet --subnet default --nsg linuxwordpressNSG --no-wait
```