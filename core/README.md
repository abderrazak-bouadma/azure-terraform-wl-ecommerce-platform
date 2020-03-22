# White label infrastructure Core components

this folder holds what is supposed to be core components to build the white label infrastructure
the following components will be created :

> * Resource group
> * vault to store secrets
> * storage account

# resource group
creates the principal resource group under which all related resources are organized

# vault
all secrets, certificates, passwords should be stored and managed here

# storage account
used to store all needed data like boot diagnostics, special configuration


# service principal
all resources are created on behalf a `service principal`
please ensure that all needed environment variables starting with `ARM_*` and `TF_VAR_*`are correctly set.

# Installation of the VSTS agent
installation is automatic and should be the last app to install
the installation of a `VSTS agent` needs a `PAT` or a `Personal Access Token` which you can generate front the security tab of `VSTS`
the `PAT` is only used for installation purpose and it's no more used by the agent to authenticate into `VSTS`
please update you local `.pat` file with a valid one each time it's necessary.
the value is stored into the vault under the `key=vsts_agent_pat` which let other environments to've access during creation time.
