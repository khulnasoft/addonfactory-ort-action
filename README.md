# ADDONFACTORY-ORT-ACTION

This action scans a project for third party components and reports the results. This action contains a curation file managed by KhulnaSoft, Ltd.. Source is provided for this action however it may not be useful outside of our organization.

[Forked version](https://github.com/khulnasoft/ort) of `ort` is being used. The only difference is this [commit](https://github.com/khulnasoft/ort/commit/78a98b8811fb4051dc18010bdda1bf09075bdf37) which assumes that the repository's it is scanning is Python 3 and will not fallback to Python 2 in case of any errors.

# v1

```yaml
steps:
    - 
    name: ort-action
    uses: khulnasoft/addonfactory-ort-action@v1
    id: ort-action
    - 
    name: ort-action-artifacts
    uses: actions/upload-artifact@v2
    with:
        name: analysis
        path: .ort/
```

# License

The scripts and documentation in this project are released under the [Apache 2.0 License](LICENSE)

# Contributions

See [our contributor license agreement](https://github.com/khulnasoft/cla-agreement/blob/main/CLA.md)

## Code of Conduct

:wave: Be nice.  See [our code of conduct](https://github.com/khulnasoft/cla-agreement/blob/main/CODE_OF_CONDUCT.md)