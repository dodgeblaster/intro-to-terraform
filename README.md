# Notes

## Blog Series these docs are based on

https://blog.gruntwork.io/an-introduction-to-terraform-f17df9c6d180#3ec6

## TF Examples

https://github.com/gruntwork-io/intro-to-terraform

## Notes

### Terraform Commands

```
terraform init = gets aws code so we can actually deploy to aws
tarraform plan = tells u what will happen
terraform apply = actually deploy
terraform destroy = removes everything
```

workspaces are tf's version of stages

to create a new workspace:

```
terraform workspace new nameOfWorkspace
```

you can switch between workspaces using the select command:

```
terraform workspace select nameOfWorkspace
```

implementing differences in environments:
Article on Logic:
https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9

```
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = (
    terraform.workspace == "default"
    ? "t2.medium"
    : "t2.micro"
  )
}
```

## Notes on modules

A module is any tf file in a folder.
The main.tf file at the root of your project is called the root module

A good convention is to have the following tf files in a folder to make up a module:

```
main.tf
variables.tf
outputs.tf
```

The syntax for using a module in your root or any other tf file is:

```
module "<NAME>" {
  source = "<SOURCE>"
  [CONFIG ...]
}
```

## Project Structure

https://medium.com/@dav009/terraform-sane-practices-project-structure-c4347c1bc0f1

## Terraform + Serverless Framework

https://www.serverless.com/blog/definitive-guide-terraform-serverless
