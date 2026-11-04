{ pkgs, inputs, ... }:

{
  imports = [ inputs.nixcord.nixosModules.nixcord ];

  programs.nixcord = {
    enable = true;
    user = "feel";
    discord = {
      equicord.enable = true;
      krisp.enable = true;
      openASAR.enable = false;
    };
  };

  programs.nixcord.config.plugins = {
    addAttachments.enable = true;
    alwaysExpandRoles = {
      enable = true;
      hideArrow = true;
    };
    betterBackreading.enable = true;
    betterRoleDot.enable = true;
    betterSessions.enable = true;
    betterSettings.enable = true;
    betterUploadButton.enable = true;
    biggerStreamPreview.enable = true;
    callTimer.enable = true;
    channelTabs = {
      showBookmarkBar = false;
      tabHeightScale = 75;
    };
    concatenatedComponentExtractor.enable = true;
    concatenatedModules.enable = true;
    consoleJanitor.enable = true;
    copyEmojiMarkdown.enable = true;
    crashHandler.enable = true;
    customTimestamps = {
      formats.enable = false;
    };
    disableCallIdle.enable = true;
    disableDeepLinks.enable = true;
    equibopStreamFixes.enable = true;
    equicordHelper.enable = true;
    equicordToolbox.enable = true;
    equiTweaks = {
      enable = true;
      disableHolidayNotifications = true;
      noMirroredCamera = true;
      refreshSlashCommands = true;
      removeActivitySection = true;
      showAllBadges = true;
      showYourOwnActivityButtons = true;
    };
    experiments.enable = true;
    expressionManager.enable = true;
    favoriteAnything.enable = true;
    fixDiscordCss.enable = true;
    followVoiceUser.enable = true;
    gameActivityToggle.enable = true;
    ghosted = {
      enable = true;
      showIndicator = false;
    };
    greetStickerPicker.enable = true;
    limitlessScreenshare.enable = true;
    memberCount.enable = true;
    mentionAvatars.enable = true;
    messageLogger = {
      enable = true;
      deleteStyle = "overlay";
      ignoreBots = false;
    };
    messageLoggerEnhanced = {
      enable = true;
      blacklistedIds = "1556016919147057173";
      ignoreBots = true;
      ignoreWebhooks = true;
      imageCacheDir = "~/.config/Equicord/MessageLoggerData/savedImages";
      logsDir = "~/.config/Equicord/MessageLoggerData";
      saveImages = true;
    };
    moreUserTags = {
      tagSettings = {
        administrator.enable = false;
        chatModerator.enable = false;
        moderator.enable = false;
        moderatorStaff.enable = false;
        owner.enable = false;
        voiceModerator.enable = false;
        webhook.enable = false;
        enable = false;
      };
    };
    newGuildSettings = {
      enable = true;
      messages = 1;
    };
    newPluginsManager.enable = true;
    noDevtoolsWarning.enable = true;
    noF1.enable = true;
    noOnboardingDelay.enable = true;
    noPendingCount = {
      enable = true;
      hideMessageRequestsCount = false;
      hidePremiumOffersCount = false;
    };
    noTrack.enable = true;
    openInApp.enable = true;
    platformIndicators = {
      enable = true;
      profiles = false;
    };
    platformSpoofer.enable = true;
    previewMessage.enable = true;
    questify = {
      acknowledgedNotices = {
        quest-ban-warning-2026-08-07 = true;
        quest-ban-warning-2026-08-26 = true;
      };
      isOnQuestsPage = true;
      questButtonBadgeCount = 18;
    };
    relationshipNotifier.enable = true;
    repeatMessages.enable = true;
    searchFix.enable = true;
    sendTimestamps.enable = true;
    serverInfo.enable = true;
    settings.enable = true;
    silentMessageToggle.enable = true;
    silentTyping.enable = true;
    supportHelper.enable = true;
    timezones = {
      askedTimezone = true;
    };
    typingTweaks.enable = true;
    validReply.enable = true;
    validUser.enable = true;
    viewIcons.enable = true;
    voiceChannelLog.enable = true;
    webContextMenus.enable = true;
    webKeybinds = {
      enable = true;
      overrideCommonKeybinds = true;
    };
    webScreenShareFixes.enable = true;
    whosWatching.enable = true;
  };
  programs.nixcord.extraConfig.plugins = {
    musicRichPresence = {
      showLastFmLogo = true;
    };
    shikiCodeblocks = {
      tryHljs = "SECONDARY";
    };
  };
}
