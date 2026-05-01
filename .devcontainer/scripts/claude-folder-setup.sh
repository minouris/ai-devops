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

# If there is no .claude folder (including it it was remoevd by the previous action), create or link it
if [ ! -d "$LOCAL_CLAUDE_DIR" ]; then
    if [ ! -z "$PROJECT_CLAUDE_DIR" ]; then
        echo "Linking $LOCAL_CLAUDE_DIR -> $PROJECT_CLAUDE_DIR"
        ln -s "$PROJECT_CLAUDE_DIR" "$LOCAL_CLAUDE_DIR"
    else
        mkdir -p "$LOCAL_CLAUDE_DIR"
    fi
fi
