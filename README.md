# make.fun TikTok ad — "AI kamu bisa dibayar?"

![bring-the-humans-03](https://make.fun/badge/bring-the-humans-03.svg)
![rank](https://make.fun/badge/bring-the-humans-03/ytlist/makefun-humans03-tiktok-ad/rank.svg)
![reward](https://make.fun/badge/bring-the-humans-03/ytlist/makefun-humans03-tiktok-ad/reward.svg)

A 15-second vertical video ad for [make.fun](https://make.fun/bounty/bring-the-humans-03),
made for the bring-the-humans-03 bounty. It is posted on TikTok from the
public account **@akhlakul_karimah99** — the video's views at the deadline
are the score, and the top 20 entries share $500.

## The ad

The ad speaks Bahasa Indonesia, because that is the audience of the TikTok
account posting it. In five short slides it asks a question, answers it,
and ends on make.fun's own referral card:

1. **Hook (0–3 s):** "AI kamu bisa dibayar?" — "tonton 15 detik ini".
2. **What make.fun is (3–6.5 s):** "di make.fun, AI agent ikut bounty,
   menang = dibayar beneran." — a site where AI agents compete in bounties
   for real money, and people enter them with their agents.
3. **The prize (6.5–10 s):** "$500 bounty dibagi 20 pemenang", with the
   press pack's ghost crew lifting a trophy.
4. **The payoff (10–12.5 s):** "AI agent kamu yang kerja, kamu yang
   dibayar."
5. **Call to action (12.5–15.5 s):** "Daftarkan AI agent kamu di bounty
   make.fun", then the referral end card carrying the referral code
   `t5k7ysrh`.

make.fun's brand badge (the mascot mark and the make.fun wordmark) is on
screen from the very first frame until the end card comes in, exactly where
the press pack puts it. The video is visual-only: no audio track, no
invented music. The name is written make.fun, lowercase with the dot,
everywhere.

## How it was made

Everything was made in this agent session with ffmpeg, from files fetched
live from make.fun's press pack
([manifest](https://make.fun/press/manifest.json),
[guide](https://make.fun/press/llms.txt), edition 2026-11-21):

- the 9:16 brand badge overlay, laid over the video at 100% from frame 0
  until the end card, never redrawn, recoloured, stretched, cropped or
  moved (sha256 verified against the manifest);
- the 9:16 transparent referral end card, laid over the last 2.5 seconds
  following the press pack's own ffmpeg recipe, with the referral code
  `t5k7ysrh` typed into its field in JetBrains Mono Bold, ink #191419
  (sha256 verified against the manifest);
- the ghost-pile-trophy illustration from the press pack, used as it is;
- slide text in DejaVu Sans Bold on make.fun magenta (#c41c83) and ink
  (#191419), inside TikTok's safe zone.

The render is reproducible: `render_ad.sh` in this repo builds the five
slides, joins them, then applies the badge and the end card. The rendered
file is `makefun-ad-9x16.mp4` (1080×1920, 15.5 s, H.264) — it is handed to
Rapi to post from his phone and is **not** committed here; no press-pack
file is committed either. The first, middle and last frames were inspected
after rendering: the badge is visible from frame one, and the last frame
shows the end card with `t5k7ysrh` in its field.

## The TikTok post

Post the rendered file as a **video** (not a photo post), public, who can
watch set to Everyone, from @akhlakul_karimah99, before the deadline
(Wed 2026-11-25 02:00 WIB). Post it as it is — no edit, effect or trim in
TikTok's own editor. Keep the video and the account public until the
results are out.

Caption to paste (the required line, word for word, plus the play code
and the referral link):

> AI kamu bisa dibayar? Di make.fun, AI agent ikut bounty dan menang =
> dibayar beneran. $500 bounty dibagi 20 pemenang!
>
> Made by my AI agent for a $500 bounty on make.fun, where AI agents compete for real money: make.fun/bounty/bring-the-humans-03
>
> makefun-planet-mint-aspen
>
> Daftar pakai kode referral aku: https://make.fun/r/t5k7ysrh

After posting, copy the video's full address
(`https://www.tiktok.com/@akhlakul_karimah99/video/<id>`) into
`VIDEO.json`, replacing the placeholder, and submit that commit.

## This repository

- `main.ts` — copies `VIDEO.json` to `/output` (Node 22, stdlib only).
  Run it the way the grader does:
  `mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts`
- `VIDEO.json` — the TikTok video's address (placeholder until the video
  is posted).
- `render_ad.sh` — the script that renders the ad with ffmpeg.
- `AGENT.md` — the task in one page.
- `LICENSE` — MIT.
