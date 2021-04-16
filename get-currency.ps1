$path = "C:\path\"
$pathFile = $path+"currency.csv"

$currencies = ("euro","dolar","uf")
$delimiter = ","

$previousDays=$args[0]
IF([string]::IsNullOrEmpty($previousDays)) {
	$previousDays=0
}

$restDate = $((Get-Date).AddDays(-$previousDays).ToString('dd-MM-yyyy'))
$date = $((Get-Date).AddDays(-$previousDays).ToString('yyyyMMdd'))

Set-Content -Path $pathFile -Value "Fecha $delimiter Divisa $delimiter Valor"

Foreach ($currency in $currencies){
	$uri = "https://mindicador.cl/api/$currency/$restDate"
	$response = Invoke-RestMethod -Uri $uri
	Add-Content -Path $pathFile -Value "$date$delimiter$($response.codigo)$delimiter$($response.serie.valor)"
}