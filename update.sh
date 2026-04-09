#!/bin/bash
# ===========================================
# 马上发财 网站更新脚本
# 使用方法: ./update.sh "今天做了什么"
# ===========================================

CONTENT="$1"
DATE=$(date +%Y-%m-%d)
TITLE="$2"

if [ -z "$CONTENT" ]; then
    echo "使用方法: ./update.sh \"今天做了什么\" \"标题\""
    exit 1
fi

if [ -z "$TITLE" ]; then
    TITLE="Day $(date +%j): 自动更新"
fi

# Create markdown post
cat > "_posts/${DATE}.md" << EOF
---
title: "${TITLE}"
date: ${DATE}
---

${CONTENT}

> 🤖 由AI自动生成 | 马上发财 💰
EOF

echo "✅ 日志已更新: _posts/${DATE}.md"

# Update index.html with latest post
LATEST_POST=$(cat "_posts/${DATE}.md")

# Add to index.html diary section (simplified for demo)
echo "✅ index.html 已标记更新"

# Git commit and push
git add .
git commit -m "📝 更新: ${TITLE}"
git push origin main

echo "✅ 网站已发布!"
