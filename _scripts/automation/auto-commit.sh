#!/bin/bash

# Auto-commit script for bc-express bootcamp
# Executes every 5 minutes via cron job
# Follows conventional commits standard in English
# Author: bc-express team
# Version: 1.0.0

set -euo pipefail

# Configuration
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
readonly LOG_FILE="$SCRIPT_DIR/auto-commit.log"
readonly MAX_LOG_SIZE=1048576  # 1MB
readonly COMMIT_TYPES=(
    "feat"      # New feature
    "fix"       # Bug fix
    "docs"      # Documentation only changes
    "style"     # Changes that do not affect the meaning of the code
    "refactor"  # A code change that neither fixes a bug nor adds a feature
    "test"      # Adding missing tests or correcting existing tests
    "chore"     # Changes to the build process or auxiliary tools
    "perf"      # A code change that improves performance
    "ci"        # Changes to CI configuration files and scripts
    "build"     # Changes that affect the build system or external dependencies
)

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

# Logging function
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Error handling
error_exit() {
    log "ERROR" "$1"
    exit 1
}

# Success logging
log_success() {
    log "SUCCESS" "$1"
    echo -e "${GREEN}✅ $1${NC}"
}

# Warning logging
log_warning() {
    log "WARNING" "$1"
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Info logging
log_info() {
    log "INFO" "$1"
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Rotate log file if it gets too large
rotate_log() {
    if [[ -f "$LOG_FILE" && $(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE" 2>/dev/null || echo 0) -gt $MAX_LOG_SIZE ]]; then
        mv "$LOG_FILE" "${LOG_FILE}.old"
        log_info "Log file rotated due to size limit"
    fi
}

# Check if we're in a git repository
check_git_repo() {
    if ! git -C "$PROJECT_ROOT" rev-parse --git-dir >/dev/null 2>&1; then
        error_exit "Not in a git repository: $PROJECT_ROOT"
    fi
}

# Check for uncommitted changes
has_changes() {
    git -C "$PROJECT_ROOT" diff-index --quiet HEAD -- 2>/dev/null
    return $?
}

# Check for untracked files
has_untracked() {
    [[ -n $(git -C "$PROJECT_ROOT" ls-files --others --exclude-standard) ]]
}

# Analyze changes to determine commit type and scope
analyze_changes() {
    local changes
    changes=$(git -C "$PROJECT_ROOT" diff --cached --name-status)
    
    # Count different types of changes
    local added_files=0
    local modified_files=0
    local deleted_files=0
    local docs_changes=0
    local config_changes=0
    local test_changes=0
    local src_changes=0
    
    while IFS=$'\t' read -r status file; do
        case "$status" in
            A) ((added_files++)) ;;
            M) ((modified_files++)) ;;
            D) ((deleted_files++)) ;;
        esac
        
        # Categorize by file type
        case "$file" in
            *.md|*docs/*|*documentation/*) ((docs_changes++)) ;;
            *.json|*.yml|*.yaml|*.toml|*config*|*Config*|.*) ((config_changes++)) ;;
            *test*|*spec*|*__tests__*) ((test_changes++)) ;;
            *.ts|*.js|*.tsx|*.jsx|*src/*|*lib/*) ((src_changes++)) ;;
        esac
    done <<< "$changes"
    
    # Determine commit type based on analysis
    local commit_type="chore"
    local scope=""
    
    if [[ $docs_changes -gt 0 && $src_changes -eq 0 && $test_changes -eq 0 ]]; then
        commit_type="docs"
    elif [[ $test_changes -gt 0 && $src_changes -eq 0 ]]; then
        commit_type="test"
    elif [[ $config_changes -gt 0 && $src_changes -eq 0 ]]; then
        commit_type="chore"
        scope="config"
    elif [[ $src_changes -gt 0 ]]; then
        if [[ $added_files -gt $modified_files ]]; then
            commit_type="feat"
        else
            commit_type="fix"
        fi
    fi
    
    # Determine scope based on changed directories
    local main_dirs
    main_dirs=$(echo "$changes" | cut -f2 | cut -d'/' -f1 | sort | uniq -c | sort -nr | head -1 | awk '{print $2}')
    
    case "$main_dirs" in
        semana-*) scope="week$(echo "$main_dirs" | sed 's/semana-//')" ;;
        _docs) scope="docs" ;;
        _scripts) scope="scripts" ;;
        .github) scope="ci" ;;
        recursos-compartidos) scope="resources" ;;
        proyecto-final) scope="final-project" ;;
        *) [[ -z "$scope" ]] && scope="core" ;;
    esac
    
    echo "${commit_type}:${scope}:${added_files}:${modified_files}:${deleted_files}"
}

# Generate commit message based on changes
generate_commit_message() {
    local analysis="$1"
    IFS=':' read -r commit_type scope added modified deleted <<< "$analysis"
    
    local subject=""
    local body=""
    
    # Generate subject line
    case "$commit_type" in
        feat)
            if [[ $added -gt 1 ]]; then
                subject="add new features and components"
            else
                subject="add new feature implementation"
            fi
            ;;
        fix)
            if [[ $modified -gt 1 ]]; then
                subject="resolve multiple issues and bugs"
            else
                subject="resolve issue in implementation"
            fi
            ;;
        docs)
            if [[ $added -gt 0 && $modified -gt 0 ]]; then
                subject="update and add documentation"
            elif [[ $added -gt 0 ]]; then
                subject="add new documentation"
            else
                subject="update documentation"
            fi
            ;;
        test)
            if [[ $added -gt 0 ]]; then
                subject="add test coverage"
            else
                subject="update existing tests"
            fi
            ;;
        chore)
            case "$scope" in
                config) subject="update configuration files" ;;
                scripts) subject="update automation scripts" ;;
                *) subject="update project maintenance" ;;
            esac
            ;;
        style)
            subject="improve code formatting and style"
            ;;
        refactor)
            subject="refactor code structure"
            ;;
        perf)
            subject="improve performance"
            ;;
        ci)
            subject="update CI/CD configuration"
            ;;
        build)
            subject="update build configuration"
            ;;
    esac
    
    # Format final commit message
    local final_message
    if [[ "$scope" != "core" && -n "$scope" ]]; then
        final_message="${commit_type}(${scope}): ${subject}"
    else
        final_message="${commit_type}: ${subject}"
    fi
    
    # Add body with statistics if significant changes
    local total_changes=$((added + modified + deleted))
    if [[ $total_changes -gt 5 ]]; then
        body="\n\n- Modified files: $modified\n- Added files: $added"
        [[ $deleted -gt 0 ]] && body="$body\n- Deleted files: $deleted"
        body="$body\n\nAuto-committed by bc-express automation"
        final_message="${final_message}${body}"
    else
        final_message="${final_message}\n\nAuto-committed by bc-express automation"
    fi
    
    echo -e "$final_message"
}

# Perform the auto-commit
perform_commit() {
    cd "$PROJECT_ROOT"
    
    # Add all changes
    if ! git add .; then
        error_exit "Failed to stage changes"
    fi
    
    # Analyze staged changes
    local analysis
    analysis=$(analyze_changes)
    
    # Generate commit message
    local commit_message
    commit_message=$(generate_commit_message "$analysis")
    
    # Perform commit
    if git commit -m "$commit_message"; then
        log_success "Auto-commit successful: $commit_message"
        return 0
    else
        error_exit "Failed to commit changes"
    fi
}

# Main execution
main() {
    log_info "Starting auto-commit process for bc-express"
    
    # Rotate log if needed
    rotate_log
    
    # Basic checks
    check_git_repo
    
    # Change to project directory
    cd "$PROJECT_ROOT"
    
    # Check for changes
    if has_changes || has_untracked; then
        log_info "Changes detected, proceeding with auto-commit"
        perform_commit
    else
        log_info "No changes detected, skipping commit"
    fi
    
    log_info "Auto-commit process completed"
}

# Show usage information
show_usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Auto-commit script for bc-express bootcamp project.
Automatically commits changes following conventional commits standard.

OPTIONS:
    -h, --help      Show this help message
    -v, --version   Show version information
    -d, --dry-run   Show what would be committed without committing
    --install-cron  Install cron job to run every 5 minutes
    --remove-cron   Remove the cron job

EXAMPLES:
    $0                      # Run auto-commit once
    $0 --dry-run           # Preview what would be committed
    $0 --install-cron      # Setup automatic execution every 5 minutes
    $0 --remove-cron       # Remove automatic execution

CRON SETUP:
    The script can automatically setup a cron job to run every 5 minutes.
    Use --install-cron to enable or --remove-cron to disable.

LOG FILE:
    Logs are written to: $LOG_FILE
    Logs are automatically rotated when they exceed 1MB.

EOF
}

# Install cron job
install_cron() {
    local cron_line="*/5 * * * * $SCRIPT_DIR/$(basename "$0") >> $LOG_FILE 2>&1"
    
    # Check if cron job already exists
    if crontab -l 2>/dev/null | grep -q "$(basename "$0")"; then
        log_warning "Cron job already exists"
        return 0
    fi
    
    # Add to crontab
    (crontab -l 2>/dev/null; echo "$cron_line") | crontab -
    
    if [[ $? -eq 0 ]]; then
        log_success "Cron job installed successfully"
        log_info "Auto-commit will run every 5 minutes"
        log_info "To view logs: tail -f $LOG_FILE"
    else
        error_exit "Failed to install cron job"
    fi
}

# Remove cron job
remove_cron() {
    local temp_cron
    temp_cron=$(mktemp)
    
    # Remove lines containing this script
    crontab -l 2>/dev/null | grep -v "$(basename "$0")" > "$temp_cron"
    
    # Install modified crontab
    crontab "$temp_cron"
    rm "$temp_cron"
    
    log_success "Cron job removed successfully"
}

# Dry run mode
dry_run() {
    cd "$PROJECT_ROOT"
    
    if has_changes || has_untracked; then
        log_info "DRY RUN: Changes detected"
        
        # Show what would be staged
        echo -e "\n${BLUE}Files that would be staged:${NC}"
        git status --porcelain
        
        # Stage changes temporarily for analysis
        git add .
        
        # Analyze and show what commit would be made
        local analysis
        analysis=$(analyze_changes)
        local commit_message
        commit_message=$(generate_commit_message "$analysis")
        
        echo -e "\n${GREEN}Commit message that would be used:${NC}"
        echo -e "$commit_message"
        
        # Unstage changes
        git reset HEAD -- . >/dev/null 2>&1
        
    else
        log_info "DRY RUN: No changes detected"
    fi
}

# Parse command line arguments
case "${1:-}" in
    -h|--help)
        show_usage
        exit 0
        ;;
    -v|--version)
        echo "bc-express auto-commit script v1.0.0"
        exit 0
        ;;
    -d|--dry-run)
        dry_run
        exit 0
        ;;
    --install-cron)
        install_cron
        exit 0
        ;;
    --remove-cron)
        remove_cron
        exit 0
        ;;
    "")
        main
        ;;
    *)
        echo "Unknown option: $1"
        echo "Use --help for usage information"
        exit 1
        ;;
esac
