# kube-auto-aws
kube-auto-aws is a set of scripts that allows you to deploy automatically a high availability Kubernetes cluster in AWS.

## Components
  - Terraform
  - Ansible

## Directories and files
```
buffer/: ansible store temporary kubernetes certificates to be distributed across control planes.
inventory/hosts: ansible hosts file generated by terraform.
media/: images and videos for documentation use.
modules/: terraform modules.
roles/: ansible roles.
templates/: template use to generate the ansible 'inventory/hosts' file.
```

## Steps to create the kubernetes cluster in a nutshell
- Create IAM user and generate a Key ID / Key password in AWS.
- Add AWS credentials to `credentials.tfvars`.
- Generate EC2-SSH key pairs and add the private key as `ssh-key.pem` to root of repository.
- Modify `terraform.vars` according your needs.
- Install Ansible in your local machine (the computer where you will run this repository from).
- Execute terraform commands for deploying the infrastructure to AWS.
- Execute Ansible command to install the Kubernetes cluster.
- That's it !.

## How to use

  - First, you need to create an IAM user in AWS and a pair of security credentials and replace them in the file `credentials.tfvars`.
  - Create a key pairs in AWS EC2 console and add the key to the root directory of the repository. We have one as an example named as `ssh-key.pem`
  
Example of file `credentials.tfvars` :
  ```
AWS_ACCESS_KEY_ID = "XXXXXXXXX"
AWS_SECRET_ACCESS_KEY = "zzzzzzzzzzzz"
AWS_SSH_KEY_NAME = "mysshkeyname"
AWS_DEFAULT_REGION = "zzzzz"
  ```
  - Depending in your AWS VPC networking and the number of master and worker nodes you want to deploy you need to adjust the values in file `terraform.vars`. A short description of the variables:
  
  ```
aws_cluster_name: friendly name of kubernetes cluster.
aws_vpc_cidr_block: the CIDR of the VPC to deploy the cluster.
aws_cidr_subnets_private: the subnets CIDR of the VPC.
aws_k8s_nodes_wl: Whitelisted public IPs to get access to kubernetes API and SSH in to servers [Add your public IP here so you are able to SSH in to the servers].
aws_kube_master_num: number of master nodes.
aws_kube_master_size: size of master servers.
aws_kube_worker_num: number of worker nodes.
aws_kube_worker_size: size of worker nodes.
aws_elb_api_port: port kubernetes api is exposed.
k8s_secure_api_port: port kubernetes api is exposed via load balancer. This is for HA clusters.
inventory_file: where terraform create list of hosts files for Ansible.
  ```
 
  - Init the terraform plugins with follow command:
 
 ```
 ./terraform init
 ```
  - Deploy the architecture to AWS. Terraform is going to create all resources in AWS neccesary to have properly running the kubernetes cluster.
 ```
./terraform apply -var-file=credentials.tfvars
 ```

Watch [this](https://asciinema.org/a/7iWFYggeZaexa6KQcfhBjOWtC) demo.

- Once the resources are created in AWS, we are going to install kubernetes components accordingly using Ansible (you need to have latest Ansible installed locally):
```
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i inventory/hosts --private-key ssh-key.pem --become -u ubuntu --become-user=root cluster.yml
```
Watch [this](https://asciinema.org/a/XYiS0h3S8Xrvdu4kWTV0L5GST) demo.

- Here a diagram of the example infrastructure defined in `terraform.tfvars`:

![Alt text](/media/k8s-ha-example.png?raw=true "Example Kubernetes cluster")

- Once you are done and want to delete the entired cluster with all resources, just perform:
```
./terraform destroy -var-file=credentials.tfvars
```