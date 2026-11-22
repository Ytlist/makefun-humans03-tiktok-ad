// Entry program for bring-the-humans-03 (Node 22, standard library only).
//
// The entry itself is the TikTok video: this program only hands the house
// the video's address. It reads VIDEO.json from the repository root and
// writes the same bytes to the output directory, where the gate reads it.
// Nothing else about the video is decided here.
//
// Local check, the way the grader runs it:
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts

import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';

const BOT_DIR = process.env.MAKEFUN_BOT_DIR ?? '/bot';
const OUTPUT_DIR = process.env.MAKEFUN_OUTPUT_DIR ?? '/output';

const source = join(BOT_DIR, 'VIDEO.json');
const target = join(OUTPUT_DIR, 'VIDEO.json');

let video;
try {
  video = readFileSync(source);
} catch (err) {
  console.error(`Could not read VIDEO.json from ${source}: ${(err as Error).message}`);
  process.exit(1);
}

try {
  JSON.parse(video.toString('utf8'));
} catch (err) {
  console.error(`VIDEO.json is not valid JSON: ${(err as Error).message}`);
  process.exit(1);
}

mkdirSync(OUTPUT_DIR, { recursive: true });
writeFileSync(target, video);
