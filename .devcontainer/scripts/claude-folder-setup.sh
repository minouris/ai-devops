#!/bin/sh

LOCAL_CLAUDE_DIR=.claude
LOCAL_USER_CLAUDE_DIR=.claude-data


if [ -n "${WORKSPACE_FOLDER:-}" ]; then
    . "$WORKSPACE_FOLDER/.devcontainer/claude.env"
    if [ ! -z "$PROJECT_CLAUDE_DIR" ]; then
        PROJECT_CLAUDE_DIR="$WORKSPACE_FOLDER/$PROJECT_CLAUDE_DIR"
    fi
    LOCAL_CLAUDE_DIR="$WORKSPACE_FOLDER/$LOCAL_CLAUDE_DIR"
    LOCAL_USER_CLAUDE_DIR="$WORKSPACE_FOLDER/$LOCAL_USER_CLAUDE_DIR"
else
    . ".devcontainer/claude.env"
fi

# If there's an incorrect, linked .claude folder, remove it
if [ -d "$LOCAL_CLAUDE_DIR" ]; then
    if [ -L "$LOCAL_CLAUDE_DIR" ]; then
        if [ ! -z "$PROJECT_CLAUDE_DIR" ]; then
            if [ "$PROJECT_CLAUDE_DIR" != "$(readlink -f $LOCAL_CLAUDE_DIR)" ]; then
                echo "Removing link to $(readlink -f $LOCAL_CLAUDE_DIR) from $PROJECT_CLAUDE_DIR"
                rm "$LOCAL_CLAUDE_DIR"
            fi
        fi
    fi
fi

# If there is no .claude folder (including it it was removed by the previous action), create or link it
if [ ! -d "$LOCAL_CLAUDE_DIR" ]; then
    if [ ! -z "$PROJECT_CLAUDE_DIR" ]; then
        echo "Linking $LOCAL_CLAUDE_DIR -> $PROJECT_CLAUDE_DIR"
        ln -s "$PROJECT_CLAUDE_DIR" "$LOCAL_CLAUDE_DIR"
    else
        mkdir -p "$LOCAL_CLAUDE_DIR"
    fi
fi

# Determine if there is an existing, non-symlink ~/.claude folder.
# If there is, either merge it into the existing local one,
# Or move it to the local location

if [ -d "$HOME/.claude" ]; then
    if [ ! -L "$HOME/.claude" ]; then
        if [ -d "$LOCAL_USER_CLAUDE_DIR" ]; then
            cp -a "$HOME/.claude/." "$LOCAL_USER_CLAUDE_DIR"
            rm -rf "$HOME/.claude"
        else
            mv -f "$HOME/.claude" "$LOCAL_USER_CLAUDE_DIR"
        fi
    fi
fi

mkdir -p "$LOCAL_USER_CLAUDE_DIR"
if [ -L "$HOME/.claude" ] && [ "$LOCAL_USER_CLAUDE_DIR" != $(readlink -f "$HOME/.claude") ]; then
    echo "Removing link to $(readlink -f $HOME/.claude) from $HOME/.claude"
    rm "$HOME/.claude"
fi
if [ ! -e "$HOME/.claude" ] && [ ! -L "$HOME/.claude" ]; then
    echo "Linking $LOCAL_USER_CLAUDE_DIR -> $HOME/.claude"
    ln -s "$LOCAL_USER_CLAUDE_DIR" "$HOME/.claude"
fi
