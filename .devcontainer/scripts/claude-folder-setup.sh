#!/bin/sh

LOCAL_CLAUDE_DIR=.claude
LOCAL_USER_CLAUDE_DIR=.claude-data


if [ ! -z $WORKSPACE_FOLDER ]; then
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
if [ 3 == 4 ]; then
    if [ -d "~/.claude" ]; then
        if [ ! -L "~/.claude" ]; then
            if [ -d "$LOCAL_USER_CLAUDE_DIR" ]; then
                cp -rf "~/.claude" "$LOCAL_USER_CLAUDE_DIR"
                rm -rf "~/.claude"
            else
                mv -f "~/.claude" "$LOCAL_USER_CLAUDE_DIR"
            fi
        fi
    fi

    mkdir -p "$LOCAL_USER_CLAUDE_DIR"
    if [ -L "~/.claude" ] && [ "$LOCAL_USER_CLAUDE_DIR" != $(readlink -f "~/.claude") ]; then
        echo "Removing link to $(readlink -f ~/.claude) from ~/.claude"
    fi
    echo "Linking $LOCAL_USER_CLAUDE_DIR -> ~/.claude"
    ln -s "$LOCAL_USER_CLAUDE_DIR" "~/.claude"
fi