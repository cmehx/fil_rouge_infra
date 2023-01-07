#!/bin/bash

environment=$0

terraform import azurerm_resource_group.resourcegroups "fil_rouge_grp_$environment"
