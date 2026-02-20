/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/*
 * function            description                     argument (example)
 *
 * battery_perc        battery percentage              battery name (BAT0)
 * battery_state       battery charging state          battery name (BAT0)
 * cpu_perc            cpu usage in percent            NULL
 * datetime            date and time                   format string (%F %T)
 * ram_perc            memory usage in percent         NULL
 * vol_perc            OSS/ALSA volume in percent      mixer file (/dev/mixer)
 * wifi_essid          WiFi ESSID                      interface name (wlan0)
 */
static const struct arg args[] = {
	/* function        format              argument */
	{ cpu_perc,        " CPU %s%%",        NULL },
	{ ram_perc,        " | RAM %s%%",      NULL },
	{ battery_perc,    " | BAT %s%%",      "macsmc-battery" },
	{ battery_state,   " %s",              "macsmc-battery" },
	{ vol_perc,        " | VOL %s%%",      "/dev/mixer" },
	{ wifi_essid,      " | %s",            "wlan0" },
	{ datetime,        " | %s",            "%a %d %b %H:%M" },
};
