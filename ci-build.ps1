#requires -PSEdition Core
param(
	[Alias('v')]
# Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic]
	[string]$verbosity = "minimal"
)

# Install reportgenerator if not present
if (-not (Get-Command reportgenerator -ErrorAction SilentlyContinue)) {
	dotnet tool install --global dotnet-reportgenerator-globaltool
}

# Helper for printing clickable paths in the terminal
function Write-ClickablePath {
	param([Parameter(Mandatory)][string]$Path, [string]$Message = $Path)
	$abs = (Resolve-Path -LiteralPath $Path).ProviderPath
	$abs = $abs -replace '\\', '/'
	$abs = [uri]::EscapeDataString($abs)
	$uri = [uri]"file:///$abs"
	Write-Host "`e]8;;$uri`a$Message`e]8;;`a"
}

# Clean test directory
Remove-Item -Recurse -Force artifacts/*/test-results -ErrorAction SilentlyContinue

# Run the build
dotnet test --verbosity $verbosity --configuration Release

# Generate coverage report
reportgenerator -reports:"artifacts/*/test-results/*.cobertura.xml" -targetdir:"artifacts" -reporttypes:"Cobertura;HtmlInline" -verbosity:Warning
Write-ClickablePath -Path "artifacts/index.html" -Message "📊 Coverage report"
