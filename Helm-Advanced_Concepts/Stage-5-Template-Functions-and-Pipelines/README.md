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

# 1b. Pipeline with arguments

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

