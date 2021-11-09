# Parses a flake lock update commit and output readable markdown with proper
# compare links

function unquote (str) {
  split(str, arr, "'");
  return arr[2];
}

function parse_flakeref (flakeref, res) {
  split(flakeref, arr, ":");
  type = arr[1];
  tmp = arr[2];
  split(tmp, arr, "?");
  tmp = arr[1];
  n = split(tmp, arr, "/");
  commit = arr[n];
  repo = arr[1]
  for (i = 2; i < n; i++) {
    repo = repo "/" arr[i];
  }

  res["type"] = type;
  res["commit"] = commit;
  res["repo"] = repo;
}

function short (sha) {
  return substr(sha, 1, 8);
}

BEGIN {
  print "<details><summary>Raw output</summary><p>";
  print "";
  print "```";
}

# Print all lines anyway
{ print }

$3 ~ /input/ {
  input = unquote($4);
  operations[input] = $2;
  next;
}

$2 ~ /\(.*\)/ {
  input_from[input] = unquote($1)
  input_from_date[input] = substr($2, 2, 10);
  next;
}

$3 ~ /\(.*\)/ {
  input_to[input] = unquote($2)
  input_to_date[input] = substr($3, 2, 10);
  next;
}

END {
  print "```";
  print "";
  print "</p></details>";
  print "";
  for (input in operations) {
    operation = operations[input];
    details = "";
    link = "";

    if (operation == "Updated") {
      from = input_from[input];
      to = input_to[input];
      from_date = input_from_date[input]
      to_date = input_to_date[input]
      parse_flakeref(from, parsed_from);
      parse_flakeref(to, parsed_to);
      type = parsed_from["type"];
      repo = parsed_from["repo"];
      from_commit = parsed_from["commit"];
      to_commit = parsed_to["commit"];

      compare = sprintf("`%s` ➡️ `%s`", short(from_commit), short(to_commit));
      if (type == "github") {
        compare = sprintf("[%s](https://github.com/%s/compare/%s...%s)", compare, repo, from_commit, to_commit);
        link = sprintf("https://github.com/%s", repo);
      } else if (type == "gitlab") {
        compare = sprintf("[%s](https://gitlab.com/%s/-/compare/%s...%s)", compare, repo, from_commit, to_commit);
        link = sprintf("https://gitlab.com/%s", repo);
      }

      details = sprintf("%s <sub>(%s to %s)</sub>", compare, from_date, to_date);
    } else if (operation == "Added") {
      ref = input_from[input];
      parse_flakeref(ref, parsed_ref);
      type = parsed_ref["type"];
      repo = parsed_ref["repo"];
      commit = parsed_ref["commit"];

      if (type == "github") {
        details = sprintf("[github.com/%s](https://github.com/%s/tree/%s/)", repo, repo, commit);
        link = sprintf("https://github.com/%s", repo);
      } else if (type == "gitlab") {
        details = sprintf("[gitlab.com/%s](https://gitlab.com/%s/-/tree/%s/)", repo, repo, commit);
        link = sprintf("https://gitlab.com/%s", repo);
      } else {
        details = sprintf("`%s`", ref);
      }
    }

    if (link) {
      input_txt = sprintf("[`%s`](%s)", input, link);
    } else {
      input_txt = sprintf("`%s`", input);
    }

    if (details) {
      printf(" - %s input %s: %s\n", operation, input_txt, details);
    } else {
      printf(" - %s input %s.\n", operation, input_txt);
    }
  }
}
