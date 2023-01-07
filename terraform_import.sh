#!/bin/bash

terraform import azurerm_resource_group.resourcegroups "fil_rouge_grp_$TF_VAR_environment"
