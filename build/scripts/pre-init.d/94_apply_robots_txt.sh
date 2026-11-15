#!/usr/bin/env sh
set -eu

# Per RFC 9309 (Robots Exclusion Protocol), multiple blocks for the same
# User-agent are combined into a single effective rule set rather than
# overriding previous entries. User-agent: * rules are not inherited by more
# specific user agents; each matching user agent group stands on its own and
# path matching follows longest-match rules.
# @SEE https://www.rfc-editor.org/rfc/rfc9309.html
#
# Many crawlers do not implement group merging, and only honour the first
# group that matches them. ROBOTS_TXT_APPEND is therefore merged: each group
# in it whose User-agent lines match an existing group in robots.txt has its
# rules inserted at the end of that group. Single-valued directives
# (Crawl-delay, Request-rate, Visit-time) in the appended group replace any
# existing ones in the matched group. Groups with no match, and any lines
# before the first User-agent line, are appended at the end of the file.

ROBOTS_FILE="$APP_WEBROOT/robots.txt"

if [ ! -d "$APP_WEBROOT" ]; then
  echo "[robots.txt] APP_WEBROOT '$APP_WEBROOT' missing; skipping." >&2
  exit 0
fi

if [ -n "${ROBOTS_TXT_REPLACE:-}" ] && [ -n "${ROBOTS_TXT_APPEND:-}" ]; then
  echo "[robots.txt] WARNING: both ROBOTS_TXT_REPLACE and ROBOTS_TXT_APPEND set; REPLACE wins." >&2
fi

if [ -n "${ROBOTS_TXT_REPLACE:-}" ]; then
  printf '%s\n' "$ROBOTS_TXT_REPLACE" > "$ROBOTS_FILE"
  echo "[robots.txt] replaced ($(wc -c < "$ROBOTS_FILE") bytes)."
elif [ -n "${ROBOTS_TXT_APPEND:-}" ]; then
  [ -f "$ROBOTS_FILE" ] || : > "$ROBOTS_FILE"
  TMP_FILE="$(mktemp "$ROBOTS_FILE.XXXXXX")"
  awk '
    # Lowercased directive name, or "" for blank and comment lines.
    function key(s) {
      if (s !~ /^[ \t]*[A-Za-z-]+[ \t]*:/) return ""
      sub(/[ \t]*:.*/, "", s); sub(/^[ \t]*/, "", s)
      return tolower(s)
    }
    # Lowercased directive value, with comments and whitespace stripped.
    function val(s) {
      sub(/^[^:]*:/, "", s); sub(/#.*/, "", s)
      gsub(/^[ \t]+|[ \t]+$/, "", s)
      return tolower(s)
    }
    # Split lines into groups: g[i] is the group of line i (0 = before any
    # group), gkey[n] the joined User-agent values of group n.
    function parse(lines, cnt, g, gkey,    i, k, prev, n) {
      n = 0; prev = ""
      for (i = 1; i <= cnt; i++) {
        k = key(lines[i])
        if (k == "user-agent") {
          if (prev != "user-agent") { n++; gkey[n] = "" }
          gkey[n] = gkey[n] "|" val(lines[i])
        }
        if (k != "") prev = k
        g[i] = n
      }
      return n
    }
    BEGIN { single["crawl-delay"]; single["request-rate"]; single["visit-time"] }
    { sub(/\r$/, ""); f[++fn] = $0 }
    END {
      an = split(ENVIRON["ROBOTS_TXT_APPEND"], a, "\n")
      for (i = 1; i <= an; i++) sub(/\r$/, "", a[i])
      fgn = parse(f, fn, fg, fkey)
      agn = parse(a, an, ag, akey)

      # Last directive line of each file group is the insertion point. Record
      # existing lines so a re-run (container restart) adds no duplicates.
      for (i = 1; i <= fn; i++) {
        if (fg[i] && key(f[i]) != "") flast[fg[i]] = i
        have[fg[i], f[i]] = 1; anywhere[f[i]] = 1
      }

      # Map each appended group to the first file group with the same agents.
      for (j = 1; j <= agn; j++)
        for (n = 1; n <= fgn; n++)
          if (akey[j] == fkey[n]) { target[j] = n; break }

      merged = 0
      for (i = 1; i <= an; i++) {
        k = key(a[i]); j = ag[i]
        if (j && (j in target)) {
          if (k == "" || k == "user-agent") continue
          n = target[j]
          if ((n, a[i]) in have) continue
          if (k in single) drop[n, k] = 1
          ins[flast[n]] = ins[flast[n]] a[i] "\n"
          merged++
        } else {
          if (!j && k != "" && (a[i] in anywhere)) continue
          # Keep unmatched groups visually separated at the end of the file.
          if (j != tailg && tail != "" && tail !~ /\n\n$/) tail = tail "\n"
          tail = tail a[i] "\n"; tailg = j
        }
      }

      for (i = 1; i <= fn; i++) {
        if (!((fg[i], key(f[i])) in drop)) print f[i]
        if (i in ins) printf "%s", ins[i]
      }
      if (tail ~ /[^ \t\n]/) {
        if (fn && f[fn] != "") print ""
        printf "%s", tail
      }
      printf "[robots.txt] merged %d line(s) into existing groups.\n", merged > "/dev/stderr"
    }
  ' "$ROBOTS_FILE" > "$TMP_FILE"
  mv "$TMP_FILE" "$ROBOTS_FILE"
  echo "[robots.txt] appended ($(wc -c < "$ROBOTS_FILE") bytes)."
else
  exit 0
fi

chown "$NGINX_RUN_USER":"$NGINX_RUN_GROUP" "$ROBOTS_FILE"
chmod 644 "$ROBOTS_FILE"
