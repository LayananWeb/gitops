{{- define "mas-presensi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mas-presensi.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s" .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "mas-presensi.labels" -}}
app.kubernetes.io/name: {{ include "mas-presensi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{- end -}}

{{- define "mas-presensi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "mas-presensi.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{- define "mas-presensi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mas-presensi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
