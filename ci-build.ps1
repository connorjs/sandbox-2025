#!/usr/bin/env pwsh

param(
	[Alias('c')]
# The configuration to use. Typically "Debug" or "Release".
	[string]$configuration = "Release",

	[Alias('v')]
# Set the MSBuild verbosity level. Allowed values are q[uiet], m[inimal], n[ormal], d[etailed], and diag[nostic]
	[string]$verbosity = "minimal"
)

# Install reportgenerator if not present
if (-not (Get-Command reportgenerator -ErrorAction SilentlyContinue)) {
	dotnet tool install --global dotnet-reportgenerator-globaltool
}

# Clean artifacts
Remove-Item -Recurse -Force "artifacts" -ErrorAction SilentlyContinue

# Run the build
dotnet build `
	--configuration $configuration `
	--verbosity $verbosity
dotnet test `
	--configuration $configuration `
	--verbosity $verbosity

# Generate coverage report
reportgenerator -reports:"artifacts/*/TestResults/*.cobertura.xml" -targetdir:"artifacts/report" -reporttypes:"Cobertura;HtmlInline" -verbosity:Warning
Remove-Item "artifacts/report/index.htm"; # Remove `index.htm` in favor of just `index.html` to simplify tab-completion on CLI.
