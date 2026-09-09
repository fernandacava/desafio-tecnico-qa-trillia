Param(
    [ValidateSet("all", "web", "api")]
    [string]$Suite = "all",
    [switch]$Headed
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $root

$python = Join-Path $env:LOCALAPPDATA "Programs\Python\Python312\python.exe"
$scripts = Join-Path $env:LOCALAPPDATA "Programs\Python\Python312\Scripts"
$env:Path = "$scripts;" + $env:Path

if (-not (Test-Path $python)) {
    Write-Error "Python 3.12 nao encontrado em $python. Instale e rode: python -m pip install -r requirements.txt ; rfbrowser init"
}

if (-not $env:PLAYWRIGHT_BROWSERS_PATH) {
    $playwrightDefault = Join-Path $env:LOCALAPPDATA "ms-playwright"
    if (Test-Path $playwrightDefault) {
        $env:PLAYWRIGHT_BROWSERS_PATH = $playwrightDefault
    }
}

$headless = if ($Headed) { "False" } else { "True" }
$args = @(
    "--outputdir", "results",
    "--logtitle", "Relatorio QA Trillia",
    "--reporttitle", "Teste Tecnico QA Trillia - Fernanda",
    "--variable", "HEADLESS:$headless"
)

switch ($Suite) {
    "web" { $args += "tests/web" }
    "api" { $args += "tests/api" }
    default { $args += "tests" }
}

& $python -m robot @args
exit $LASTEXITCODE
