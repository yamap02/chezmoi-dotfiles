#!/usr/bin/env zsh

set -euo pipefail

ROOT_DIR="/Users/user/.config/zsh"
source "$ROOT_DIR/function.zsh"
source "$ROOT_DIR/alias.zsh"

tmpdir="$(mktemp -d)"
trap 'rm -rf "$tmpdir"' EXIT

fakebin="$tmpdir/bin"
mkdir -p "$fakebin"
export PATH="$fakebin:$PATH"

cat > "$fakebin/yazi" <<'EOF'
#!/usr/bin/env zsh
set -euo pipefail

cwd_file=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --cwd-file)
      cwd_file="$2"
      shift 2
      ;;
    *)
      shift
      ;;
  esac
done

if [[ -n "$cwd_file" && -n "${TEST_YAZI_TARGET_DIR:-}" ]]; then
  printf '%s' "$TEST_YAZI_TARGET_DIR" > "$cwd_file"
fi
EOF
chmod +x "$fakebin/yazi"

function assert_eq() {
  local expected="$1"
  local actual="$2"
  local message="$3"

  if [[ "$expected" != "$actual" ]]; then
    print -u2 -- "FAIL: $message"
    print -u2 -- "  expected: $expected"
    print -u2 -- "  actual:   $actual"
    exit 1
  fi
}

original_pwd="$PWD"
target_dir="$tmpdir/target"
mkdir -p "$target_dir"
export TEST_YAZI_TARGET_DIR="$target_dir"

yazi "$original_pwd"
assert_eq "$target_dir" "$PWD" "yazi wrapper should cd to the directory written to --cwd-file"

cd "$original_pwd"
export TEST_YAZI_TARGET_DIR="$target_dir"
r "$original_pwd"
assert_eq "$target_dir" "$PWD" "r alias should also cd via yazi wrapper"

unalias r
assert_eq "yazi: function" "$(whence -w yazi)" "yazi should resolve to a shell function"
