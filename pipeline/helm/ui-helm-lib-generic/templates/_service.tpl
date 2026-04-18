{{- define "ui-helm-lib-generic.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.service.metadata.name }}
  namespace: {{ .Values.namespace }}
  {{- if .Values.service.annotations }}
  annotations:
    {{- toYaml .Values.service.metadata.annotations | nindent 4 }}
  {{- end }}
spec:
  type: {{ .Values.service.type }}
  selector:
    {{ .Chart.Name }}
  ports:
  - port: {{ .Values.service.port }}
    {{- if .Values.service.protocol }}
    protocol: {{ .Values.service.protocol | default "TCP" }}
    {{- end }}
    {{- if .Values.service.targetPort }}
    targetPort: {{ .Values.service.targetPort }}
    {{- end }}
{{- end -}}
    
  
