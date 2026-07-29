// Global Navigation Helpers for Dashboard Shortcuts
function switchPage(pageId) {
  const menuItems = document.querySelectorAll('.menu-item');
  const pages = document.querySelectorAll('.page');

  menuItems.forEach(i => {
    if (i.getAttribute('data-page') === pageId) {
      i.classList.add('active');
    } else {
      i.classList.remove('active');
    }
  });

  pages.forEach(page => {
    if (page.id === pageId) {
      page.classList.add('active');
      page.style.display = 'block';
    } else {
      page.classList.remove('active');
      page.style.display = 'none';
    }
  });
}

function switchDocTab(docId) {
  const docsTabs = document.querySelectorAll('.docs-tab');
  const docContents = document.querySelectorAll('.doc-content');

  docsTabs.forEach(tab => {
    if (tab.getAttribute('data-doc') === docId) {
      tab.classList.add('active');
    } else {
      tab.classList.remove('active');
    }
  });

  docContents.forEach(section => {
    if (section.id === docId) {
      section.classList.add('active');
      section.style.display = 'block';
    } else {
      section.classList.remove('active');
      section.style.display = 'none';
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  // Navigation elements
  const menuItems = document.querySelectorAll('.menu-item');
  menuItems.forEach(item => {
    item.addEventListener('click', () => {
      const targetPage = item.getAttribute('data-page');
      switchPage(targetPage);
    });
  });

  // Documentation Tab switching logic
  const docsTabs = document.querySelectorAll('.docs-tab');
  docsTabs.forEach(item => {
    item.addEventListener('click', () => {
      const targetDoc = item.getAttribute('data-doc');
      switchDocTab(targetDoc);
    });
  });

  // Copy to Clipboard Utility
  function copyToClipboard(text, btnElement) {
    if (!text || text.startsWith('<')) return;
    navigator.clipboard.writeText(text).then(() => {
      const originalText = btnElement.innerHTML;
      btnElement.classList.add('copied');
      btnElement.innerHTML = `✓ Copied!`;
      setTimeout(() => {
        btnElement.classList.remove('copied');
        btnElement.innerHTML = originalText;
      }, 1800);
    }).catch(err => {
      console.error('Failed to copy: ', err);
    });
  }

  // Minecraft Colors mapping
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

  function buildSpan(text, textColor, isBold, isItalic) {
    const dropShadowColor = textColor === '#ffffff' ? '#3f3f3f' : 'rgba(0,0,0,0.85)';
    const boldStyle = isBold ? 'font-weight: bold;' : 'font-weight: normal;';
    const italicStyle = isItalic ? 'font-style: italic;' : 'font-style: normal;';
    const style = `color: ${textColor}; text-shadow: 2px 2px 0px ${dropShadowColor}; ${boldStyle} ${italicStyle}`;
    return `<span style="${style}">${text}</span>`;
  }

  function validateInput(inputElement, isValid) {
    if (!inputElement) return;
    if (isValid) {
      inputElement.classList.remove('input-invalid');
    } else {
      inputElement.classList.add('input-invalid');
    }
  }

  // ==========================================
  // ⏱️ STOPWATCH CONFIGURATOR
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
    if (!playerInput) return;
    const rawPlayer = playerInput.value.trim();
    const rawSw = swInput.value.trim();

    const isPlayerValid = rawPlayer.length > 0;
    const isSwValid = rawSw.length > 0;

    validateInput(playerInput, isPlayerValid);
    validateInput(swInput, isSwValid);

    const player = isPlayerValid ? rawPlayer : '@a';
    const sw = isSwValid ? rawSw : 'demo';
    const isGlobalTarget = player === '@a';
    
    // Dynamically show/hide global_type field (only applies to global @a)
    if (globalTypeGroup) globalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? globalTypeInput.value : 'soft';
    const format = formatInput.value;
    const color = colorInput.value;
    const colorSec = colorSecInput.value;
    const colorNum = colorNumInput.value;
    const prefix = prefixInput.value.trim();
    const suffix = suffixInput.value.trim();
    const bold = boldInput.checked;
    const isPaused = previewPaused.checked;

    if (!isPlayerValid || !isSwValid) {
      commandOutput.textContent = '<Fill required fields (*) above to generate command>';
      commandOutput.style.color = 'var(--text-muted)';
    } else {
      commandOutput.style.color = 'var(--accent-yellow)';
      const escapedPrefix = prefix.replace(/"/g, '\\"');
      const escapedSuffix = suffix.replace(/"/g, '\\"');
      commandOutput.textContent = `/function fb:sw/display_ab_custom {player:"${player}",sw:"${sw}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    }

    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = isPaused ? colorMap.gray : colorMap[colorSec];
    const colNum = isPaused ? colorMap.dark_gray : colorMap[colorNum];
    const isItalic = isPaused;

    const displayPrefix = prefix || 'Timer: ';
    previewHtml += buildSpan(displayPrefix, colMain, bold, isItalic);

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
    if (i) {
      i.addEventListener('input', updateSw);
      i.addEventListener('change', updateSw);
    }
  });

  if (copyBtn) copyBtn.addEventListener('click', () => copyToClipboard(commandOutput.textContent, copyBtn));

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
  const cdFormatInput = document.getElementById('cd-format');
  const cdColorInput = document.getElementById('cd-color');
  const cdPrefixInput = document.getElementById('cd-prefix');
  const cdBoldInput = document.getElementById('cd-bold');
  const cdPreviewPaused = document.getElementById('cd-preview-paused');
  const cdActionbarPreview = document.getElementById('cd-actionbarPreview');
  
  const cdCommandOutputCreate = document.getElementById('cd-commandOutputCreate');
  const cdCommandOutputStart = document.getElementById('cd-commandOutputStart');
  const cdCommandOutputDisplay = document.getElementById('cd-commandOutputDisplay');
  const cdCopyBtnCreate = document.getElementById('cd-copyBtnCreate');
  const cdCopyBtnStart = document.getElementById('cd-copyBtnStart');
  const cdCopyBtnDisplay = document.getElementById('cd-copyBtnDisplay');

  function updateCd() {
    if (!cdPlayerInput) return;
    const rawPlayer = cdPlayerInput.value.trim();
    const rawName = cdNameInput.value.trim();

    const isPlayerValid = rawPlayer.length > 0;
    const isNameValid = rawName.length > 0;

    validateInput(cdPlayerInput, isPlayerValid);
    validateInput(cdNameInput, isNameValid);

    const player = isPlayerValid ? rawPlayer : '@a';
    const cdName = isNameValid ? rawName : 'timer1';
    const isGlobalTarget = player === '@a';
    
    // Dynamically show/hide global_type field (only applies to global @a)
    if (cdGlobalTypeGroup) cdGlobalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? cdGlobalTypeInput.value : 'soft';
    const h = parseInt(cdHInput.value) || 0;
    const m = parseInt(cdMInput.value) || 0;
    const s = parseInt(cdSInput.value) || 0;
    const cdCmdRaw = cdCmdInput.value.trim();
    
    const cdCmd = cdCmdRaw.length > 0 ? cdCmdRaw : 'data get storage fb:tmp dummy';
    const format = cdFormatInput.value;
    const color = cdColorInput.value;
    const prefix = cdPrefixInput.value.trim();
    const bold = cdBoldInput.checked;
    const isPaused = cdPreviewPaused.checked;

    if (!isPlayerValid || !isNameValid) {
      cdCommandOutputCreate.textContent = '<Fill required fields (*) above to generate commands>';
      cdCommandOutputStart.textContent = '<Fill required fields (*) above to generate commands>';
      cdCommandOutputDisplay.textContent = '<Fill required fields (*) above to generate commands>';
      cdCommandOutputCreate.style.color = 'var(--text-muted)';
      cdCommandOutputStart.style.color = 'var(--text-muted)';
      cdCommandOutputDisplay.style.color = 'var(--text-muted)';
    } else {
      cdCommandOutputCreate.style.color = 'var(--accent-yellow)';
      cdCommandOutputStart.style.color = 'var(--accent-yellow)';
      cdCommandOutputDisplay.style.color = 'var(--accent-yellow)';

      const escapedCdCmd = cdCmd.replace(/'/g, "\\'");
      const escapedPrefix = prefix.replace(/"/g, '\\"');

      cdCommandOutputCreate.textContent = `/function fb:cd/create {name:"${cdName}",h:${h},m:${m},s:${s},cmd:'${escapedCdCmd}'}`;
      cdCommandOutputStart.textContent = `/function fb:cd/start {name:"${cdName}"}`;
      cdCommandOutputDisplay.textContent = `/function fb:cd/display_ab_custom {player:"${player}",cd:"${cdName}",format:"${format}",color:"${color}",color_sec:"gray",color_num:"white",prefix:"${escapedPrefix}",suffix:"",bold:"${bold}",global_type:"${globalType}"}`;
    }

    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = colorMap.gray;
    const colNum = colorMap.white;
    const isItalic = isPaused;

    const displayPrefix = prefix || 'Time Left: ';
    previewHtml += buildSpan(displayPrefix, colMain, bold, isItalic);

    const pad = (n) => (n < 10 ? '0' + n : n);
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
    } else {
      previewHtml += buildSpan(s, colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    }

    cdActionbarPreview.innerHTML = previewHtml;
  }

  const cdInputs = [
    cdPlayerInput, cdGlobalTypeInput, cdNameInput, cdHInput, cdMInput, cdSInput, cdCmdInput,
    cdFormatInput, cdColorInput, cdPrefixInput, cdBoldInput, cdPreviewPaused
  ];
  cdInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateCd);
      i.addEventListener('change', updateCd);
    }
  });

  if (cdCopyBtnCreate) cdCopyBtnCreate.addEventListener('click', () => copyToClipboard(cdCommandOutputCreate.textContent, cdCopyBtnCreate));
  if (cdCopyBtnStart) cdCopyBtnStart.addEventListener('click', () => copyToClipboard(cdCommandOutputStart.textContent, cdCopyBtnStart));
  if (cdCopyBtnDisplay) cdCopyBtnDisplay.addEventListener('click', () => copyToClipboard(cdCommandOutputDisplay.textContent, cdCopyBtnDisplay));

  // ==========================================
  // 📱 ACTIONBAR OVERWRITE CONFIGURATOR (/function fb:display/ab/overwrite)
  // ==========================================
  const abPlayerInput = document.getElementById('ab-player');
  const abDurationInput = document.getElementById('ab-duration');
  const abDurationHint = document.getElementById('ab-duration-hint');
  const abCustomTextInput = document.getElementById('ab-custom-text');
  const abColorInput = document.getElementById('ab-color');
  const abPrefixInput = document.getElementById('ab-prefix');
  const abBoldInput = document.getElementById('ab-bold');
  const abActionbarPreview = document.getElementById('ab-actionbarPreview');
  const abCommandOutput = document.getElementById('ab-commandOutput');
  const abCopyBtn = document.getElementById('ab-copyBtn');

  function updateAb() {
    if (!abCustomTextInput) return;
    const rawPlayer = abPlayerInput.value.trim();
    const rawDuration = abDurationInput.value.trim();
    const rawText = abCustomTextInput.value.trim();

    const isPlayerValid = rawPlayer.length > 0;
    const isDurationValid = rawDuration.length > 0 && parseInt(rawDuration) > 0;
    const isTextValid = rawText.length > 0;

    validateInput(abPlayerInput, isPlayerValid);
    validateInput(abDurationInput, isDurationValid);
    validateInput(abCustomTextInput, isTextValid);

    const player = isPlayerValid ? rawPlayer : '@a';
    const duration = isDurationValid ? parseInt(rawDuration) : 100;
    const messageText = isTextValid ? rawText : 'Speed Boost Active!';
    const color = abColorInput.value;
    const prefix = abPrefixInput.value.trim();
    const bold = abBoldInput.checked;

    const seconds = (duration / 20).toFixed(1);
    if (abDurationHint) {
      abDurationHint.textContent = `${duration} ticks = ${seconds} seconds duration`;
    }

    if (!isPlayerValid || !isDurationValid || !isTextValid) {
      abCommandOutput.textContent = '<Fill required fields (*) above to generate command>';
      abCommandOutput.style.color = 'var(--text-muted)';
    } else {
      abCommandOutput.style.color = 'var(--accent-yellow)';
      const fullMessage = prefix + messageText;
      const escapedMessage = fullMessage.replace(/"/g, '\\"');
      const boldJson = bold ? ',"bold":true' : '';
      const jsonComponent = `{"text":"${escapedMessage}","color":"${color}"${boldJson}}`;

      abCommandOutput.textContent = `/function fb:display/ab/overwrite {player:"${player}",text:'${jsonComponent}',duration:${duration}}`;
    }

    let previewHtml = '';
    const colMain = colorMap[color];

    const displayPrefix = prefix || '[INFO] ';
    previewHtml += buildSpan(displayPrefix, colMain, bold, false);
    previewHtml += buildSpan(messageText, colMain, bold, false);

    abActionbarPreview.innerHTML = previewHtml;
  }

  const abInputs = [
    abPlayerInput, abDurationInput, abCustomTextInput,
    abColorInput, abPrefixInput, abBoldInput
  ];
  abInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateAb);
      i.addEventListener('change', updateAb);
    }
  });

  if (abCopyBtn) abCopyBtn.addEventListener('click', () => copyToClipboard(abCommandOutput.textContent, abCopyBtn));

  // ==========================================
  // ⚡ EVENT CONFIGURATOR
  // ==========================================
  const egTypeInput = document.getElementById('eg-type');
  const egEventInput = document.getElementById('eg-event');
  const egItemGroup = document.getElementById('eg-item-group');
  const egItemInput = document.getElementById('eg-item');
  const egItemLabel = document.getElementById('eg-item-label');
  const egItemHint = document.getElementById('eg-item-hint');
  const egCdGroup = document.getElementById('eg-cd-group');
  const egCdInput = document.getElementById('eg-cd');
  const egFnInput = document.getElementById('eg-fn');
  const egFnLabel = document.getElementById('eg-fn-label');
  const egCommandOutput = document.getElementById('eg-commandOutput');
  const egCopyBtn = document.getElementById('eg-copyBtn');

  const validRightClickItems = [
    'carrot_on_a_stick',
    'minecraft:carrot_on_a_stick',
    'warped_fungus_on_a_stick',
    'minecraft:warped_fungus_on_a_stick'
  ];

  const itemEvents = ['onRightClick', 'onHoldItem'];

  function updateEventGen() {
    if (!egEventInput) return;
    const actionType = egTypeInput ? egTypeInput.value : 'command';
    const eventName = egEventInput.value;
    const item = egItemInput.value.trim();
    const cd = egCdInput.value.trim();
    const fn = egFnInput.value.trim();

    const isItemEvent = itemEvents.includes(eventName);
    const isRightClick = eventName === 'onRightClick';

    // 1. DYNAMICALLY SHOW/HIDE ITEM AND CUSTOM_DATA FIELDS FOR NON-ITEM EVENTS
    if (egItemGroup) egItemGroup.style.display = isItemEvent ? 'flex' : 'none';
    if (egCdGroup) egCdGroup.style.display = isItemEvent ? 'flex' : 'none';

    // 2. Update Target Command / Function Label & Placeholder dynamically
    if (egFnLabel && egFnInput) {
      if (actionType === 'command') {
        egFnLabel.textContent = 'Target Command *';
        egFnInput.placeholder = 'e.g. scoreboard players add @s fb.t_fire 1';
      } else {
        egFnLabel.textContent = 'Target Function *';
        egFnInput.placeholder = 'e.g. my_pack:cast_spell';
      }
    }

    // 3. Validate onRightClick & onHoldItem requirements
    let isItemValid = true;
    if (isItemEvent) {
      if (isRightClick) {
        if (egItemLabel) egItemLabel.textContent = 'Required Item ID (Carrot or Warped Fungus on a Stick) *';
        if (egItemHint) egItemHint.style.display = 'flex';
        const cleanItem = item.toLowerCase();
        isItemValid = validRightClickItems.includes(cleanItem);

        if (!isItemValid && item.length > 0) {
          if (egItemHint) {
            egItemHint.className = 'field-error';
            egItemHint.innerHTML = `<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg> Error: onRightClick only supports 'carrot_on_a_stick' or 'warped_fungus_on_a_stick'!`;
          }
        } else if (egItemHint) {
          egItemHint.className = 'field-info';
          egItemHint.innerHTML = `<svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg> Required for onRightClick: minecraft:carrot_on_a_stick or minecraft:warped_fungus_on_a_stick`;
        }
      } else {
        if (egItemLabel) egItemLabel.textContent = 'Required Item ID *';
        if (egItemHint) egItemHint.style.display = 'none';
        isItemValid = item.length > 0;
      }
      validateInput(egItemInput, isItemValid);
      validateInput(egCdInput, cd.length > 0);
    }

    const isFnValid = fn.length > 0;
    validateInput(egFnInput, isFnValid);

    // 4. Generate Output Command
    if (isItemEvent) {
      const isCdValid = cd.length > 0;
      if (!isCdValid || !isFnValid || !item || !isItemValid) {
        if (isRightClick && item && !isItemValid) {
          egCommandOutput.textContent = `<Error: onRightClick requires item_id to be 'carrot_on_a_stick' or 'warped_fungus_on_a_stick'>`;
          egCommandOutput.style.color = '#ff5555';
        } else {
          egCommandOutput.textContent = '<Fill required fields (*) above to generate registration command>';
          egCommandOutput.style.color = 'var(--text-muted)';
        }
      } else {
        egCommandOutput.style.color = 'var(--accent-yellow)';
        const fnName = actionType === 'command' ? 'register_item_cmd' : 'register_item';
        egCommandOutput.textContent = `/function fb:event/${fnName} {name:"${eventName}",item_id:"${item}",custom_data:${cd},fn:"${fn}"}`;
      }
    } else {
      // Standard events (onJoin, onDeath, onLeave, onKillPlayer, onDamage, whileOnline, whileOffline)
      if (!isFnValid) {
        egCommandOutput.textContent = '<Fill required fields (*) above to generate registration command>';
        egCommandOutput.style.color = 'var(--text-muted)';
      } else {
        egCommandOutput.style.color = 'var(--accent-yellow)';
        const fnName = actionType === 'command' ? 'register_cmd' : 'register';
        const fnKey = actionType === 'command' ? 'cmd' : 'fn';
        egCommandOutput.textContent = `/function fb:event/${fnName} {name:"${eventName}",${fnKey}:"${fn}"}`;
      }
    }
  }

  const egInputs = [egTypeInput, egEventInput, egItemInput, egCdInput, egFnInput];
  egInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateEventGen);
      i.addEventListener('change', updateEventGen);
    }
  });

  if (egCopyBtn) egCopyBtn.addEventListener('click', () => copyToClipboard(egCommandOutput.textContent, egCopyBtn));

  // Initial runs
  updateSw();
  updateCd();
  updateAb();
  updateEventGen();
});
