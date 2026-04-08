<h1 align="center">Mem Reduct</h1>

<p align="center">
	<a href="https://github.com/pgs666/memreduct/releases"><img src="https://img.shields.io/github/v/release/pgs666/memreduct?style=flat-square&include_prereleases&label=version" /></a>
	<a href="https://github.com/pgs666/memreduct/releases"><img src="https://img.shields.io/github/downloads/pgs666/memreduct/total.svg?style=flat-square" /></a>
	<a href="https://github.com/pgs666/memreduct/issues"><img src="https://img.shields.io/github/issues-raw/pgs666/memreduct.svg?style=flat-square&label=issues" /></a>
	<a href="https://github.com/pgs666/memreduct/graphs/contributors"><img src="https://img.shields.io/github/contributors/pgs666/memreduct?style=flat-square" /></a>
	<a href="https://github.com/pgs666/memreduct/blob/master/LICENSE"><img src="https://img.shields.io/github/license/pgs666/memreduct?style=flat-square" /></a>
</p>

-------

<p align="center">
	<img src="/images/memreduct.png?cachefix" />
</p>

### Description:
Lightweight real-time memory management application to monitor
and clean system memory on your computer.

The program used undocumented internal system features (Native API) to clear
system cache (system working set, working set, standby page lists, modified page
lists) with variable result ~10-50%. Application it is compatible with Windows XP SP3 and
higher operating systems, but some general features available only since Windows Vista.

You can download either the installer or portable version. For correct working you are require administrator rights.

```
To activate portable mode, create "memreduct.ini" in application folder, or move it from "%APPDATA%\Henry++\Mem Reduct".
```

### System requirements:
- Windows 7, 8, 8.1, 10, 11 x64
- Windows 10, 11 ARM64
- An SSE2-capable CPU (x86/x64 builds only)
- <s>KB2533623</s> [KB3063858](https://www.microsoft.com/en-us/download/details.aspx?id=47442) update for Windows 7 x64 was required

### ARM64 build notes:
- `memreduct.sln` and `memreduct.vcxproj` already contain `Debug|ARM64` and `Release|ARM64` configurations.
- No ARM64-specific source changes are required in `src/` for the portable build.
- The ARM64 target uses `MinimumRequiredVersion=10.0`, so ARM64 binaries are intended for Windows 10/11.
- This repository depends on the sibling `../routine` sources, so CI must fetch that dependency before running `msbuild`.

### GitHub Actions build:
The workflow file [`.github/workflows/build.yml`](.github/workflows/build.yml) builds portable `x64` and `ARM64` artifacts on GitHub-hosted Windows runners, so you do not need to install a local MSVC toolchain.

With GitHub CLI:

```powershell
gh workflow run build.yml -R pgs666/memreduct
gh run list -R pgs666/memreduct --workflow build.yml --limit 5
gh run download -R pgs666/memreduct RUN_ID -n memreduct-arm64 -D out
```

### GitHub Actions release:
The workflow file [`.github/workflows/release.yml`](.github/workflows/release.yml) downloads a successful build run's `x64`/`ARM64` artifacts, creates a `setup.exe`, produces portable zip packages, generates a SHA256 file, and then creates or updates GitHub Release `v.<version>`.

With GitHub CLI:

```powershell
gh workflow run release.yml -R pgs666/memreduct -f version=3.5.3 -f build_run_id=24110754399
gh run list -R pgs666/memreduct --workflow release.yml --limit 5
gh release view v.3.5.3 -R pgs666/memreduct
```

If `build_run_id` is left empty in the workflow dispatch form, the workflow will automatically use the latest successful `build.yml` run.

### Changes in this repository:
- added GitHub Actions cloud build for `x64` and `ARM64`
- added a separate release workflow that packages `setup.exe` from build artifacts and publishes a GitHub Release
- pinned `routine` dependency to `v.2.7.11` for stable CI builds
- adapted `src/main.c` to the current `routine` public API (`*_ex` config functions, tray API, rectangle helper signature)
- replaced the old mount manager-specific volume cache flush path with a Win32 volume enumeration implementation that compiles in CI
- fixed warning-as-error issues reported by the GitHub-hosted MSVC toolchain
- clarified ARM64/x64/SSE2 support and updated release metadata to `3.5.3`

### Donate:
- [Bitcoin](https://www.blockchain.com/btc/address/1LrRTXPsvHcQWCNZotA9RcwjsGcRghG96c) (BTC)
- [Ethereum](https://www.blockchain.com/explorer/addresses/eth/0xe2C84A62eb2a4EF154b19bec0c1c106734B95960) (ETH)
- [Yandex Money](https://yoomoney.ru/to/4100115776040583) (RUB)
- [Paypal](https://paypal.me/henrypp) (USD)

### GPG Signature:
Binaries have GPG signature `memreduct.exe.sig` in application folder.

- Public key: [pubkey.asc](https://raw.githubusercontent.com/henrypp/builder/master/pubkey.asc) ([pgpkeys.eu](https://pgpkeys.eu/pks/lookup?op=index&fingerprint=on&search=0x5635B5FD))
- Key ID: 0x5635B5FD
- Fingerprint: D985 2361 1524 AB29 BE73 30AC 2881 20A7 5635 B5FD
---
- Website: [github.com/pgs666/memreduct](https://github.com/pgs666/memreduct)
- Support: sforce5@mail.ru
---
(c) 2011-2026 Henry++
