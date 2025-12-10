{{/*

This is how to add comment in Helm

What is _helpers.tpl in Helm?

1. _helpers.tpl is a template helper file
2. It is NOT rendered into Kubernetes YAML
3. It holds reusable functions (snippets) using define
4. These helpers are called using include from other templates

*/}}


{{/*
What are we doing here?

We are going to create a named helper function called "stage2.name""
.Chart.Name is a helm object that outputs the chartname.

When we call this helper function using an include in other tmplate files, the function will
return the name of the chart. It avoid hardcoring values. 

eg: app: {{ include "stage3.name" . }}

define "<function_name>" : Used to creata a function

end: It is the ending of the function

*/}}

{{- define "stage3.name" -}}
{{ .Chart.Name }}
{{- end }}





{{/*
Create a full name: <release-name>-<chart-name>

{{ printf "%s-%s" .Release.Name .Chart.Name }} means to return "releasename"- "chartname"

The main purpose is to make sure the resource names are unique.
*/}}


{{- define "stage3.fullname" -}}
{{ printf "%s-%s" .Release.Name .Chart.Name }}
{{- end }}




{{/*
Common labels
Here is the helm install command is:  helm install prod stage2

The labels will look like:

app.kubernetes.io/name: stage2
app.kubernetes.io/instance: prod


Note: app.kubernetes.io/* :  These labels are official Kubernetes recommended labels

*/}}
{{- define "stage3.labels" -}}
app.kubernetes.io/name: {{ include "stage3.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
