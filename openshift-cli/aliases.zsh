alias ocapprovecsr="oc get csr -o go-template='{{range .items}}{{if not .status}}{{.metadata.name}}{{\"\n\"}}{{end}}{{end}}' | xargs oc adm certificate approve"
function ocdecsecret(){
    oc get secret $1 -o json | jq -r '.data."'$2'"' | base64 -D -
}