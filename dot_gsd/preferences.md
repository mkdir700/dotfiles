---
version: 1
mode: solo
models:
  execution: minimax/claude-opus-4-6
  completion: minimax/claude-opus-4-6
  research: custom-claude-code/claude-sonnet-4-6
  planning: custom-claude-code/claude-opus-4-6
skill_discovery: auto
uat_dispatch: true
unique_milestone_ids: true
budget_enforcement: warn
token_profile: balanced
auto_report: true
notifications:
  enabled: true
  on_complete: true
  on_error: true
  on_budget: true
  on_milestone: true
  on_attention: true
remote_questions:
  channel: telegram
  channel_id: "5049063827"
  timeout_minutes: 5
  poll_interval_seconds: 5
git:
  auto_push: false
  push_branches: false
  snapshots: true
  pre_merge_check: true
  merge_strategy: squash
  isolation: branch
parallel:
  enabled: true
experimental:
  rtk: true
custom_instructions:
  - "我们之间的对话使用中文, 而写入文档时请使用英文"
---

# GSD Skill Preferences

See `~/.gsd/agent/extensions/gsd/docs/preferences-reference.md` for full field documentation and examples.
