# Imagery

Toitū Te Whenua makes New Zealand’s most up-to-date publicly owned aerial imagery freely available to use under an open licence. You can access this through the LINZ Data Service, LINZ Basemaps service or Amazon AWS.


## AWS Access

Toitū Te Whenua provides a public requester pays bucket `s3://linz-imagery` in `ap-southeast-2`.


Using the [AWS CLI](https://aws.amazon.com/cli/) anyone with a AWS account can access all the imagery mentioned inside of this repository.

```
aws s3 ls s3://linz-imagery --request-payer requester
```