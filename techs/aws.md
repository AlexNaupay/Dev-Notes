# AWS Commands


## Cloudfront

```bash
# Create distribution
aws cloudfront create-distribution --origin-domain-name link-static-website-s3 --default-root-object index.html
# List cloudfront distributions
aws cloudfront list-distributions --query "DistributionList.Items[*].{ID:Id,DomainName:DomainName,Origin:Origins.Items[0].DomainName}"
```

## VPC

```bash
# Internet Gateway
aws ec2 create-internet-gateway 
aws ec2 attach-internet-gateway --vpc-id vpc-XXXXX --internet-gateway-id igw-XXXXX

# Creación de un NAT Gateway y su asociación
aws ec2 create-nat-gateway --subnet-id subnet-XXXXX --allocation-id eipalloc-XXXXX
aws ec2 create-route-table --vpc-id vpc-XXXXX
aws ec2 create-route --route-table-id rtb-XXXXX --destination-cidr-block 0.0.0.0/0 --gateway-id nat-XXXXX
```

## Settings

```bash
aws configure  # To create a new configuration
aws configure list [--profile profile-name]  # Lists the profile
aws configure get region

aws cloudformation validate-template --output table|yaml|json --template-body file://template.yaml
```

```json
// https://www.baeldung.com/spring-ai-amazon-nova
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "bedrock:InvokeModel",
      "Resource": "arn:aws:bedrock:REGION::foundation-model/MODEL_ID"
    }
  ]
}
```