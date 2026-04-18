{{- define "ui-helm-lib-generic.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
  namespace: {{ .Values.namespace }}
spec:
  {{- if not .Values.autoscaling.enabled }}
  replicas: {{ .Values.deployment.replicaCount | default 2  }}
  {{- end }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      {{- if .Values.imagePullSecrets }}
      imagePullSecrets:
      - name: {{ .Values.imagePullSecrets }}
      {{- end }}
      containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.deployment.containers.image.repository }}:{{ .Values.deployment.containers.image.tag }}"
        imagePullPolicy: {{ .Values.deployment.containers.image.pullPolicy }}
        {{- if .Values.deployment.containers.securityContext }}
        securityContext:
          {{- toYaml .Values.deployment.containers.securityContext | nindent 10 }}
        {{- end }}
        ports:
          - containerPort: {{ .Values.service.port }}
        {{- if .Values.deployment.resources }}
        resources:
          {{- toYaml .Values.resources | nindent 10 }}
        {{- end }}
        {{- if .Values.deployment.env }}
        env:
          {{- toYaml .Values.deployment.env | nindent 10}}
        {{- end }}
{{- end }}