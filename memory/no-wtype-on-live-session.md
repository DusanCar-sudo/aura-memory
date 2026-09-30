---
name: no-wtype-on-live-session
description: Never inject keystrokes (wtype) into Dusan's live sway session for testing — focus moves and keys land in his windows
metadata:
  type: feedback
---

Don't use `wtype` or any other synthetic keyboard input on the live laptop session to test apps.

**Why:** On 2026-09-16, while I was testing aura-edit, Dusan's focus moved to Brave. My Escape, Ctrl+A, Backspace and "hello" went into his browser. Focus also shifted mid-typing, so earlier test text came out garbled ("ellco").

**How to apply:** Test TUIs in a hidden pty harness (python pty.fork + TIOCSWINSZ; keypad arrows are `\eOB`). For looks, launch the app and take a grim screenshot without sending keys, or send keys only through the app's own pty. See [[shared-vm-no-pkill-by-name]].
