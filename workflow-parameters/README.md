# Workflow Parameters
This folder contains the parameter yaml files used when running the argo workflow which publishes imagery to the [Registry of Open Data](https://registry.opendata.aws/nz-imagery/).

## How it works
As publishing to the ODR is considered a data release mechanism Imagery Mainters should ensure that data copied into `s3://nz-imagery` has at least two sets of eyes on it. 

### 1. Create Parameters Yaml file

**example.yaml:**
```yaml
"source": "s3://linz-imagery-staging/test/"
"target": "s3://linz-imagery-staging/test/sample_target/"
```

There are additional parameters which can be added if required more information can be found [here](https://github.com/linz/topo-workflows/tree/master/workflows/imagery#publish-copy).

**Save this file to the `workflow-parameters` folder** - if it is saved in any other location the workflow will not be run, subdirectories within this folder are ok.

### 2. Create a Pull Request

Create a pull request to this repo, using the XX pull request template, this standardises the information stored about each publish.

Once the pull request has been reviewed, approved, and merged the `publish-to-odr`(link?) Github Action will run. **This will sumbit a publish-odr argo workflow for any changed or added yaml files within the workflow-parameters directory.**

## Testing publish-to-odr
If making changes to the github action please **don't** test the Action using `publish-odr` and a `s3://nz-imagery` target, instead change the action to call `publish-copy` and use a temporary target like shown in the example above.

