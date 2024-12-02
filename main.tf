locals {
  prefix = "aslkdjfhlksa"
}

resource "tfe_variable_set" "global" {
  name   = "${local.prefix}-global"
  global = true
}

resource "tfe_variable" "global" {
  key             = "${local.prefix}-scope-0"
  value           = "global"
  category        = "terraform"
  variable_set_id = tfe_variable_set.global.id
}

resource "tfe_variable_set" "global_priority" {
  name     = "${local.prefix}-global-priority"
  global   = true
  priority = true
}

# keys need to be unique for global varsets, regardless of priority
resource "tfe_variable" "global_priority" {
  key             = "${local.prefix}-scope-1"
  value           = "global-priority"
  category        = "terraform"
  variable_set_id = tfe_variable_set.global_priority.id
}

resource "tfe_variable_set" "organization" {
  name = "${local.prefix}-organization"
}

resource "tfe_variable" "organization" {
  count           = 2
  key             = "${local.prefix}-scope-${count.index}"
  value           = "organization"
  category        = "terraform"
  variable_set_id = tfe_variable_set.organization.id
}

resource "tfe_variable_set" "organization_priority" {
  name     = "${local.prefix}-organization-priority"
  priority = true
}

resource "tfe_variable" "organization_priority" {
  count           = 2
  key             = "${local.prefix}-scope-${count.index}"
  value           = "organization-priority"
  category        = "terraform"
  variable_set_id = tfe_variable_set.organization_priority.id
}

resource "tfe_project" "this" {
  name = "${local.prefix}-project"
}

resource "tfe_variable_set" "project" {
  name              = "${local.prefix}-project"
  parent_project_id = tfe_project.this.id
}

resource "tfe_variable" "project" {
  count           = 2
  key             = "${local.prefix}-scope-${count.index}"
  value           = "project"
  category        = "terraform"
  variable_set_id = tfe_variable_set.project.id
}

resource "tfe_variable_set" "project_priority" {
  name              = "${local.prefix}-project-priority"
  priority          = true
  parent_project_id = tfe_project.this.id
}

resource "tfe_variable" "project_priority" {
  count           = 2
  key             = "${local.prefix}-scope-${count.index}"
  value           = "project-priority"
  category        = "terraform"
  variable_set_id = tfe_variable_set.project_priority.id
}

resource "tfe_project_variable_set" "organization" {
  variable_set_id = tfe_variable_set.organization.id
  project_id      = tfe_project.this.id
}

resource "tfe_project_variable_set" "organization_priority" {
  variable_set_id = tfe_variable_set.organization_priority.id
  project_id      = tfe_project.this.id
}

resource "tfe_project_variable_set" "project" {
  variable_set_id = tfe_variable_set.project.id
  project_id      = tfe_project.this.id
}

resource "tfe_project_variable_set" "project_priority" {
  variable_set_id = tfe_variable_set.project_priority.id
  project_id      = tfe_project.this.id
}

resource "tfe_workspace" "this" {
  name           = "${local.prefix}-workspace"
  project_id     = tfe_project.this.id
  execution_mode = "remote"
}

resource "tfe_workspace_variable_set" "organization" {
  variable_set_id = tfe_variable_set.organization.id
  workspace_id    = tfe_workspace.this.id
}

resource "tfe_workspace_variable_set" "organization_priority" {
  variable_set_id = tfe_variable_set.organization_priority.id
  workspace_id    = tfe_workspace.this.id
}

resource "tfe_workspace_variable_set" "project" {
  variable_set_id = tfe_variable_set.project.id
  workspace_id    = tfe_workspace.this.id
}

resource "tfe_workspace_variable_set" "project_priority" {
  variable_set_id = tfe_variable_set.project_priority.id
  workspace_id    = tfe_workspace.this.id
}
