#!/bin/bash

# Cron job setup script for auto-commit
# Sets up automated commits every 5 minutes
# Author: bc-express team
# Version: 1.0.0

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly AUTO_COMMIT_SCRIPT="$SCRIPT_DIR/auto-commit.sh"
readonly CRON_COMMENT="# bc-express auto-commit job"

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m'

# Logging
log() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} $*"
}

success() {
    echo -e "${GREEN}✅ $*${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $*${NC}"
}

error() {
    echo -e "${RED}❌ $*${NC}"
}

# Check if auto-commit script exists
check_auto_commit_script() {
    if [[ ! -f "$AUTO_COMMIT_SCRIPT" ]]; then
        error "Auto-commit script not found: $AUTO_COMMIT_SCRIPT"
        exit 1
    fi
    
    if [[ ! -x "$AUTO_COMMIT_SCRIPT" ]]; then
        log "Making auto-commit script executable..."
        chmod +x "$AUTO_COMMIT_SCRIPT"
        success "Auto-commit script is now executable"
    fi
}

# Install cron job
install_cron() {
    local interval="${1:-5}"
    local cron_expression="*/$interval * * * *"
    local cron_job="$cron_expression $AUTO_COMMIT_SCRIPT start >/dev/null 2>&1"
    
    log "Installing cron job to run every $interval minutes..."
    
    # Get current crontab
    local current_cron
    current_cron=$(crontab -l 2>/dev/null || echo "")
    
    # Check if job already exists
    if echo "$current_cron" | grep -F "$AUTO_COMMIT_SCRIPT" >/dev/null; then
        warning "Auto-commit cron job already exists"
        return 0
    fi
    
    # Add new cron job
    {
        echo "$current_cron"
        echo "$CRON_COMMENT"
        echo "$cron_job"
    } | crontab -
    
    success "Cron job installed successfully"
    success "Auto-commit will run every $interval minutes"
}

# Remove cron job
remove_cron() {
    log "Removing auto-commit cron job..."
    
    local current_cron
    current_cron=$(crontab -l 2>/dev/null || echo "")
    
    if ! echo "$current_cron" | grep -F "$AUTO_COMMIT_SCRIPT" >/dev/null; then
        warning "Auto-commit cron job not found"
        return 0
    fi
    
    # Remove lines containing the auto-commit script
    echo "$current_cron" | grep -v -F "$AUTO_COMMIT_SCRIPT" | grep -v -F "$CRON_COMMENT" | crontab -
    
    success "Cron job removed successfully"
}

# Show current cron jobs
show_cron() {
    log "Current cron jobs:"
    echo ""
    crontab -l 2>/dev/null || echo "No cron jobs found"
    echo ""
}

# Test auto-commit functionality
test_auto_commit() {
    log "Testing auto-commit functionality..."
    
    if [[ ! -x "$AUTO_COMMIT_SCRIPT" ]]; then
        error "Auto-commit script is not executable"
        return 1
    fi
    
    # Test the script
    if "$AUTO_COMMIT_SCRIPT" test; then
        success "Auto-commit test passed"
        return 0
    else
        error "Auto-commit test failed"
        return 1
    fi
}

# Show status
show_status() {
    echo ""
    echo -e "${BLUE}=== Auto-commit Status ===${NC}"
    echo ""
    
    # Check if script exists and is executable
    if [[ -f "$AUTO_COMMIT_SCRIPT" && -x "$AUTO_COMMIT_SCRIPT" ]]; then
        success "Auto-commit script: Ready"
    else
        error "Auto-commit script: Not ready"
    fi
    
    # Check cron job
    if crontab -l 2>/dev/null | grep -F "$AUTO_COMMIT_SCRIPT" >/dev/null; then
        success "Cron job: Installed"
        local cron_line
        cron_line=$(crontab -l 2>/dev/null | grep -F "$AUTO_COMMIT_SCRIPT")
        echo "  Schedule: $cron_line"
    else
        warning "Cron job: Not installed"
    fi
    
    # Check if cron service is running
    if systemctl is-active --quiet cron 2>/dev/null || systemctl is-active --quiet crond 2>/dev/null; then
        success "Cron service: Running"
    else
        warning "Cron service: Check status manually"
    fi
    
    echo ""
}

# Main menu
show_menu() {
    echo ""
    echo -e "${BLUE}=== bc-express Auto-commit Setup ===${NC}"
    echo ""
    echo "1. Install auto-commit (every 5 minutes)"
    echo "2. Install auto-commit (custom interval)"
    echo "3. Remove auto-commit"
    echo "4. Show cron jobs"
    echo "5. Test auto-commit"
    echo "6. Show status"
    echo "7. Exit"
    echo ""
    read -p "Choose an option (1-7): " choice
    
    case $choice in
        1)
            check_auto_commit_script
            install_cron 5
            ;;
        2)
            check_auto_commit_script
            read -p "Enter interval in minutes: " interval
            if [[ "$interval" =~ ^[0-9]+$ ]] && [[ $interval -gt 0 ]]; then
                install_cron "$interval"
            else
                error "Invalid interval. Please enter a positive number."
            fi
            ;;
        3)
            remove_cron
            ;;
        4)
            show_cron
            ;;
        5)
            test_auto_commit
            ;;
        6)
            show_status
            ;;
        7)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            error "Invalid option. Please choose 1-7."
            ;;
    esac
}

# Command line interface
case "${1:-}" in
    "install")
        check_auto_commit_script
        install_cron "${2:-5}"
        ;;
    "remove")
        remove_cron
        ;;
    "status")
        show_status
        ;;
    "test")
        test_auto_commit
        ;;
    "cron")
        show_cron
        ;;
    *)
        if [[ $# -eq 0 ]]; then
            # Interactive mode
            while true; do
                show_menu
                echo ""
                read -p "Press Enter to continue or Ctrl+C to exit..."
                clear
            done
        else
            echo "Usage: $0 [install|remove|status|test|cron] [interval]"
            echo ""
            echo "Commands:"
            echo "  install [interval]  - Install cron job (default: 5 minutes)"
            echo "  remove             - Remove cron job"
            echo "  status             - Show current status"
            echo "  test               - Test auto-commit functionality"
            echo "  cron               - Show current cron jobs"
            echo ""
            echo "Run without arguments for interactive menu"
            exit 1
        fi
        ;;
esac
