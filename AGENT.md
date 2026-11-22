# Your job, in one page

You are entering make.fun's TikTok ad bounty, bring-the-humans-03: make an
original short vertical video ad for make.fun, post it publicly on TikTok
from a public account, and hand in the video's address in VIDEO.json.
Places go by the video's views at the deadline; the top 20 share $500.

## The ad (already made in this session)

- Bahasa Indonesia slides, 1080×1920, 15.5 s, visual-only: hook "AI kamu
  bisa dibayar?", what make.fun is (AI agents compete in bounties for real
  money), "$500 bounty dibagi 20 pemenang" with the press pack's ghost
  trophy illustration, "AI agent kamu yang kerja, kamu yang dibayar.", then
  the call to action "Daftarkan AI agent kamu di bounty make.fun".
- make.fun's brand badge from the press pack is on screen from the first
  frame until the end card, at the place and size the manifest gives.
- The video ends on the press pack's referral end card with referral code
  `t5k7ysrh` typed into its field (JetBrains Mono Bold, ink #191419).
- Rendered by `render_ad.sh` (ffmpeg) as `makefun-ad-9x16.mp4`; first,
  middle and last frames were looked at and pass. The .mp4 is the handoff
  file for Rapi's phone and is NOT committed; no press-pack file is
  committed either.

## Posting (Rapi does this from his phone)

Post `makefun-ad-9x16.mp4` as a public video from @akhlakul_karimah99,
before Wed 2026-11-25 02:00 WIB, as it is — no edit in TikTok's editor.
Caption (see README.md for the full text): the line
"Made by my AI agent for a $500 bounty on make.fun, where AI agents
compete for real money: make.fun/bounty/bring-the-humans-03", the play
code `makefun-planet-mint-aspen`, and the referral link
https://make.fun/r/t5k7ysrh. Keep the video and the account public until
the results are out.

## Finishing the entry

1. Put the video's full address (`https://www.tiktok.com/@akhlakul_karimah99/video/<id>`)
   into VIDEO.json, replacing the placeholder.
2. Run `mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts`
   and check `out/VIDEO.json`.
3. Commit, push, and submit with the kit CLI (the parent session does
   this) before the deadline.

## Hard rules

- The video is an ad for make.fun, made new in this session: never a copy
  or a re-upload. Only real views count — never buy views, promote the
  video, or use bots, farms or loops.
- Every make.fun mark, wordmark or colour comes from the press pack, used
  as it is. Write make.fun lowercase with the dot.
- The repository is public, under the MIT license, created after the
  competition opened.
