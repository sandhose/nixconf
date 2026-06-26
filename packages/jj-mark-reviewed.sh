#!/usr/bin/env bash
#
# Mark GitHub-reviewed commits as immutable in jj.
#
# For each PR, finds the most recently *submitted* review (any state but
# PENDING) and points a local `reviewed/pr-<n>` bookmark at the commit that
# review was made against. Combined with the revset alias
#
#     immutable_heads() = builtin_immutable_heads() | bookmarks(glob:'reviewed/*')
#
# this makes the reviewed commit (and its ancestors) immutable in jj.
#
# The bookmark is local and untracked, so a plain `jj git push` never pushes
# it (jj refuses to create new remote bookmarks by default).
#
# Usage:
#   jj-mark-reviewed              # all open PRs authored by you
#   jj-mark-reviewed 123 456      # specific PR numbers
#
set -euo pipefail

usage() {
	cat >&2 <<'EOF'
usage: jj-mark-reviewed [PR_NUMBER...]

With no arguments, processes every open PR authored by you.
Otherwise, processes only the given PR numbers.

Must be run from inside the repository (uses gh's default repo and jj's
working copy). Does not rely on a git branch, so it works fine in jj repos.
EOF
}

prs=()
sweep_mine=true
for arg in "$@"; do
	case "$arg" in
	-h | --help)
		usage
		exit 0
		;;
	-* )
		echo "jj-mark-reviewed: unknown option: $arg" >&2
		usage
		exit 2
		;;
	*)
		prs+=("$arg")
		sweep_mine=false
		;;
	esac
done

if [ "$sweep_mine" = true ]; then
	mapfile -t prs < <(gh pr list --author "@me" --state open --json number --jq '.[].number')
fi

if [ "${#prs[@]}" -eq 0 ]; then
	echo "jj-mark-reviewed: no PRs to process" >&2
	exit 0
fi

fetched=false
# Make sure a commit is present in the local jj repo, fetching once if not.
ensure_local() {
	local commit="$1"
	if jj log --no-graph -r "$commit" -T '""' >/dev/null 2>&1; then
		return 0
	fi
	if [ "$fetched" = false ]; then
		echo "jj-mark-reviewed: fetching missing commits…" >&2
		jj git fetch >/dev/null 2>&1 || true
		fetched=true
	fi
	jj log --no-graph -r "$commit" -T '""' >/dev/null 2>&1
}

status=0
for pr in "${prs[@]}"; do
	# Latest submitted review's target commit (PENDING reviews have no commit_id
	# and aren't visible to others anyway).
	commit=$(gh api "repos/{owner}/{repo}/pulls/$pr/reviews" --paginate |
		jq -rs 'add
			| map(select(.state != "PENDING" and .commit_id != null))
			| sort_by(.submitted_at)
			| last
			| .commit_id // empty')

	if [ -z "$commit" ]; then
		echo "pr #$pr: no submitted reviews — skipped"
		continue
	fi

	if ! ensure_local "$commit"; then
		echo "pr #$pr: reviewed commit $commit not found locally (even after fetch) — skipped" >&2
		status=1
		continue
	fi

	if ! jj bookmark set "reviewed/pr-$pr" -r "$commit"; then
		echo "pr #$pr: could not move reviewed/pr-$pr (backward move? set it manually with --allow-backwards)" >&2
		status=1
		continue
	fi
	echo "pr #$pr: reviewed/pr-$pr -> ${commit:0:12}"
done

exit "$status"
