## Deployment of Azure VM by using Terraform 

### Full deployment of Azure VM using Terraform.
#### Resources to be created after deployment:
- Azure Resource Group.
- Azure Virtual Network (1x).
- Azure Subnet (1x).
- Azure NIC (1x).
- Azure NSG, with inbound rules (22 and 80 port opened) and outbound rule.
- Azure Public IP.
- Azure Virtual Machine.

#### Terraform module consists of all necessary files according to BP.

### How to deploy?
1. First, make authentication Terraform with Microsoft Azure, using one of the methods in official docs - [:computer_mouse: CLICK HERE](https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash).
2. I'm using self-created SSH key on host machine which invoke in [main.tf](main.tf) & [inventory](_templates/inventory.tpl):
```
  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/moonkey.pub")
  }
  ---
  ansible_ssh_private_key_file=~/.ssh/moonkey
```

3. Configure backend state in [provider.tf](provider.tf) for storing terraform.tfstate remotely:
```ruby
  backend "azurerm" {
    resource_group_name  = "your_values"
    storage_account_name = "your_values"
    container_name       = "your_values"
    key                  = "your_values"
  }
```
5. Few words about module structe:
   - main.tf                  - here we have all assigned resources to be deployed.
   - variables.tf             - declaration of variables.
   - outuputs.tf              - provide some information about infra in command lines.
   - terraform.auto.tfvars    - assign values to a variables which could be used during deployment.
   - _templates/inventory.tpl - template of inventory file which would be used for creating Ansible inventory. 

4. Once previous steps are done, continue with terraform commands in a command line for major part:
   ```
   terraform fmt & terraform validate
   terraform init
   terraform plan
   terraform apply --auto-approve
   ```
5. !TADAAA! At the end you will gen an Public IP address and username of VM.




