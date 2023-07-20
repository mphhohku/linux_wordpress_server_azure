# Automation of the creation of a Linux VM image on Azure using HashiCorp Packer (by mphho)

## Basics
1. Install [Chocolatey](https://chocolatey.org/install) and [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli) on your working desktop (not on the Azure VM).
- As of July 19, 2023, for Windows, run PowerShell as Administrator and paste the following commands:
```
	# install chocolatey
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

	# install packer
	choco install packer
```

2. Refer to the Microsoft Learn documentation: [How to use Packer to create Linux virtual machine images in Azure](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/build-image-with-packer).

- Create a resource group in Azure using the Azure CLI:
```
	az group create -n linuxwordpresspacker-rg -l eastasia
```
- Note the Azure Subscription ID in [the Azure Portal](https://portal.azure.com/#view/Microsoft_Azure_Billing/SubscriptionsBlade) or using the following command:
```
	az account show --query "{ subscription_id: id }"
```
- Create a service principal using the Azure CLI, replacing `<subscription_id>` with your subscription ID:
```
	az ad sp create-for-rbac --role Contributor --scopes /subscriptions/<subscription_id> --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"
```
- Note the output like the following: (This is only an example. These are not real.)
```
{
    "client_id": "f5b6a5cf-fbdf-4a9f-b3b8-3c2cd00225a4",
    "client_secret": "0e760437-bf34-4aad-9f8d-870be799c55d",
    "tenant_id": "72f988bf-86f1-41af-91ab-2d7cd011db47"
}
```

## Make a Packer template
Edit the ``wordpress-azure-ubuntu.pkr.hcl`` file in the ``packer`` directory. Replace the following values:
- Replace the `client_id`, `client_secret`, and `tenant_id` values with the values from the service principal that you created.
- Replace the `subscription_id` value with your subscription ID.

## Build the image
1. Open a PowerShell terminal in your VS Code editor. Change to the packer directory:
```
	cd packer
```
2. Run the following command to build the image:
```
	packer build wordpress-azure-ubuntu.pkr.hcl
```
3. If the program fails at some point, the program will delete the resource groups created by packer. Do not interrupt or exit the program. When it finishes, you can try again.
4. After the build process finishes, note the value of the `image_id` property in the output. You use this value to create a virtual machine from the image. Also, note the SQL password several lines above.
