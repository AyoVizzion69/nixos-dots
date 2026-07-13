/* See LICENSE file for copyright and license details. */

/* interval between updates (in ms) */
const unsigned int interval = 1000;

/* text to show if no value can be retrieved */
static const char unknown_str[] = "n/a";

/* maximum output string length */
#define MAXLEN 2048

/*
 * Custom Alacritty colors (from home.nix)
 * Requires dwm status2d patch for inline color rendering.
 * ^c#RRGGBB^ = set foreground, ^d^ = reset to default.
 */
static const char norm_fg[] = "#a6e3e9";
static const char norm_bg[] = "#2b1a20";
static const char sel_fg[]  = "#2b1a20";
static const char sel_bg[]  = "#a6e3e9";

static const char *fonts[] = {
	"JetBrainsMono Nerd Font:size=11:style=bold",
};

/*
 * function		description			argument (example)
 *
 * battery_perc		battery percentage		battery name (BAT0)
 * battery_remaining	battery remaining		battery name (BAT0)
 * battery_state	battery charging state		battery name (BAT0)
 * cat			read arbitrary file		file path
 * cpu_freq		cpu frequency in GHz		NULL
 * cpu_perc		cpu usage in percent		NULL
 * datetime		date and/or time		format string
 * disk_free		free disk space in GB		path to mountpoint
 * disk_perc		disk usage in percent		path to mountpoint
 * disk_total		total disk space in GB		path to mountpoint
 * disk_used		used disk space in GB		path to mountpoint
 * entropy		entropy for crypto		NULL
 * gid			GID of current user		NULL
 * hostname		hostname			NULL
 * ipv4			IPv4 address			interface name
 * ipv6			IPv6 address			interface name
 * kern_release	kernel release			NULL
 * keyboard_indicators	caps/num lock indicators	format string
 * keymap		current keyboard layout		NULL
 * load_avg		load average			NULL
 * netspeed_rx		download speed			interface name
 * netspeed_tx		upload speed			interface name
 * num_files		number of files in dir		path to directory
 * ram_free		free memory in GB		NULL
 * ram_perc		memory usage in percent		NULL
 * ram_total		total memory in GB		NULL
 * ram_used		used memory in GB		NULL
 * run_command		custom shell command		command string
 * temp			temperature			sensor file
 * uid			UID of current user		NULL
 * uptime		system uptime			NULL
 * username		username of current user	NULL
 * vol_perc		ALSA volume in percent		NULL or mixer file
 * wifi_essid		WiFi ESSID			interface name
 * wifi_perc		WiFi signal in percent		interface name
 */
static const struct arg args[] = {
	/* CPU usage */
	{ cpu_perc,   "^c#b990d6^  ^d^%s%% ",            NULL },
	/* Memory usage */
	{ ram_perc,   "^c#e58a9e^  ^d^%s%% ",            NULL },
	/* Disk usage (root) */
	{ disk_perc,  "^c#7ecba1^  ^d^%s%% ",            "/" },
	/* Volume percentage */
	{ vol_perc,   "^c#d4a373^  ^d^%s%% ",            NULL },
	/* WiFi signal strength */
	{ wifi_perc,  "^c#7dd3d8^  ^d^%s%% ",            "wlan0" },
	/* Date and time (24-hour format) */
	{ datetime,   "^c#f0b4b4^  ^d^%s ",              "%H:%M" },
};
