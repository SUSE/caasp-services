# Helm Dependency Management

**Q:** How dependencies are handled between charts in Helm?

**A:** A helm chart may depend on one or more other charts referred to as dependencies. 
 - Dependencies are defined in a chart's `requirements.yaml` file.
 - Dependencies are made up of three attributes: name, version, and repository.
 - A repository can be a remote server or a local path.
 - Example `requirements.yaml`:
 
   ```yaml
   dependencies:
    - name: apache
      version: 1.2.3
      repository: http://example.com/charts
    - name: mysql
      version: 3.2.1
      repository: http://another.example.com/charts
   ```
  - Ref: https://docs.helm.sh/developing_charts/#chart-dependencies
  
---
  
**Q:** Is it possible to create a meta package which would encapsulate the package and all of its dependencies?

**A:** Yes is is possible. Keep in mind that the dependencies will be defined in a cascading manner.

---

**Q:** Is it possible to have an optional dependency?

**A:** Yes it possible by using Tags and Conditions.

> Condition - The condition field holds one or more YAML paths (delimited by commas). If this path exists in the top parent’s values and resolves to a boolean value, the chart will be enabled or disabled based on that boolean value. Only the first valid path found in the list is evaluated and if no paths exist then the condition has no effect.

> Tags - The tags field is a YAML list of labels to associate with this chart. In the top parent’s values, all charts with tags can be enabled or disabled by specifying the tag and a boolean value.

Ref: https://docs.helm.sh/developing_charts/#tags-and-condition-fields-in-requirements-yaml

---

**Q:** When doing upgrades, how are dependencies handled? Can we upgrade a package along with upgrading all of its dependencies?

**A:** When running the command `helm dependency update CHART` helm "will pull down the latest charts that satisfy the dependencies, and clean up old dependencies."

Ref: https://docs.helm.sh/helm/#helm-dependency-update

---

**Q:** Is there any config-sharing mechanism between dependencies?

**A:** Yes, a custom chart can override the default values of its dependencies in its `values.yaml` file or values can be provided via the command line when installing or upgrading charts.

