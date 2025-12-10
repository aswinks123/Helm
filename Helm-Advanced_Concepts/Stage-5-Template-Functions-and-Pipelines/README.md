# Template Functions & Pipelines

## 1. Pipelines (|)

In Helm (Go templates), a pipeline passes the output of one expression as input to the next function.


value | function

This means: Pass the value to the function.

### Simple Helm example
```
{{ .Values.env | quote }}
```

What happens:

.Values.env is evaluated

Its value is sent into quote

Output is quoted like this: ("value")

## 1b. Pipeline with arguments

{{ toYaml .Values.resources | nindent 4 }}

Pipeline value is passed as the last argument

### Allowed pipeline sources

1. You can pipeline from:

2. Variables

3. .Values

4. .

5. Function output


# 2. with

"with" temporarily changes the dot (.) context to the value you specify.

Syntax:

```
{{ with VALUE }}
  ...
{{ end }}
```

### Example

Lets assume this is the content of values.yaml file

```
resources:
  limits:
    cpu: 250m
```

template:

```
{{ with .Values.resources }}
limits:
  cpu: {{ .limits.cpu }}
{{ end }}
```

What happend?

Outside "with" . is root context

But, inside "with" . becomes .Values.resources, Now we can directly refer the limits using ".limits"

### Important behavior of with

with runs only if value is non-empty

If you want to refer the root context inside with, use "$"

```
{{ with .Values.resources }}
chart: {{ $.Chart.Name }}
{{ end }}
```

Now $.Chart.Name will call the root context because we set the . as .values.resources using "with"

# 3. Scope control (. vs $)

. (dot) means current context. it chnages when you use with, range etc.

$ (dollar) means root context. It never changes, it always points to the top-level context, een inside a range or with.

Important: If you need anything global (Values, Chart, Release) inside with or range, use $.


# 4. toYaml

toYaml is a Helm function that converts a Go map / list into a YAML-formatted string.

toYaml accepts: Maps, Lists (strings and numbers are not supported)

Valid inputs:

```
.Values.resources

.Values.labels

.Values.env

. inside with / range
```

### Why toYaml is needed?

Lets consider this example Map that is present in values.yaml file

```
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 250m
    memory: 256Mi
```

Scenario 1: without toYaml

When this resource is refered in template file:

```
resources:
{{ .Values.resources }}
```

the output will look like this, because Go prints it as a string by default. and kubernetes will fail

```
resources:
map[requests:map[cpu:100m memory:128Mi] limits:map[cpu:250m memory:256Mi]]
```

Scenario 2: with toYaml

```
resources:
{{toYaml .Values.resources }}
```

The YAML will rendered like this:

```
resources:
requests:
  cpu: 100m
  memory: 128Mi
limits:
  cpu: 250m
  memory: 256Mi
```

Looks good?. But there is still a problem, notice the intentation of elemets, its not proper. That is the reason why we use "nindent" function.

Lets add nindent to the same template again:

```
resources:
{{ toYaml .Values.resources | nindent 2 }}'
```

Result after nindent:

```
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 250m
    memory: 256Mi

```

Now the indententation is properly rendered.

Basically: nindent 2 add 2 spaces before each line + a newline at the top