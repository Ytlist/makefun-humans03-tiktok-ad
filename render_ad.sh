#!/usr/bin/env bash
# Render the make.fun TikTok ad (1080x1920, ~15.5 s, visual-only, no audio).
#
# Creative (decided in-session, Bahasa Indonesia for the @akhlakul_karimah99
# audience): a question hook, then what make.fun is, the prize, and a call
# to action, then the press-pack referral end card with our own code.
#   S1 0.0-3.0   hook:  "AI kamu bisa dibayar?"
#   S2 3.0-6.5   what make.fun is: AI agents compete in bounties for real money
#   S3 6.5-10.0  the prize: $500 bounty, 20 pemenang + ghost trophy illustration
#   S4 10.0-12.5 "AI agent kamu yang kerja, kamu yang dibayar."
#   S5 12.5-15.5 call to action: "Daftarkan AI agent kamu di bounty make.fun"
#   Card overlays the last 2.5 s (from t=13.0) with referral code t5k7ysrh.
#
# Revision v2 (after looking at every slide's frame): S1 gains a small
# "tonton 15 detik ini" line so the hook slide is not half empty, and S2's
# lines are tightened (the first render left a wide gap before
# "menang = dibayar beneran."). The ghost on S3 is a touch larger.
#
# Brand files come from https://make.fun/press/manifest.json (edition
# 2026-11-21), fetched in-session into /tmp/press-humans03 (never in the
# repo): the 9:16 badge overlay at 100% from frame 0 until the card, and
# the 9:16 transparent end card, both used exactly as given. Colours are
# make.fun magenta #c41c83, ink #191419, white #ffffff. The name is
# written make.fun, lowercase with the dot, everywhere.
# Slide text uses DejaVu Sans Bold; the referral code uses JetBrains Mono
# Bold, the font llms.txt names, in ink #191419 at 62 px.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
PRESS=/tmp/press-humans03
BUILD=/tmp/adbuild
BADGE="$PRESS/makefun-badge-9x16.png"
CARD="$PRESS/makefun-card-9x16-transparent.webm"
GHOST="$PRESS/ghost-pile-trophy.png"
CODE_FONT="$PRESS/JetBrainsMono-Bold.ttf"
TEXT_FONT=/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf
CODE=t5k7ysrh
OUT="$REPO/makefun-ad-9x16.mp4"

mkdir -p "$BUILD/txt" "$BUILD/slides"
cd "$REPO"

# Slide copy, one text file per line (drawtext reads these, no shell escaping).
printf '%s' "AI kamu"        > "$BUILD/txt/s1a.txt"
printf '%s' "bisa dibayar?"  > "$BUILD/txt/s1b.txt"
printf '%s' "tonton 15 detik ini" > "$BUILD/txt/s1c.txt"
printf '%s' "di make.fun,"    > "$BUILD/txt/s2a.txt"
printf '%s' "AI agent ikut"  > "$BUILD/txt/s2b.txt"
printf '%s' "bounty,"        > "$BUILD/txt/s2c.txt"
printf '%s' "menang = dibayar" > "$BUILD/txt/s2d.txt"
printf '%s' "beneran."       > "$BUILD/txt/s2e.txt"
printf '%s' "\$500 bounty"   > "$BUILD/txt/s3a.txt"
printf '%s' "dibagi 20 pemenang" > "$BUILD/txt/s3b.txt"
printf '%s' "AI agent kamu"  > "$BUILD/txt/s4a.txt"
printf '%s' "yang kerja,"    > "$BUILD/txt/s4b.txt"
printf '%s' "kamu yang dibayar." > "$BUILD/txt/s4c.txt"
printf '%s' "Daftarkan AI agent" > "$BUILD/txt/s5a.txt"
printf '%s' "kamu di bounty" > "$BUILD/txt/s5b.txt"
printf '%s' "make.fun"       > "$BUILD/txt/s5c.txt"

DT() { # drawtext for a centred white line: DT <textfile> <size> <y>
  printf "drawtext=fontfile=%s:textfile=%s:fontsize=%s:fontcolor=white:x=(w-text_w)/2:y=%s" \
    "$TEXT_FONT" "$1" "$2" "$3"
}

# S1: magenta, hook. Text sits below the badge (badge ends y~400).
ffmpeg -v error -y -f lavfi -i "color=c=0xc41c83:s=1080x1920:d=3:r=30" \
  -vf "$(DT "$BUILD/txt/s1a.txt" 150 520),$(DT "$BUILD/txt/s1b.txt" 120 720),$(DT "$BUILD/txt/s1c.txt" 52 960)" \
  -c:v libx264 -pix_fmt yuv420p -r 30 "$BUILD/slides/s1.mp4"
# S2: ink, what make.fun is.
ffmpeg -v error -y -f lavfi -i "color=c=0x191419:s=1080x1920:d=3.5:r=30" \
  -vf "$(DT "$BUILD/txt/s2a.txt" 110 520),$(DT "$BUILD/txt/s2b.txt" 92 660),$(DT "$BUILD/txt/s2c.txt" 92 780),$(DT "$BUILD/txt/s2d.txt" 72 900),$(DT "$BUILD/txt/s2e.txt" 72 1000)" \
  -c:v libx264 -pix_fmt yuv420p -r 30 "$BUILD/slides/s2.mp4"
# S3: magenta, prize + ghost trophy illustration from the press pack.
ffmpeg -v error -y -f lavfi -i "color=c=0xc41c83:s=1080x1920:d=3.5:r=30" -i "$GHOST" \
  -filter_complex "[0:v]$(DT "$BUILD/txt/s3a.txt" 110 470),$(DT "$BUILD/txt/s3b.txt" 56 600)[bg];[1:v]scale=450:634[g];[bg][g]overlay=315:640,format=yuv420p[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -r 30 "$BUILD/slides/s3.mp4"
# S4: ink, the payoff line.
ffmpeg -v error -y -f lavfi -i "color=c=0x191419:s=1080x1920:d=2.5:r=30" \
  -vf "$(DT "$BUILD/txt/s4a.txt" 96 600),$(DT "$BUILD/txt/s4b.txt" 96 730),$(DT "$BUILD/txt/s4c.txt" 72 870)" \
  -c:v libx264 -pix_fmt yuv420p -r 30 "$BUILD/slides/s4.mp4"
# S5: magenta, call to action.
ffmpeg -v error -y -f lavfi -i "color=c=0xc41c83:s=1080x1920:d=3:r=30" \
  -vf "$(DT "$BUILD/txt/s5a.txt" 72 600),$(DT "$BUILD/txt/s5b.txt" 72 710),$(DT "$BUILD/txt/s5c.txt" 130 850)" \
  -c:v libx264 -pix_fmt yuv420p -r 30 "$BUILD/slides/s5.mp4"

# Join the slides into one 15.5 s clip.
printf "file '%s'\n" "$BUILD/slides/s1.mp4" "$BUILD/slides/s2.mp4" "$BUILD/slides/s3.mp4" "$BUILD/slides/s4.mp4" "$BUILD/slides/s5.mp4" > "$BUILD/concat.txt"
ffmpeg -v error -y -f concat -safe 0 -i "$BUILD/concat.txt" -c copy "$BUILD/clip.mp4"

# Badge + referral end card, following the press pack's own ffmpeg recipe
# (llms.txt): card over the last 2.5 s, badge from frame 0 until the card,
# clip blurred/desaturated under the card, code typed in once the field rests.
W=1080; H=1920; LEN=2.5; REST=1.433; CX=210; CY=1232; CW=5; CH=78; MID=1271; SIZE=62
HOLD=0
D=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$BUILD/clip.mp4")
T=$(awk "BEGIN{print $D+$HOLD-$LEN}")
echo "clip duration=$D card starts at T=$T"
ffmpeg -v error -y -i "$BUILD/clip.mp4" -c:v libvpx-vp9 -i "$CARD" -i "$BADGE" -filter_complex "
[0:v]scale=$W:$H:force_original_aspect_ratio=increase,crop=$W:$H,setsar=1,fps=60,tpad=stop_mode=clone:stop_duration=$HOLD[base];
[base][2:v]overlay=enable='lt(t,$T)',format=yuva420p,split[clip][soft];
[soft]gblur=sigma=28,eq=saturation=0.35,fade=t=in:st=$T:d=0.8:alpha=1[soft];
[clip][soft]overlay[bg];
[1:v]format=yuva420p,setpts=PTS-STARTPTS+$T/TB[card];
[bg][card]overlay=eof_action=pass,
drawbox=x=$CX-2:y=$CY-2:w=$CW+4:h=$CH+4:color=white:t=fill:enable='gte(t,$T+$REST)',
drawtext=fontfile=$CODE_FONT:text=$CODE:fontsize=$SIZE:fontcolor=0x191419:x=$CX:y=$MID-(ascent-descent)/2:enable='gte(t,$T+$REST)'[v]" \
  -map '[v]' -c:v libx264 -pix_fmt yuv420p -crf 18 -movflags +faststart "$OUT"

ffprobe -v error -show_entries format=duration,size -show_entries stream=width,height,codec_name -of default=noprint_wrappers=1 "$OUT"
ls -l "$OUT"
