# Matrix companion app for Jellyfin

Custom local web app (AI-assisted build) that browses the Jellyfin catalog
with a Matrix theme:

- Login page, Matrix rain background, ambient sound toggle
- Red pill / blue pill browsing: scrollable catalog like a social feed
- Play → YouTube trailer + IMDb rating/description inline
- Blue pill ("ignorance is bliss") → plays in browser
- Red pill ("down the rabbit hole") → hands off to the Jellyfin app
- Lazy loading (10 titles at a time) to keep scrolling smooth

## Deploy

Runs as a static site or small container on mini2 (AI lab) or mini3
(sandbox) during development. Point its Jellyfin API calls at the
tailnet IP of wherever Jellyfin lives.

## Notes for the portfolio

This is the lead portfolio piece: a real web app solving real UX problems
(perf via lazy loading, dual playback paths, themed design system).
