export default function sketch(p) {
  let gfx;
  const SCALE = 6;
  const W = 16 * 8;
  const H = 9 * 4;

  let cloudField = [];
  let midCloudField = [];
  let backCloudField = [];

  let moon;
  let t = 0;
  let angleOffset;
  let amplitude;
  let noiseZ = 0;

  const EDGE_WIDTH = 8;

  p.setup = () => {
    p.createCanvas(W * SCALE, H * SCALE);
    p.noSmooth();
    gfx = p.createGraphics(W, H);
    gfx.noSmooth();
    p.dt = () => p.deltaTime / 16.67;
    resetPath();
  };

  p.draw = () => {
    updatePhysics();
    generateCloudFields();
    drawScene();
    p.image(gfx, 0, 0, p.width, p.height);
  };

  function resetPath() {
    angleOffset = p.random(p.TWO_PI);
    amplitude = p.random(10, 30);
    t = 0;
    p.noiseSeed(p.floor(p.random(10000)));
    moon = {
      x: W + 20,
      y: H / 2,
      r: p.floor(p.random(3, 5))
    };
  }

  function updatePhysics() {
    t += p.dt() * 0.5;
    moon.x = (W + 20) - t;
    moon.y = H * 0.4 + p.sin(t * 0.02 + angleOffset) * amplitude;

    noiseZ += p.dt() * 0.01;

    if (moon.x < -20) {
      resetPath();
      moon.x = W + 20;
    }
  }

  function drawScene() {
    drawSky();
    drawMoonGlow();
    drawMoonCore();
    drawCloudLayer(backCloudField, 4, 5, 8, 0.4, 150);
    drawCloudLayer(midCloudField, 7, 9, 12, 0.7, 210);
    drawCloudLayer(cloudField, 10, 12, 15, 1.0, 255);
  }

  function drawSky() {
    gfx.background(4, 6, 12);
  }

  function drawMoonGlow() {
    gfx.noStroke();
    let maxSearch = moon.r + 15;
    for (let y = -maxSearch; y <= maxSearch; y++) {
      for (let x = -maxSearch; x <= maxSearch; x++) {
        let dx = moon.x + x, dy = moon.y + y;
        if (dx < 0 || dy < 0 || dx >= W || dy >= H) continue;
        let d = p.dist(0, 0, x, y);
        let intensity = 0; 
        let col = [100, 120, 150];
        if (d > moon.r && d <= moon.r + 5) intensity = p.map(d, moon.r, moon.r + 5, 70, 30);
        else if (d > moon.r + 5 && d <= moon.r + 12) {
          intensity = p.map(d, moon.r + 5, moon.r + 12, 25, 0);
          col = [80, 140, 160];
        }
        if (intensity > 0) {
          let dither = (dx + dy) % 2 === 0 ? 1.02 : 0.98;
          gfx.fill(col[0]*dither, col[1]*dither, col[2]*dither, intensity);
          gfx.rect(p.floor(dx), p.floor(dy), 1, 1);
        }
      }
    }
  }

  function drawMoonCore() {
    gfx.noStroke();
    for (let y = -moon.r; y <= moon.r; y++) {
      for (let x = -moon.r; x <= moon.r; x++) {
        let dx = moon.x + x, dy = moon.y + y;
        if (dx < 0 || dy < 0 || dx >= W || dy >= H) continue;
        if (x*x + y*y <= moon.r*moon.r + 0.5) {
          gfx.fill(235, 240, 250);
          gfx.rect(p.floor(dx), p.floor(dy), 1, 1);
        }
      }
    }
  }

  function generateCloudFields() {
    cloudField = []; midCloudField = []; backCloudField = [];
    let tF = [], tM = [], tB = [];

    for (let y = 0; y < H; y++) {
      tF[y] = []; tM[y] = []; tB[y] = [];
      for (let x = 0; x < W; x++) {
        let n = fbm(x, y, 0.02 + noiseZ * 0.01);
        let nM = fbm(x + 1200, y + 1200, 0.018 + noiseZ * 0.01);
        let nB = fbm(x + 2400, y + 2400, 0.015 + noiseZ * 0.01);
        tF[y][x] = n > 0.46 ? 1 : 0;
        tM[y][x] = nM > 0.44 ? 1 : 0;
        tB[y][x] = nB > 0.42 ? 1 : 0;
      }
    }

    for (let y = 0; y < H; y++) {
      cloudField[y] = []; midCloudField[y] = []; backCloudField[y] = [];
      for (let x = 0; x < W; x++) {
        cloudField[y][x] = cleanLayer(tF, x, y, 12);
        midCloudField[y][x] = cleanLayer(tM, x, y, 10);
        backCloudField[y][x] = cleanLayer(tB, x, y, 8);
      }
    }
  }

  function cleanLayer(field, x, y, threshold) {
    if (field[y][x] === 0) return 0;
    let count = 0;
    for (let iy = -2; iy <= 2; iy++) {
      for (let ix = -2; ix <= 2; ix++) {
        let ny = y + iy, nx = x + ix;
        if (ny >= 0 && ny < H && nx >= 0 && nx < W && field[ny][nx] > 0) count++;
      }
    }
    return count > threshold ? 1 : 0;
  }

  function fbm(x, y, freq) {
    let v = 0, a = 0.5;
    for (let i = 0; i < 4; i++) {
      v += p.noise(x * freq, y * freq) * a;
      freq *= 2.2; a *= 0.5;
    }
    return v;
  }

  function drawCloudLayer(field, br, bg, bb, lightMult, alpha) {
    gfx.noStroke();
    for (let y = 0; y < H; y++) {
      for (let x = 0; x < W; x++) {
        if (field[y][x] === 0) continue;
        gfx.fill(br, bg, bb, alpha);
        gfx.rect(x, y, 1, 1);
        let minDist = EDGE_WIDTH + 1;
        for (let oy = -EDGE_WIDTH; oy <= EDGE_WIDTH; oy++) {
          for (let ox = -EDGE_WIDTH; ox <= EDGE_WIDTH; ox++) {
            let ny = y + oy, nx = x + ox;
            if (ny >= 0 && ny < H && nx >= 0 && nx < W && field[ny][nx] === 0) {
              minDist = p.min(minDist, p.dist(0, 0, ox, oy));
            }
          }
        }
        if (minDist <= EDGE_WIDTH) {
          let edgeFactor = p.map(minDist, 0, EDGE_WIDTH, 1, 0);
          let md = p.dist(x, y, moon.x, moon.y);
          let maxLight = 100 * lightMult;
          let lightBase = p.map(md, 0, 150, maxLight, 0, true);
          let finalIntensity = lightBase * p.pow(edgeFactor, 1.4);
          if (finalIntensity > 1) {
            let noiseVal = (p.noise(x * 0.4, y * 0.4) - 0.5) * 5;
            gfx.fill(br + finalIntensity + noiseVal, bg + finalIntensity + noiseVal, bb + (finalIntensity * 1.1) + noiseVal, alpha);
            gfx.rect(x, y, 1, 1);
          }
        }
      }
    }
  }
}
