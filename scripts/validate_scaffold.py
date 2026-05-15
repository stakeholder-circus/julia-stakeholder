from pathlib import Path
import shutil
import subprocess
import sys

required = [
    'README.md', 'AI_DISCLOSURE.md', 'PARITY.md', 'GAPS.md', 'AGENTS.md', 'Project.toml',
    'src/Stakeholder.jl', 'test/runtests.jl', 'docs/remotes.md', 'docs/provenance.md',
    'docs/toolchain.md', 'docs/traceability/first-push-families.md', '.githooks/commit-msg',
    '.githooks/pre-push', '.github/CODEOWNERS', '.github/PULL_REQUEST_TEMPLATE.md',
    '.github/dependabot.yml', '.github/workflows/actionlint.yml',
    '.github/workflows/dependency-review.yml', '.github/workflows/ci.yml',
    '.github/workflows/ci-native.yml', '.github/workflows/docker-smoke.yml', 'flake.nix',
    'Dockerfile', 'flake.lock',
]
forbidden = ['Cargo.toml', 'Cargo.lock', 'rust-toolchain.toml']
missing = [p for p in required if not Path(p).exists()]
leftovers = [p for p in forbidden if Path(p).exists()]
leftovers += [str(p) for p in Path('src').glob('*.rs')]
if missing:
    raise SystemExit('missing Julia tranche files: ' + ', '.join(missing))
if leftovers:
    raise SystemExit('Rust scaffold leftovers remain: ' + ', '.join(leftovers))
if shutil.which('julia'):
    subprocess.run(['julia', '--project=.', '-e', 'using Pkg; Pkg.test()'], check=True)
else:
    print('Julia executable not found; structural validation only', file=sys.stderr)
print('Julia deterministic tranche validated')
