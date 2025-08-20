# Script para publicar o TalentFlow ATS no GitHub
Write-Host "Preparando para publicar o TalentFlow ATS no GitHub..." -ForegroundColor Green

# 1. Verificar se o Git está instalado
Write-Host "Verificando se o Git está instalado..." -ForegroundColor Yellow
$gitVersion = git --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git não está instalado. Por favor, instale o Git primeiro:" -ForegroundColor Red
    Write-Host "Download: https://git-scm.com/downloads" -ForegroundColor Yellow
    exit 1
}
Write-Host "✅ Git encontrado: $gitVersion" -ForegroundColor Green

# 2. Verificar se há um repositório Git inicializado
if (-not (Test-Path ".git")) {
    Write-Host "Inicializando repositório Git..." -ForegroundColor Yellow
    git init
    Write-Host "✅ Repositório Git inicializado" -ForegroundColor Green
}

# 3. Configurar usuário Git (se não estiver configurado)
$userName = git config --global user.name
$userEmail = git config --global user.email

if (-not $userName) {
    $name = Read-Host "Digite seu nome para configuração do Git"
    git config --global user.name "$name"
}

if (-not $userEmail) {
    $email = Read-Host "Digite seu email para configuração do Git"
    git config --global user.email "$email"
}

# 4. Adicionar arquivos ao staging
Write-Host "Adicionando arquivos ao staging..." -ForegroundColor Yellow
git add .
Write-Host "✅ Arquivos adicionados ao staging" -ForegroundColor Green

# 5. Fazer commit inicial
Write-Host "Fazendo commit inicial..." -ForegroundColor Yellow
git commit -m "Initial commit: TalentFlow ATS project"
Write-Host "✅ Commit realizado" -ForegroundColor Green

# 6. Criar repositório no GitHub (via API)
Write-Host "Criando repositório no GitHub..." -ForegroundColor Yellow

# Solicitar token de acesso do GitHub
$token = Read-Host "Digite seu token de acesso pessoal do GitHub (veja como criar: https://github.com/settings/tokens)"

if (-not $token) {
    Write-Host "❌ Token não fornecido. Criando instruções para criação manual..." -ForegroundColor Red
    
    # Criar instruções para criação manual
    $manualInstructions = @"
# INSTRUÇÕES PARA CRIAR REPOSITÓRIO MANUALMENTE NO GITHUB

1. Acesse: https://github.com/new
2. Preencha os dados:
   - Repository name: talentflow-ats
   - Description: A modern Applicant Tracking System built with React and TypeScript
   - Público/Privado: Escolha conforme sua preferência
3. Clique em "Create repository"

4. Execute estes comandos no terminal:

git remote add origin https://github.com/SEU_USUARIO/talentflow-ats.git
git branch -M main
git push -u origin main

Substitua SEU_USUARIO pelo seu nome de usuário do GitHub.
"@
    
    Set-Content -Path "INSTRUCOES_GITHUB.md" -Value $manualInstructions
    Write-Host "✅ Instruções salvas em INSTRUCOES_GITHUB.md" -ForegroundColor Green
    exit 0
}

# Solicitar nome de usuário do GitHub
$githubUser = Read-Host "Digite seu nome de usuário do GitHub"

# Nome do repositório
$repoName = "talentflow-ats"
$repoDescription = "A modern Applicant Tracking System built with React and TypeScript"

# Criar repositório via API
$headers = @{
    "Authorization" = "token $token"
    "Accept" = "application/vnd.github.v3+json"
}

$body = @{
    name = $repoName
    description = $repoDescription
    private = $false
    auto_init = $false
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    Write-Host "✅ Repositório criado com sucesso: $($response.html_url)" -ForegroundColor Green
} catch {
    Write-Host "❌ Erro ao criar repositório: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# 7. Adicionar remote origin
Write-Host "Configurando remote origin..." -ForegroundColor Yellow
git remote add origin "https://github.com/$githubUser/$repoName.git"
Write-Host "✅ Remote origin configurado" -ForegroundColor Green

# 8. Renomear branch principal para main (se necessário)
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    git branch -M main
    Write-Host "✅ Branch renomeada para 'main'" -ForegroundColor Green
}

# 9. Fazer push para o GitHub
Write-Host "Enviando código para o GitHub..." -ForegroundColor Yellow
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Código enviado com sucesso para o GitHub!" -ForegroundColor Green
    Write-Host "📦 Repositório: https://github.com/$githubUser/$repoName" -ForegroundColor Cyan
} else {
    Write-Host "❌ Erro ao enviar código para o GitHub" -ForegroundColor Red
    Write-Host "Tente executar manualmente: git push -u origin main" -ForegroundColor Yellow
}

# 10. Criar arquivo de instruções para deploy
$deployInstructions = @"
# TalentFlow ATS - Instruções de Deploy

## Deploy na Vercel (Recomendado)

1. Acesse https://vercel.com/
2. Faça login com sua conta GitHub
3. Clique em "Add New" -> "Project"
4. Selecione o repositório talentflow-ats
5. Clique em "Import"
6. Configure as opções:
   - Framework Preset: Vite
   - Root Directory: ./
   - Build Command: npm run build
   - Output Directory: dist
   - Install Command: npm install
7. Clique em "Deploy"

## Deploy na Netlify

1. Acesse https://netlify.com/
2. Faça login com sua conta GitHub
3. Clique em "Add new site" -> "Import an existing project"
4. Conecte com GitHub e selecione o repositório
5. Configure as opções:
   - Build command: npm run build
   - Publish directory: dist
6. Clique em "Deploy site"

## Deploy manual (Build local)

\`\`\`bash
npm run build
# A pasta 'dist' será criada com os arquivos estáticos
# Você pode hospedar esses arquivos em qualquer serviço de hospedagem
\`\`\`

## Variáveis de Ambiente

O projeto não requer variáveis de ambiente para a versão inicial, mas quando conectar com um backend, você precisará configurar:

- API_URL: URL da sua API
- Outras variáveis específicas do backend
"@

Set-Content -Path "DEPLOY_INSTRUCTIONS.md" -Value $deployInstructions
Write-Host "✅ Instruções de deploy salvas em DEPLOY_INSTRUCTIONS.md" -ForegroundColor Green

# 11. Adicionar README melhorado
$improvedReadme = @'
# TalentFlow ATS

A modern Applicant Tracking System built with React, TypeScript, and Tailwind CSS.

![TalentFlow ATS](https://img.shields.io/badge/React-18.2.0-blue.svg)
![TypeScript](https://img.shields.io/badge/TypeScript-4.9.5-blue.svg)
![Vite](https://img.shields.io/badge/Vite-4.2.0-purple.svg)

## ✨ Features

- 📊 Dashboard with recruitment analytics
- 👥 Candidate management
- 💼 Job posting and management
- 🎨 Dark/Light theme support
- 📱 Responsive design
- 🔍 Advanced filtering and search
- 📈 Data visualization with charts

## 🚀 Quick Start

### Prerequisites

- Node.js 16+
- npm or yarn

### Installation

1. Clone the repository:
\`\`\`bash
git clone https://github.com/your-username/talentflow-ats.git
cd talentflow-ats
\`\`\`

2. Install dependencies:
\`\`\`bash
npm install
\`\`\`

3. Start the development server:
\`\`\`bash
npm run dev
\`\`\`

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

### Demo Credentials

- Email: admin@example.com
- Password: password

## 📦 Build for Production

\`\`\`bash
npm run build
\`\`\`

## 🛠️ Tech Stack

- **Frontend**: React 18, TypeScript
- **Styling**: Tailwind CSS
- **Charts**: Recharts
- **Routing**: React Router
- **Build Tool**: Vite
- **Icons**: Emoji (plan to replace with React Icons)

## 📁 Project Structure

\`\`\`
src/
├── api/           # API functions and mock data
├── assets/        # Static assets
├── components/    # Reusable UI components
├── context/       # React context providers
├── features/      # Feature-specific hooks and utilities
├── hooks/         # Custom React hooks
├── lib/           # Utilities, constants, and types
├── pages/         # Page components
└── main.tsx       # Application entry point
\`\`\`

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (\`git checkout -b feature/AmazingFeature\`)
3. Commit your changes (\`git commit -m 'Add some AmazingFeature'\`)
4. Push to the branch (\`git push origin feature/AmazingFeature\`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Vite team for the amazing build tool
- Tailwind CSS for the utility-first CSS framework
- React community for excellent components and libraries
'@

Set-Content -Path "README.md" -Value $improvedReadme
Write-Host "✅ README.md atualizado" -ForegroundColor Green

# Fazer commit e push das atualizações
git add README.md DEPLOY_INSTRUCTIONS.md
git commit -m "docs: Update README and add deployment instructions"
git push

Write-Host "🎉 Processo concluído com sucesso!" -ForegroundColor Green
Write-Host "🌐 Seu repositório: https://github.com/$githubUser/$repoName" -ForegroundColor Cyan
Write-Host "📚 Consulte o arquivo DEPLOY_INSTRUCTIONS.md para instruções de deploy" -ForegroundColor Yellow