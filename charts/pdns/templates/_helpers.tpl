{{- /*
  Root helper to build backend FQDN: <svc>.<namespace>.svc.cluster.local:<port>
  Uses values.backend.* from umbrella values (merged subchart values).
*/ -}}
{{- define "app.FQDN" -}}
{{- $svcName := default (printf "%s" .Release.Name) -}}
{{- $svcNS := default .Release.Namespace  -}}
{{- $svcPort := int (default 8081 .Values.service.webserver.port) -}}
{{- printf "%s.%s.svc.cluster.local:%d" $svcName $svcNS $svcPort -}}
{{- end -}}