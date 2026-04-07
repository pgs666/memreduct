<h1 align="center">Mem Reduct</h1>

<p align="center">
	<a href="https://github.com/henrypp/memreduct/releases"><img src="https://img.shields.io/github/v/release/henrypp/memreduct?style=flat-square&include_prereleases&label=version" /></a>
	<a href="https://github.com/henrypp/memreduct/releases"><img src="https://img.shields.io/github/downloads/henrypp/memreduct/total.svg?style=flat-square" /></a>
	<a href="https://github.com/henrypp/memreduct/issues"><img src="https://img.shields.io/github/issues-raw/henrypp/memreduct.svg?style=flat-square&label=issues" /></a>
	<a href="https://github.com/henrypp/memreduct/graphs/contributors"><img src="https://img.shields.io/github/contributors/henrypp/memreduct?style=flat-square" /></a>
	<a href="https://github.com/henrypp/memreduct/blob/master/LICENSE"><img src="https://img.shields.io/github/license/henrypp/memreduct?style=flat-square" /></a>
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
gh workflow run build.yml
gh run list --workflow build.yml --limit 5
gh run download RUN_ID -n memreduct-arm64 -D out
```

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
- Website: [github.com/henrypp](https://github.com/henrypp)
- Support: sforce5@mail.ru
---
(c) 2011-2026 Henry++
