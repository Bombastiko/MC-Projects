document.addEventListener('DOMContentLoaded', () => {
  // Navigation elements
  const menuItems = document.querySelectorAll('.menu-item');
  const pages = document.querySelectorAll('.page');

  // Page switching logic
  menuItems.forEach(item => {
    item.addEventListener('click', () => {
      menuItems.forEach(i => i.classList.remove('active'));
      item.classList.add('active');

      const targetPage = item.getAttribute('data-page');
      pages.forEach(page => {
        if (page.id === targetPage) {
          page.classList.add('active');
        } else {
          page.classList.remove('active');
        }
      });
    });
  });

  // Minecraft Hex Colors mapping
  const colorMap = {
    gold: '#ffaa00',
    yellow: '#ffff55',
    white: '#ffffff',
    gray: '#aaaaaa',
    red: '#ff5555',
    green: '#55ff55',
    blue: '#5555ff',
    dark_gray: '#555555'
  };

  // Helper: Build actionbar styled spans
  function buildSpan(text, textColor, isBold, isItalic) {
    const dropShadowColor = textColor === '#ffffff' ? '#3f3f3f' : 'rgba(0,0,0,0.85)';
    const boldStyle = isBold ? 'font-weight: bold;' : 'font-weight: normal;';
    const italicStyle = isItalic ? 'font-style: italic;' : 'font-style: normal;';
    const style = `color: ${textColor}; text-shadow: 2px 2px 0px ${dropShadowColor}; ${boldStyle} ${italicStyle}`;
    return `<span style="${style}">${text}</span>`;
  }

  // ==========================================
  // 🛠 STOPWATCH CONFIGURATOR
  // ==========================================
  const playerInput = document.getElementById('player');
  const globalTypeGroup = document.getElementById('global-type-group');
  const globalTypeInput = document.getElementById('global_type');
  const swInput = document.getElementById('sw');
  const formatInput = document.getElementById('format');
  const colorInput = document.getElementById('color');
  const colorSecInput = document.getElementById('color_sec');
  const colorNumInput = document.getElementById('color_num');
  const prefixInput = document.getElementById('prefix');
  const suffixInput = document.getElementById('suffix');
  const boldInput = document.getElementById('bold');
  const commandOutput = document.getElementById('commandOutput');
  const copyBtn = document.getElementById('copyBtn');
  
  const previewPaused = document.getElementById('preview-paused');
  const actionbarPreview = document.getElementById('actionbarPreview');

  function updateSw() {
    const player = playerInput.value.trim() || '@a';
    const isGlobalTarget = player === '@a';
    
    globalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? globalTypeInput.value : 'soft';
    const sw = swInput.value.trim() || 'demo';
    const format = formatInput.value;
    const color = colorInput.value;
    const colorSec = colorSecInput.value;
    const colorNum = colorNumInput.value;
    const prefix = prefixInput.value;
    const suffix = suffixInput.value;
    const bold = boldInput.checked;
    const isPaused = previewPaused.checked;

    // 1. Generate Command
    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const command = `/function fb:sw/display_ab_custom {player:"${player}",sw:"${sw}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    commandOutput.textContent = command;

    // 2. Render HUD Preview
    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = isPaused ? colorMap.gray : colorMap[colorSec];
    const colNum = isPaused ? colorMap.dark_gray : colorMap[colorNum];
    const isItalic = isPaused;

    if (prefix) previewHtml += buildSpan(prefix, colMain, bold, isItalic);

    if (format === 'digital') {
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else if (format === 'digital_short') {
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan('.', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else if (format === 'letters') {
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('d ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('h ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('m ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    } else if (format === 'dynamic') {
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    }

    if (suffix) previewHtml += buildSpan(suffix, colMain, bold, isItalic);

    actionbarPreview.innerHTML = previewHtml;
  }

  const swInputs = [
    playerInput, globalTypeInput, swInput, formatInput, colorInput, 
    colorSecInput, colorNumInput, prefixInput, suffixInput, boldInput, previewPaused
  ];
  swInputs.forEach(i => {
    i.addEventListener('input', updateSw);
    i.addEventListener('change', updateSw);
  });

  // Setup Clipboard Copy for SW
  copyBtn.addEventListener('click', () => copyToClipboard(commandOutput.textContent, copyBtn));

  // ==========================================
  // ⏳ COUNTDOWN CONFIGURATOR
  // ==========================================
  const cdPlayerInput = document.getElementById('cd-player');
  const cdGlobalTypeGroup = document.getElementById('cd-global-type-group');
  const cdGlobalTypeInput = document.getElementById('cd-global_type');
  const cdNameInput = document.getElementById('cd-name');
  const cdHInput = document.getElementById('cd-h');
  const cdMInput = document.getElementById('cd-m');
  const cdSInput = document.getElementById('cd-s');
  const cdCmdInput = document.getElementById('cd-cmd');
  const cdAnimInput = document.getElementById('cd-anim');
  const cdFormatInput = document.getElementById('cd-format');
  const cdColorInput = document.getElementById('cd-color');
  const cdColorSecInput = document.getElementById('cd-color_sec');
  const cdColorNumInput = document.getElementById('cd-color_num');
  const cdPrefixInput = document.getElementById('cd-prefix');
  const cdSuffixInput = document.getElementById('cd-suffix');
  const cdBoldInput = document.getElementById('cd-bold');
  
  const cdPreviewPaused = document.getElementById('cd-preview-paused');
  const cdActionbarPreview = document.getElementById('cd-actionbarPreview');
  const cdBtnAnimPrev = document.getElementById('cd-btn-anim-prev');
  
  const cdCommandOutputCreate = document.getElementById('cd-commandOutputCreate');
  const cdCommandOutputDisplay = document.getElementById('cd-commandOutputDisplay');
  const cdCopyBtnCreate = document.getElementById('cd-copyBtnCreate');
  const cdCopyBtnDisplay = document.getElementById('cd-copyBtnDisplay');

  let isCdAnimRunning = false;
  let cdAnimInterval = null;

  function updateCd() {
    // If animation test is currently running, don't overwrite the preview HTML
    if (isCdAnimRunning) return;

    const player = cdPlayerInput.value.trim() || '@a';
    const isGlobalTarget = player === '@a';
    
    cdGlobalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? cdGlobalTypeInput.value : 'soft';
    const cdName = cdNameInput.value.trim() || 'demo';
    const h = parseInt(cdHInput.value) || 0;
    const m = parseInt(cdMInput.value) || 0;
    const s = parseInt(cdSInput.value) || 0;
    const cmd = cdCmdInput.value.replace(/"/g, '\\"');
    const anim = cdAnimInput.value;
    const format = cdFormatInput.value;
    const color = cdColorInput.value;
    const colorSec = cdColorSecInput.value;
    const colorNum = cdColorNumInput.value;
    const prefix = cdPrefixInput.value;
    const suffix = cdSuffixInput.value;
    const bold = cdBoldInput.checked;
    const isPaused = cdPreviewPaused.checked;

    // 1. Generate Command 1: Create
    const createCmd = `/function fb:cd/create {name:"${cdName}",h:${h},m:${m},s:${s},on_complete:"${cmd}",animation:"${anim}"}`;
    cdCommandOutputCreate.textContent = createCmd;

    // 2. Generate Command 2: Display Configuration
    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const displayCmd = `/function fb:cd/display_ab_custom {player:"${player}",cd:"${cdName}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    cdCommandOutputDisplay.textContent = displayCmd;

    // 3. Render HUD Preview
    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = isPaused ? colorMap.gray : colorMap[colorSec];
    const colNum = isPaused ? colorMap.dark_gray : colorMap[colorNum];
    const isItalic = isPaused;

    if (prefix) previewHtml += buildSpan(prefix, colMain, bold, isItalic);

    const pad = (val) => val.toString().padStart(2, '0');

    if (format === 'digital') {
      previewHtml += buildSpan(pad(h), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(m), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(s), colNum, bold, isItalic);
    } else if (format === 'digital_short') {
      previewHtml += buildSpan(pad(m), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(s), colNum, bold, isItalic);
      previewHtml += buildSpan('.', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else if (format === 'letters') {
      if (h > 0) {
        previewHtml += buildSpan(h, colNum, bold, isItalic);
        previewHtml += buildSpan('h ', colSec, bold, isItalic);
      }
      previewHtml += buildSpan(m, colNum, bold, isItalic);
      previewHtml += buildSpan('m ', colSec, bold, isItalic);
      previewHtml += buildSpan(s, colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    } else if (format === 'dynamic') {
      if (h > 0) {
        previewHtml += buildSpan(h, colNum, bold, isItalic);
        previewHtml += buildSpan('h ', colSec, bold, isItalic);
        previewHtml += buildSpan(m, colNum, bold, isItalic);
        previewHtml += buildSpan('m ', colSec, bold, isItalic);
        previewHtml += buildSpan(s, colNum, bold, isItalic);
        previewHtml += buildSpan('s', colSec, bold, isItalic);
      } else if (m > 0) {
        previewHtml += buildSpan(m, colNum, bold, isItalic);
        previewHtml += buildSpan('m ', colSec, bold, isItalic);
        previewHtml += buildSpan(s, colNum, bold, isItalic);
        previewHtml += buildSpan('s', colSec, bold, isItalic);
      } else {
        previewHtml += buildSpan(s, colNum, bold, isItalic);
        previewHtml += buildSpan('s', colSec, bold, isItalic);
      }
    }

    if (suffix) previewHtml += buildSpan(suffix, colMain, bold, isItalic);

    cdActionbarPreview.innerHTML = previewHtml;
  }

  // Live Expiration Animation Test inside browser preview
  function testCdAnimation() {
    if (isCdAnimRunning) return;
    
    isCdAnimRunning = true;
    cdBtnAnimPrev.disabled = true;
    cdBtnAnimPrev.textContent = 'Animating...';
    
    const animType = cdAnimInput.value;
    const bold = cdBoldInput.checked;
    let frames = 0;
    
    cdAnimInterval = setInterval(() => {
      frames++;
      let animHtml = '';

      if (animType === 'flash') {
        const isYellowFrame = Math.floor(frames / 5) % 2 === 0;
        const color = isYellowFrame ? colorMap.yellow : colorMap.red;
        animHtml = buildSpan('[!] TIME EXPIRED [!]', color, bold, false);
      } else if (animType === 'alert') {
        animHtml = buildSpan('[!] TIME EXPIRED [!]', colorMap.red, bold, false);
      } else if (animType === 'pulse') {
        const isGoldFrame = Math.floor(frames / 5) % 2 === 0;
        const text = isGoldFrame ? '>> TIME EXPIRED <<' : '> TIME EXPIRED <';
        const color = isGoldFrame ? colorMap.gold : colorMap.yellow;
        animHtml = buildSpan(text, color, bold, false);
      } else {
        animHtml = buildSpan('00:00.00', colorMap.dark_gray, bold, false);
      }

      cdActionbarPreview.innerHTML = animHtml;

      // Finish after 60 frames (3 seconds at 20fps)
      if (frames >= 60) {
        clearInterval(cdAnimInterval);
        isCdAnimRunning = false;
        cdBtnAnimPrev.disabled = false;
        cdBtnAnimPrev.textContent = 'Test Animation';
        updateCd(); // Restore original time layout
      }
    }, 50); // 50ms interval matches Minecraft tick rate (20 ticks per second)
  }

  const cdInputs = [
    cdPlayerInput, cdGlobalTypeInput, cdNameInput, cdHInput, cdMInput, cdSInput,
    cdCmdInput, cdAnimInput, cdFormatInput, cdColorInput, cdColorSecInput,
    cdColorNumInput, cdPrefixInput, cdSuffixInput, cdBoldInput, cdPreviewPaused
  ];
  cdInputs.forEach(i => {
    i.addEventListener('input', updateCd);
    i.addEventListener('change', updateCd);
  });

  cdBtnAnimPrev.addEventListener('click', testCdAnimation);

  // Setup Clipboard Copy for CD
  cdCopyBtnCreate.addEventListener('click', () => copyToClipboard(cdCommandOutputCreate.textContent, cdCopyBtnCreate));
  cdCopyBtnDisplay.addEventListener('click', () => copyToClipboard(cdCommandOutputDisplay.textContent, cdCopyBtnDisplay));

  // ==========================================
  // 📋 CLIPBOARD HELPER
  // ==========================================
  function copyToClipboard(text, button) {
    navigator.clipboard.writeText(text).then(() => {
      const originalText = button.textContent;
      button.textContent = 'Copied!';
      button.style.backgroundColor = '#22c55e';
      button.style.color = '#ffffff';
      
      setTimeout(() => {
        button.textContent = originalText;
        button.style.backgroundColor = '';
        button.style.color = '';
      }, 1500);
    }).catch(err => {
      const textarea = document.createElement('textarea');
      textarea.value = text;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
      
      const originalText = button.textContent;
      button.textContent = 'Copied!';
      setTimeout(() => {
        button.textContent = originalText;
      }, 1500);
    });
  }

  // Initialize SW and CD once
  updateSw();
  updateCd();
});
