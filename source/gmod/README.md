# gmod
This directory contains the automated deployment/crestion of GMod images/servers by using the Hetzner
Cloud. Moreover, to simplify the server access, automatic DNS entries are set in Cloudflare.

This README file contains a basic description on how to setup and run this configuration/tool.

## Setup

### packer

Before you can start building your first image, you should set the correct values inside the file `packer_run.sh`:

| Name                     | Required | Description                                                                                                                                                                                 |
|--------------------------|----------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| GMOD_MAX_PLAYERS         | X        | The maximum amount of players who can play on this GMod server.                                                                                                                             |
| GMOD_COLLECTION_ID       | X        | The unique ID of the Steam Workshop collection you want to play on this server. See [Updated: How to Find Mod ID for any Steam workshop game.](https://www.youtube.com/watch?v=NzMlB-8f6mc) |
| GMOD_START_MAP           | X        | The map to start with when you start afresh.                                                                                                                                                |
| GMOD_SERVER_START_PARAMS |          | The default GMod server start parameters which you can modify.                                                                                                                              |
| HETZNER_TOKEN            | X        | The token to use when communicating with the Hetzner API. See [Hetzner Cloud API Authentication](https://docs.hetzner.cloud/#overview-authentication)                                       |

#### Remove resources

In order to remove the packer snapshots open up the Hetzner Cloud Console and delete the snapshots manually.

### terraform

First of all, should set the correct terraform variables inside the file `terraform.tfvars`:

| Name                      | Description                                                                                                                                                                                |
|---------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| hcloud_token              | The Hetzner Cloud API token. See [Hetzner Cloud API Authentication](https://docs.hetzner.cloud/#overview-authentication)                                                                   |
| hcloud_ssh_keys           | An array of IDs/names of the SSH keys to add to the created instance.                                                                                                                      |
| cloudflare_email          | Your Cloudflare email.                                                                                                                                                                     |
| cloudflare_api_key        | The Cloudflare API key (not to be confused with an API token). See [Managing API Tokens and Keys](https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys) |
| cloudflare_domain_zone_id | The Cloudflare Domain Zone ID of the domain to add the subdomain to. See [Where To Find Zone ID](https://community.cloudflare.com/t/where-to-find-zone-id/132913)                          | 

Moreover, you can adjust some default variables in the file `variables.tf` according to your own needs.

In order to initialize terraform, you have to run the terraform initialization command:

```shell script
terraform init
```

Afterwards, you can see which resources are about to be created by running the terraform plan command:

```shell script
terraform plan
```

Finally, the resources can be created by running the terraform apply command:
```shell script
terraform apply
```

**Please note:** The local terraform state image is used to keep track of the resources which have 
been created remotely. **Do not delete/modify the local state file!**

#### Remove resources

In order to remove the Hetzner Cloud instance and the Cloudflare DNS entry run the terraform destroy command:
```shell script
terraform destroy
```
