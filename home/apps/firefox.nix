{ osConfig, pkgs, lib, inputs, ... }:
{
  config = lib.mkIf osConfig.my-nixos.apps.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "pt-BR" ];
      configPath = ".mozilla/firefox";

      profiles.kim = {
        isDefault = true;

        extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
          ublock-origin
          darkreader
        ];

        search = {
          default = "google";
          force = true;
        };

	containers = {
	  Pessoal   = { id = 1; color = "blue";      icon = "fingerprint"; };
	  Trabalho  = { id = 2; color = "orange";    icon = "briefcase"; };
	  Financeiro= { id = 3; color = "green";     icon = "dollar"; };
	  Compras   = { id = 4; color = "pink";      icon = "cart"; };
	  WhatsApp  = { id = 5; color = "turquoise"; icon = "fence"; };
	};
	containersForce = true;

        settings = {
          "browser.contentblocking.category" = "strict";
          "network.trr.mode" = 3;
          "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
          "extensions.formautofill.creditCards.enabled" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "browser.download.useDownloadDir" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
	  "signon.rememberSignons" = false;
	  "privacy.sanitize.sanitizeOnShutdown" = true;
	  "privacy.clearOnShutdown.cookies" = true;
	  "privacy.clearOnShutdown.offlineApps" = true;
	  "datareporting.healthreport.uploadEnabled" = false;
	  "browser.discovery.enabled" = false;
	  "app.shield.optoutstudies.enabled" = false;
	  "app.normandy.enabled" = false;
	  "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
	  "datareporting.usagereporting.uploadEnabled" = true;
        };
      };
    };
  };
}