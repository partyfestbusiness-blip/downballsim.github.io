DOWNBALL SIMULATOR — ONLINE + UPGRADES

Files:
- index.html: game.

Features:
- Solo 1v1 vs bot, local keyboard 1v1, online 1v1, online 2v2, online 1v1v1v1.
- Online room codes using Trystero/WebRTC peer-to-peer networking; no manual offer/answer copy-paste.
- Persistent local coins and upgrades for movement speed and sprint.
- Match rewards for finishing bot and online matches: 20 coins, plus 10 if you win.
- Local 1v1 deliberately ignores upgrades and does not award coins.
- Distinct colors for player courts/paddles.
- Ball physics uses tiny substeps (max 1.5 px movement per substep) and paddle snapping to reduce tunneling.

IMPORTANT ONLINE NOTES
- Online mode loads Trystero from https://esm.run/trystero, so internet access is required.
- For reliable module loading, publish the folder as a static website (for example GitHub Pages) and open the https:// page. Opening index.html directly as file:// may block module imports in some browsers.
- Create a room and share its room code; friends select the same online mode and join with that code.
- This is peer-to-peer. Most connections should work, but some restrictive networks can block direct WebRTC connections. It is not a guaranteed always-on dedicated server.
- Coins and upgrades are saved in that player's own browser using localStorage; they do not automatically transfer to another device/browser.
- The current build is a playable prototype; online host owns match state and the networking is not an anti-cheat authoritative server.
