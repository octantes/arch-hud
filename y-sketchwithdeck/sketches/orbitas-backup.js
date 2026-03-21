export default function sketch(p) {
  const STATE_CONFIG = {
    orbitToSolar: { name: 'orbit → solar', orbits: 8, duration: 30000 },
    solarToGalaxy: { name: 'solar → galaxy', orbits: 8, duration: 30000 },
    galaxyToLocal: { name: 'galaxy → local', orbits: 8, duration: 30000 },
    localToCluster: { name: 'local → cluster', orbits: 8, duration: 30000 },
    universe: { name: 'universe', orbits: 8, duration: 30000 },
    multiverse: { name: 'multiverse', orbits: 8, duration: 50000 },
    unity: { name: 'unity', orbits: 8, duration: 50000 },
    singularity: { name: 'singularity', orbits: 8, duration: 50000 }
  };

  const stateMachine = {
    currentState: 'orbitToSolar',
    states: STATE_CONFIG,
    setState(name) {
      if (this.states[name]) {
        this.currentState = name;
        onStateChange(name);
      }
    },
    getState() {
      return this.states[this.currentState];
    },
    registerState(name, config) {
      this.states[name] = config;
    }
  };

  let solars = [];
  let animationTime = 0;
  let colorTime = 0;
  let breatheTime = 0;
  let clusterStartPositions = null;
  let universeEnterTime = 0;
  let multiverseEnterTime = 0;
  let unityEnterTime = 0;
  
  let timing = 0.00005;
  let timingColor = 0.0005;
  let timingPulse = 0.005;
  let timingMove = 0.0005;
  let octantMask = null;
  let unityMask = null;
  
  let lastStateChangeMs = 0;
  
  let palette = [
    p.color(255, 0, 0),
    p.color(0, 255, 0),
    p.color(0, 0, 255)
  ];

  function shuffle(arr) {
    let a = [...arr];
    for (let i = a.length - 1; i > 0; i--) {
      let j = p.floor(p.random(i + 1));
      [a[i], a[j]] = [a[j], a[i]];
    }
    return a;
  }

  function getOrbitColors(numOrbitas) {
    let temp = [];
    while (temp.length < numOrbitas) {
      temp = temp.concat(palette);
    }
    temp = temp.slice(0, numOrbitas);
    return shuffle(temp);
  }

  function getTransitionT(stateName) {
    if (['universe', 'multiverse', 'unity', 'singularity'].includes(stateName)) {
      let current = stateMachine.currentState;
      if (stateName === 'universe' && ['multiverse', 'unity', 'singularity'].includes(current)) return 1;
      if (stateName === 'multiverse' && ['unity', 'singularity'].includes(current)) return 1;
      if (stateName === 'unity' && current === 'singularity') return 1;

      if (stateName === 'singularity') {
        if (current !== 'singularity') return 0;
        let elapsed = p.millis() - lastStateChangeMs;
        let t = elapsed / 55000.0;
        if (t > 1) t = 1;
        return easeInOut(t);
      }

      let speed = timing * 30;
      let enterTime = 0;
      if (stateName === 'universe') enterTime = universeEnterTime;
      if (stateName === 'multiverse') enterTime = multiverseEnterTime;
      if (stateName === 'unity') enterTime = unityEnterTime;

      let t = (animationTime - enterTime) * speed;
      if (t > 1) t = 1;
      return easeInOut(t);
    }
    if (!stateName.includes('To') && stateName !== 'orbitToSolar') return 0;
    let adjustedTime = animationTime;
    if (adjustedTime < 0) return 0;
    let speed = timing;
    if (stateName === 'orbitToSolar') speed = timing * 20;
    else if (stateName === 'solarToGalaxy') speed = timing * 30;
    else if (stateName === 'galaxyToLocal') speed = timing * 30;
    else if (stateName === 'localToCluster') speed = timing * 30;
    let t = (adjustedTime * speed);
    if (t > 1) t = 1;
    return easeInOut(t);
  }

  function drawOrbit(center, radio, color) {
    let tSingularity = stateMachine.currentState === 'singularity' ? getTransitionT('singularity') : 0;
    
    let breath = p.sin(breatheTime * timingPulse) * 0.1;
    breath = p.lerp(breath, 0, tSingularity);
    let effectiveRadius = radio * (1 + breath);
    
    let cx = p.width / 2;
    let cy = p.height / 2;
    let x = center.x;
    let y = center.y;
    let sw = 10;
    
    if (tSingularity > 0) {
      let zoom = p.pow(1000, tSingularity); 
      x = cx + (x - cx) * zoom;
      y = cy + (y - cy) * zoom;
      effectiveRadius *= zoom;
      sw = 10 * p.pow(zoom, 0.5); 
    }
    
    p.stroke(color);
    p.strokeWeight(sw);
    p.ellipse(x, y, effectiveRadius * 2, effectiveRadius * 2);
  }

  function getGradientColor(index, time) {
    let t = (time * timingColor + index * 0.1) % 1;
    let colorA = palette[p.floor(t * palette.length) % palette.length];
    let colorB = palette[(p.floor(t * palette.length) + 1) % palette.length];
    let localT = (t * palette.length) % 1;
    return p.lerpColor(colorA, colorB, localT);
  }

  function createSolar(numOrbitas, orbitRadius, orbitSpacing, colors) {
    let _id = 'solar_' + Math.random().toString(36).substr(2, 9);
    let _numOrbitas = numOrbitas;
    let _orbitRadius = orbitRadius;
    let _orbitSpacing = orbitSpacing;
    let _colors = colors || getOrbitColors(numOrbitas);
    let _center = p.createVector(p.width / 2, p.height / 2);

    return {
      id: () => _id,
      setId(newId) { _id = newId; },
      setCenter(x, y) {
        _center = p.createVector(x, y);
      },
      getCenter() {
        return _center;
      },
      setNumOrbitas(n) {
        _numOrbitas = n;
        _colors = getOrbitColors(n);
      },
      setColors(newColors) {
        _colors = newColors;
      },
      draw() {
        for (let i = 0; i < _numOrbitas; i++) {
          let radio = _orbitRadius + i * _orbitSpacing;
          let color = getGradientColor(i, colorTime);
          drawOrbit(_center, radio, color);
        }
      },
      _internal: {
        get colors() { return _colors; },
        get orbitRadius() { return _orbitRadius; },
        get orbitSpacing() { return _orbitSpacing; },
        get numOrbitas() { return _numOrbitas; }
      }
    };
  }

  function drawSolar(numOrbitas, orbitRadius = 20, orbitSpacing = 20) {
    let colors = getOrbitColors(numOrbitas);
    return createSolar(numOrbitas, orbitRadius, orbitSpacing, colors);
  }

  function easeInOut(t) {
    return t < 0.5 ? 2 * t * t : 1 - p.pow(-2 * t + 2, 2) / 2;
  }

  function animateOrbitSolar() {
    let t = getTransitionT('orbitToSolar');
    let totalOrbits = 8;
    let overlap = 0.3;
    let duration = (1 + overlap) / totalOrbits;
    
    let s = solars[0];
    s.setCenter(p.width / 2, p.height / 2);
    
    let orbitRadius = s._internal.orbitRadius;
    let orbitSpacing = s._internal.orbitSpacing;
    
    for (let i = 0; i < totalOrbits; i++) {
      let startTime = i * (1 / totalOrbits) * (1 - overlap);
      let orbitT = p.constrain((t - startTime) / duration, 0, 1);
      let easedT = easeInOut(orbitT);
      
      if (orbitT > 0) {
        let baseRadio = orbitRadius + i * orbitSpacing;
        let prevRadio = i > 0 ? orbitRadius + (i - 1) * orbitSpacing : orbitRadius;
        let radio = p.lerp(prevRadio, baseRadio, easedT);
        
        let alpha = easedT * 255;
        let baseColor = getGradientColor(i, colorTime);
        let color = p.color(p.red(baseColor), p.green(baseColor), p.blue(baseColor), alpha);
        
        drawOrbit(s.getCenter(), radio, color);
      }
    }
  }

  function animateSolarToGalaxy() {
    let t = getTransitionT('solarToGalaxy');
    
    let s1 = solars[0];
    let s2 = solars[1];
    
    let moveOffset = p.map(p.sin(breatheTime * timingMove), -1, 1, 12, 64);
    let appliedMove = moveOffset * t;
    
    let x1 = p.width / 2 - appliedMove;
    let y1 = p.height / 2 - appliedMove;
    s1.setCenter(x1, y1);
    s1.draw();
    
    if (t > 0.1) {
      let t2 = (t - 0.1) / 0.9;
      let alpha = easeInOut(t2) * 255;
      
      let x2 = p.width / 2 + appliedMove;
      let y2 = p.height / 2 + appliedMove;
      s2.setCenter(x2, y2);
      
      for (let i = 0; i < 8; i++) {
        let radio = s2._internal.orbitRadius + i * s2._internal.orbitSpacing;
        let color = getGradientColor(i, colorTime);
        let c = p.color(p.red(color), p.green(color), p.blue(color), alpha);
        drawOrbit(p.createVector(x2, y2), radio, c);
      }
    }
  }

  function animateGalaxyToLocal() {
    let t = getTransitionT('galaxyToLocal');
    
    let moveOffset = p.map(p.sin(breatheTime * timingMove), -1, 1, 12, 64);
    let appliedMove = moveOffset;
    
    let s1 = solars[0];
    let s2 = solars[1];
    let s3 = solars[2];
    let s4 = solars[3];
    
    let x1 = p.width / 2 - appliedMove;
    let y1 = p.height / 2 - appliedMove;
    s1.setCenter(x1, y1);
    s1.draw();
    
    let x2 = p.width / 2 + appliedMove;
    let y2 = p.height / 2 + appliedMove;
    s2.setCenter(x2, y2);
    s2.draw();
    
    if (t > 0.1) {
      let t2 = (t - 0.1) / 0.9;
      let alpha = easeInOut(t2) * 255;
      
      let x3 = p.lerp(x1, p.width / 2 + appliedMove, easeInOut(t2));
      let y3 = p.lerp(y1, p.height / 2 - appliedMove, easeInOut(t2));
      s3.setCenter(x3, y3);
      
      for (let i = 0; i < 8; i++) {
        let radio = s3._internal.orbitRadius + i * s3._internal.orbitSpacing;
        let color = getGradientColor(i, colorTime);
        let c = p.color(p.red(color), p.green(color), p.blue(color), alpha);
        drawOrbit(p.createVector(x3, y3), radio, c);
      }
      
      let x4 = p.lerp(x2, p.width / 2 - appliedMove, easeInOut(t2));
      let y4 = p.lerp(y2, p.height / 2 + appliedMove, easeInOut(t2));
      s4.setCenter(x4, y4);
      
      for (let i = 0; i < 8; i++) {
        let radio = s4._internal.orbitRadius + i * s4._internal.orbitSpacing;
        let color = getGradientColor(i, colorTime);
        let c = p.color(p.red(color), p.green(color), p.blue(color), alpha);
        drawOrbit(p.createVector(x4, y4), radio, c);
      }
    }
  }

  function animateLocalToCluster() {
    let t = getTransitionT('localToCluster');
    let tSingularity = stateMachine.currentState === 'singularity' ? getTransitionT('singularity') : 0;
    
    let rotation = t * animationTime * 0.001;
    let moveOffset = p.map(p.sin(breatheTime * timingMove), -1, 1, 12, 64);
    moveOffset = p.lerp(moveOffset, 38, tSingularity);
    let offset = moveOffset;
    let radius = offset + 100;
    
    if (!clusterStartPositions) {
      clusterStartPositions = [
        p.createVector(p.width / 2 - offset, p.height / 2 - offset),
        p.createVector(p.width / 2 + offset, p.height / 2 - offset),
        p.createVector(p.width / 2 - offset, p.height / 2 + offset),
        p.createVector(p.width / 2 + offset, p.height / 2 + offset)
      ];
    }
    
    let fixedStartAngles = clusterStartPositions.map(pos => Math.atan2(pos.y - p.height / 2, pos.x - p.width / 2));
    let sorted = fixedStartAngles.map((a, i) => ({ angle: a, origIndex: i })).sort((x, y) => x.angle - y.angle);
    let sortedStartAngles = sorted.map(x => x.angle);
    let sortIndices = sorted.map(x => x.origIndex);
    
    let parentAngles = fixedStartAngles.map(a => a + rotation);
    
    let childAngles = [];
    for (let i = 0; i < 4; i++) {
      let a1 = sortedStartAngles[i];
      let a2 = sortedStartAngles[(i + 1) % 4];
      let diff = a2 - a1;
      if (diff < 0) diff += Math.PI * 2;
      let midAngle = a1 + diff / 2;
      if (midAngle > Math.PI) midAngle -= Math.PI * 2;
      childAngles.push(midAngle + rotation);
    }
    
    let sortedChildAngles = sortIndices.map(i => childAngles[i]);
    
    for (let i = 0; i < 4; i++) {
      let startX = clusterStartPositions[i].x;
      let startY = clusterStartPositions[i].y;
      
      let targetX = p.width / 2 + p.cos(parentAngles[i]) * radius;
      let targetY = p.height / 2 + p.sin(parentAngles[i]) * radius;
      
      let x = p.lerp(startX, targetX, t);
      let y = p.lerp(startY, targetY, t);
      
      solars[i].setCenter(x, y);
      solars[i].draw();
    }
    
    if (t > 0.1) {
      let t2 = (t - 0.1) / 0.9;
      let alpha = easeInOut(t2) * 255;
      
      for (let i = 0; i < 4; i++) {
        let startX = clusterStartPositions[i].x;
        let startY = clusterStartPositions[i].y;
        
        let parentTargetX = p.width / 2 + p.cos(parentAngles[i]) * radius;
        let parentTargetY = p.height / 2 + p.sin(parentAngles[i]) * radius;
        
        let parentX = p.lerp(startX, parentTargetX, t);
        let parentY = p.lerp(startY, parentTargetY, t);
        
        let childTargetX = p.width / 2 + p.cos(sortedChildAngles[i]) * radius;
        let childTargetY = p.height / 2 + p.sin(sortedChildAngles[i]) * radius;
        
        let x = p.lerp(parentX, childTargetX, easeInOut(t2));
        let y = p.lerp(parentY, childTargetY, easeInOut(t2));
        
        solars[i + 4].setCenter(x, y);
        
        for (let j = 0; j < 8; j++) {
          let radio = solars[i + 4]._internal.orbitRadius + j * solars[i + 4]._internal.orbitSpacing;
          let color = getGradientColor(j, colorTime);
          let c = p.color(p.red(color), p.green(color), p.blue(color), alpha);
          drawOrbit(p.createVector(x, y), radio, c);
        }
      }
    }
  }

  function advanceState() {
    let stateNames = Object.keys(stateMachine.states);
    let currentIndex = stateNames.indexOf(stateMachine.currentState);
    let nextIndex = (currentIndex + 1) % stateNames.length;
    stateMachine.setState(stateNames[nextIndex]);
    lastStateChangeMs = p.millis();
  }

  function onStateChange(stateName) {
    let config = stateMachine.getState();
    
    if (stateName === 'orbitToSolar') {
      solars = [];
      let s = drawSolar(config.orbits);
      solars.push(s);
      animationTime = 0;
      breatheTime = 0;
      colorTime = 0;
    } else if (stateName === 'solarToGalaxy') {
      let oldSolar = solars[0];
      let sharedId = oldSolar.id();
      let sharedColors = [...oldSolar._internal.colors];
      
      solars = [];
      let s1 = drawSolar(config.orbits);
      s1.setColors(sharedColors);
      s1.setId(sharedId);
      solars.push(s1);
      
      let s2 = drawSolar(config.orbits);
      s2.setColors(sharedColors);
      s2.setId(sharedId);
      solars.push(s2);
      
      animationTime = 0;
    } else if (stateName === 'galaxyToLocal') {
      clusterStartPositions = null;
      
      let oldSolar = solars[0];
      let sharedId = oldSolar.id();
      let sharedColors = [...oldSolar._internal.colors];
      
      solars = [];
      for (let i = 0; i < 4; i++) {
        let s = drawSolar(config.orbits);
        s.setColors(sharedColors);
        s.setId(sharedId);
        solars.push(s);
      }
      
      animationTime = 0;
    } else if (stateName === 'localToCluster') {
      clusterStartPositions = solars.map(s => s.getCenter().copy());
      
      let oldSolar = solars[0];
      let sharedId = oldSolar.id();
      let sharedColors = [...oldSolar._internal.colors];
      
      let existingSolares = [...solars];
      solars = [];
      
      for (let i = 0; i < 4; i++) {
        let s = existingSolares[i];
        solars.push(s);
      }
      
      for (let i = 0; i < 4; i++) {
        let s = drawSolar(config.orbits);
        s.setColors(sharedColors);
        s.setId(sharedId);
        solars.push(s);
      }
      
      animationTime = 0;
    } else if (stateName === 'universe') {
      universeEnterTime = animationTime;
    } else if (stateName === 'multiverse') {
      multiverseEnterTime = animationTime;
    } else if (stateName === 'unity') {
      unityEnterTime = animationTime;
    }
  }

  function animateUniverse() {
    let t = getTransitionT('universe');
    animateLocalToCluster();
    
    let mirrorAlpha = easeInOut(t) * 255;
    
    if (mirrorAlpha > 0) {
      let q1 = p.get(0, 0, p.width / 2, p.height / 2);
      
      p.blendMode(p.BLEND);
      p.tint(255, mirrorAlpha);
      
      p.push();
      p.translate(p.width, 0);
      p.scale(-1, 1);
      p.image(q1, 0, 0);
      p.pop();
      
      p.push();
      p.translate(0, p.height);
      p.scale(1, -1);
      p.image(q1, 0, 0);
      p.pop();
      
      p.push();
      p.translate(p.width, p.height);
      p.scale(-1, -1);
      p.image(q1, 0, 0);
      p.pop();
      
      p.noTint();
    }
  }

  function animateMultiverse() {
    animateUniverse();

    let t = getTransitionT('multiverse');
    let multiAlpha = easeInOut(t) * 255;

    if (multiAlpha > 0) {
      let dim = Math.max(p.width, p.height) / 2;
      let q1 = p.get(p.width / 2 - dim, p.height / 2 - dim, dim, dim);
      q1.mask(octantMask);

      p.blendMode(p.BLEND);
      p.tint(255, multiAlpha);
      p.push();
      p.translate(p.width / 2, p.height / 2);

      for (let i = 0; i < 4; i++) {
        p.push();
        p.rotate(i * p.HALF_PI);
        p.image(q1, -dim, -dim);
        p.scale(1, -1);
        p.image(q1, -dim, -dim);
        p.pop();
      }

      p.pop();
      p.noTint();
    }
  }

  function animateUnity() {
    animateMultiverse();

    let t = getTransitionT('unity');
    let unityAlpha = easeInOut(t) * 255;

    if (unityAlpha > 0) {
      let dim = Math.max(p.width, p.height) / 2;
      let q1 = p.get(p.width / 2 - dim, p.height / 2 - dim, dim, dim);
      q1.mask(unityMask);

      p.blendMode(p.BLEND);
      p.tint(255, unityAlpha);
      p.push();
      p.translate(p.width / 2, p.height / 2);

      for (let i = 0; i < 8; i++) {
        p.push();
        p.rotate(i * p.QUARTER_PI);
        p.image(q1, -dim, -dim);
        p.scale(1, -1);
        p.image(q1, -dim, -dim);
        p.pop();
      }

      p.pop();
      p.noTint();
    }
  }

  function animateSingularity() {
    animateUnity();
  }

  p.setup = () => {
    p.createCanvas(1920, 1080);
    p.noFill();

    let dim = Math.max(p.width, p.height) / 2;

    octantMask = p.createGraphics(dim, dim);
    octantMask.fill(255);
    octantMask.noStroke();
    octantMask.triangle(dim, dim, 0, dim, 0, 0);

    unityMask = p.createGraphics(dim, dim);
    unityMask.fill(255);
    unityMask.noStroke();
    let opp = dim * p.tan(p.PI / 8);
    unityMask.triangle(dim, dim, 0, dim, 0, dim - opp);

    stateMachine.setState('orbitToSolar');
    lastStateChangeMs = p.millis();
  };

  p.draw = () => {
    p.background(0);
    p.blendMode(p.DIFFERENCE);

    animationTime += 1;
    colorTime += 1;
    breatheTime += 1;

    let activeState = stateMachine.currentState;

    if (activeState === 'orbitToSolar') {
      animateOrbitSolar();
    } else if (activeState === 'solarToGalaxy') {
      animateSolarToGalaxy();
    } else if (activeState === 'galaxyToLocal') {
      animateGalaxyToLocal();
    } else if (activeState === 'localToCluster') {
      animateLocalToCluster();
    } else if (activeState === 'universe') {
      animateUniverse();
    } else if (activeState === 'multiverse') {
      animateMultiverse();
    } else if (activeState === 'unity') {
      animateUnity();
    } else if (activeState === 'singularity') {
      animateSingularity();
    }

    p.blendMode(p.BLEND);
  };

  p.getSketchInfo = function() {
    return {
      current: stateMachine.currentState,
      states: Object.keys(stateMachine.states),
      names: Object.fromEntries(Object.entries(stateMachine.states).map(([k, v]) => [k, v.name])),
      actions: {
        setState: (name) => {
          stateMachine.setState(name);
          lastStateChangeMs = p.millis();
        },
        nextState: () => {
          advanceState();
        }
      }
    };
  };
}
