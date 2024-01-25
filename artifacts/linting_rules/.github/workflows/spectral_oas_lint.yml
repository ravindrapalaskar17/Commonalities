---
# CAMARA Project - workflow configuration to manually run CAMARA OAS rules
# see https://docs.github.com/en/actions/using-workflows/manually-running-a-workflow
# 31.01.2024 - initial version

name: Spectral manual run

on: workflow_dispatch
 
concurrency:
  group: ${{ github.ref }}-${{ github.workflow }}
  cancel-in-progress: true

jobs:
  build:
    name: Spectral linting
    runs-on: ubuntu-latest
    permissions:
      # Give the default GITHUB_TOKEN write permission to commit and push, comment issues & post new PR
      # Remove the ones you do not need
      contents: write
      issues: write
      pull-requests: write
    steps:
      # Git Checkout
      - name: Checkout Code
        uses: actions/checkout@v3
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          fetch-depth: 0 # If you use VALIDATE_ALL_CODEBASE = true, you can remove this line to improve performances
      - name: Install Spectral
        run: npm install -g @stoplight/spectral
      - name: Install Spectral functions
        run: npm install -g @stoplight/spectral-functions
      - name: Run spectral:oas Spectral Linting
        run: spectral lint code/API_definitions/*.yaml --verbose --ruleset .spectral.yml > spectral.log 2>&1
         # Save Spectral report log file
      - name: Save Spectral report log
        if: ${{ success() }} || ${{ failure() }}
        run: |
          mkdir -p spectral-report
          cp spectral.log spectral-report/spectral.log
      # Upload MegaLinter artifacts
      - name: Archive production artifacts
        if: ${{ success() }} || ${{ failure() }}
        uses: actions/upload-artifact@v3
        with:
          name: Spectral report
          path: |
            spectral-report
            spectral.log
          
