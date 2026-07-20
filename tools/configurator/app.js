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

  // Documentation Tab switching logic
  const docsNavItems = document.querySelectorAll('.docs-nav-item');
  const docSections = document.querySelectorAll('.doc-section');

  docsNavItems.forEach(item => {
    item.addEventListener('click', () => {
      docsNavItems.forEach(i => i.classList.remove('active'));
      item.classList.add('active');

      const targetDoc = item.getAttribute('data-doc');
      docSections.forEach(section => {
        if (section.id === targetDoc) {
          section.classList.add('active');
        } else {
          section.classList.remove('active');
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
    const style = `color: ${textColor}; text-shadow: 1.5px 1.5px 0px ${dropShadowColor}; ${boldStyle} ${italicStyle}`;
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
  const cdCommandOutputStart = document.getElementById('cd-commandOutputStart');
  const cdCommandOutputDisplay = document.getElementById('cd-commandOutputDisplay');
  const cdCopyBtnCreate = document.getElementById('cd-copyBtnCreate');
  const cdCopyBtnStart = document.getElementById('cd-copyBtnStart');
  const cdCopyBtnDisplay = document.getElementById('cd-copyBtnDisplay');

  let isCdAnimRunning = false;
  let cdAnimInterval = null;

  function updateCd() {
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

    // 2. Generate Command 2: Start
    const startCmd = `/function fb:cd/start {name:"${cdName}"}`;
    cdCommandOutputStart.textContent = startCmd;

    // 3. Generate Command 3: Display Configuration
    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const displayCmd = `/function fb:cd/display_ab_custom {player:"${player}",cd:"${cdName}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    cdCommandOutputDisplay.textContent = displayCmd;

    // 4. Render HUD Preview
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
      } else if (animType === 'blackout') {
        animHtml = buildSpan('00:00.00', colorMap.dark_gray, bold, false);
      } else if (animType === 'none') {
        animHtml = ''; // None (Fade Out) - renders nothing
      } else if (animType === 'stay') {
        const format = cdFormatInput.value;
        const color = cdColorInput.value;
        const colorSec = cdColorSecInput.value;
        const colorNum = cdColorNumInput.value;
        const prefix = cdPrefixInput.value;
        const suffix = cdSuffixInput.value;
        
        let previewHtml = '';
        const colMain = colorMap[color];
        const colSec = colorMap[colorSec];
        const colNum = colorMap[colorNum];

        if (prefix) previewHtml += buildSpan(prefix, colMain, bold, false);

        if (format === 'digital') {
          previewHtml += buildSpan('00', colNum, bold, false);
          previewHtml += buildSpan(':', colSec, bold, false);
          previewHtml += buildSpan('00', colNum, bold, false);
          previewHtml += buildSpan(':', colSec, bold, false);
          previewHtml += buildSpan('00', colNum, bold, false);
        } else if (format === 'digital_short') {
          previewHtml += buildSpan('00', colNum, bold, false);
          previewHtml += buildSpan(':', colSec, bold, false);
          previewHtml += buildSpan('00', colNum, bold, false);
          previewHtml += buildSpan('.', colSec, bold, false);
          previewHtml += buildSpan('00', colNum, bold, false);
        } else if (format === 'letters') {
          const h = parseInt(cdHInput.value) || 0;
          if (h > 0) {
            previewHtml += buildSpan('0', colNum, bold, false);
            previewHtml += buildSpan('h ', colSec, bold, false);
          }
          previewHtml += buildSpan('0', colNum, bold, false);
          previewHtml += buildSpan('m ', colSec, bold, false);
          previewHtml += buildSpan('0', colNum, bold, false);
          previewHtml += buildSpan('s', colSec, bold, false);
        } else if (format === 'dynamic') {
          previewHtml += buildSpan('0', colNum, bold, false);
          previewHtml += buildSpan('s', colSec, bold, false);
        }

        if (suffix) previewHtml += buildSpan(suffix, colMain, bold, false);
        animHtml = previewHtml;
      }

      cdActionbarPreview.innerHTML = animHtml;

      if (frames >= 60) {
        clearInterval(cdAnimInterval);
        isCdAnimRunning = false;
        cdBtnAnimPrev.disabled = false;
        cdBtnAnimPrev.textContent = 'Test Animation';
        updateCd();
      }
    }, 50);
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

  cdCopyBtnCreate.addEventListener('click', () => copyToClipboard(cdCommandOutputCreate.textContent, cdCopyBtnCreate));
  cdCopyBtnStart.addEventListener('click', () => copyToClipboard(cdCommandOutputStart.textContent, cdCopyBtnStart));
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

  // ==========================================
  // ⚡ EVENT GENERATOR
  // ==========================================
  const egEvent = document.getElementById('eg-event');
  const egType = document.getElementById('eg-type');
  const egCommand = document.getElementById('eg-command');
  const egFunction = document.getElementById('eg-function');
  const egItemId = document.getElementById('eg-item-id');
  const egCustomData = document.getElementById('eg-custom-data');

  const egCommandGroup = document.getElementById('eg-command-group');
  const egFunctionGroup = document.getElementById('eg-function-group');
  const egItemIdGroup = document.getElementById('eg-item-id-group');
  const egCustomDataGroup = document.getElementById('eg-custom-data-group');

  const egRegisterOutput = document.getElementById('eg-register-output');
  const egUnregisterOutput = document.getElementById('eg-unregister-output');
  
  const egCopyRegBtn = document.getElementById('eg-copy-reg-btn');
  const egCopyUnregBtn = document.getElementById('eg-copy-unreg-btn');

  function updateEventGen() {
    const eventVal = egEvent.value;
    const typeVal = egType.value;
    const isItemEvent = eventVal === 'onRightClick' || eventVal === 'onHoldItem';

    // Show/Hide inputs
    egCommandGroup.style.display = typeVal === 'command' ? 'flex' : 'none';
    egFunctionGroup.style.display = typeVal === 'function' ? 'flex' : 'none';
    egItemIdGroup.style.display = isItemEvent ? 'flex' : 'none';
    egCustomDataGroup.style.display = isItemEvent ? 'flex' : 'none';

    // Get input values
    const commandVal = egCommand.value.trim() || 'say Hello, @s!';
    const functionVal = egFunction.value.trim() || 'my_pack:welcome';
    const itemIdVal = egItemId.value.trim() || 'minecraft:carrot_on_a_stick';
    const customDataVal = egCustomData.value.trim() || '{}';

    let regCmd = '';
    let unregCmd = '';

    if (isItemEvent) {
      if (typeVal === 'command') {
        regCmd = `/function fb:event/register_item_cmd {event:"${eventVal}",cmd:"${commandVal.replace(/"/g, '\\"')}",item_id:"${itemIdVal}",custom_data:${customDataVal}}`;
        unregCmd = `/function fb:event/unregister_item_cmd {event:"${eventVal}",cmd:"${commandVal.replace(/"/g, '\\"')}",item_id:"${itemIdVal}",custom_data:${customDataVal}}`;
      } else {
        regCmd = `/function fb:event/register_item {event:"${eventVal}",fn:"${functionVal}",item_id:"${itemIdVal}",custom_data:${customDataVal}}`;
        unregCmd = `/function fb:event/unregister_item {event:"${eventVal}",fn:"${functionVal}",item_id:"${itemIdVal}",custom_data:${customDataVal}}`;
      }
    } else {
      if (typeVal === 'command') {
        regCmd = `/function fb:event/register_cmd {event:"${eventVal}",cmd:"${commandVal.replace(/"/g, '\\"')}"}`;
        unregCmd = `/function fb:event/unregister_cmd {event:"${eventVal}",cmd:"${commandVal.replace(/"/g, '\\"')}"}`;
      } else {
        regCmd = `/function fb:event/register {event:"${eventVal}",fn:"${functionVal}"}`;
        unregCmd = `/function fb:event/unregister {event:"${eventVal}",fn:"${functionVal}"}`;
      }
    }

    egRegisterOutput.textContent = regCmd;
    egUnregisterOutput.textContent = unregCmd;
  }

  const egInputs = [egEvent, egType, egCommand, egFunction, egItemId, egCustomData];
  egInputs.forEach(input => {
    input.addEventListener('input', updateEventGen);
    input.addEventListener('change', updateEventGen);
  });

  egCopyRegBtn.addEventListener('click', () => copyToClipboard(egRegisterOutput.textContent, egCopyRegBtn));
  egCopyUnregBtn.addEventListener('click', () => copyToClipboard(egUnregisterOutput.textContent, egCopyUnregBtn));

  // Initialize event generator
  updateEventGen();
});
