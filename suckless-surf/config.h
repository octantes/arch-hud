static int   surfuseragent    = 1;                       /* append surf version to default webkit user agent     */
static int   extendedtitle    = 0;                       /* 0 to not append surf toggle and page status to title */
static char *fulluseragent    = "";                      /* override user agent string                           */
static char *scriptfile       = "~/.config/surf/script.js";
static char *styledir         = "~/.config/surf/styles/";
static char *certdir          = "~/.config/surf/certificates/";
static char *cachedir         = "~/.config/surf/cache/";
static char *cookiefile       = "~/.config/surf/cookies.txt";
static char *searchurl        = "duckduckgo.com/?q=%s";

static Parameter defconfig[ParameterLast] = { 

    /* 0 = default | per-uri = 1 | command = 2 | highest priority will be used */

	/* parameter                    arg value       priority                   */
	[AccessMicrophone]    =       { { .i = 0                                }, },
	[AccessWebcam]        =       { { .i = 0                                }, },
	[Certificate]         =       { { .i = 0                                }, },
	[CaretBrowsing]       =       { { .i = 0                                }, },
	[CookiePolicies]      =       { { .v = "@Aa"                            }, },
	[DarkMode]            =       { { .i = 0                                }, },
	[DefaultCharset]      =       { { .v = "UTF-8"                          }, },
	[DiskCache]           =       { { .i = 1                                }, },
	[DNSPrefetch]         =       { { .i = 0                                }, },
	[Ephemeral]           =       { { .i = 0                                }, },
	[FileURLsCrossAccess] =       { { .i = 0                                }, },
	[FontSize]            =       { { .i = 12                               }, },
	[Geolocation]         =       { { .i = 0                                }, },
	[HideBackground]      =       { { .i = 0                                }, },
	[Inspector]           =       { { .i = 0                                }, },
	[JavaScript]          =       { { .i = 1                                }, },
	[KioskMode]           =       { { .i = 0                                }, },
	[LoadImages]          =       { { .i = 1                                }, },
	[MediaManualPlay]     =       { { .i = 1                                }, },
	[PDFJSviewer]         =       { { .i = 1                                }, },
	[PreferredLanguages]  =       { { .v = (char *[]) { NULL }              }, },
	[RunInFullscreen]     =       { { .i = 0                                }, },
	[ScrollBars]          =       { { .i = 1                                }, },
	[ShowIndicators]      =       { { .i = 1                                }, },
	[SiteQuirks]          =       { { .i = 1                                }, },
	[SmoothScrolling]     =       { { .i = 0                                }, },
	[SpellChecking]       =       { { .i = 0                                }, },
	[SpellLanguages]      =       { { .v = ( (char *[]) { "en_US", NULL } ) }, },
	[StrictTLS]           =       { { .i = 1                                }, },
	[Style]               =       { { .i = 1                                }, },
	[WebGL]               =       { { .i = 0                                }, },
	[ZoomLevel]           =       { { .f = 1.0                              }, },

};

static UriParameters     uriparams[] = { { "(://|\\.)suckless\\.org(/|$)", { [JavaScript] = { { .i = 0 }, 1 }, }, }, };         /* uri parameters                      */
static int               winsize[] = { 800, 600 };                                                                              /* default windows size (w, h)         */
static WebKitFindOptions findopts = WEBKIT_FIND_OPTIONS_CASE_INSENSITIVE | WEBKIT_FIND_OPTIONS_WRAP_AROUND;                     /* webkit find options                 */

#define PROMPT_GO   "Go:"
#define PROMPT_FIND "Find:"

/* SETPROP (readprop, setprop, prompt)                     */
#define SETPROP(r, s, p) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "prop=\"$(printf '%b' \"$(xprop -id $1 "r" " \
             "| sed -e 's/^"r"(UTF8_STRING) = \"\\(.*\\)\"/\\1/' " \
             "      -e 's/\\\\\\(.\\)/\\1/g')\" " \
             "| dmenu -b -p '"p"' -w $1)\" " \
             "&& xprop -id $1 -f "s" 8u -set "s" \"$prop\"", \
             "surf-setprop", winid, NULL \
        } \
}

#define SEARCH() { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "xprop -id $1 -f $2 8u -set $2 \"" \
             "$(dmenu -p search: -w $1 < /dev/null)\"", \
             "surf-search", winid, "_SURF_SEARCH", NULL \
        } \
}

/* DOWNLOAD (uri, referer)                                 */
#define DOWNLOAD(u, r) { \
        .v = (const char *[]){ "st", "-e", "/bin/sh", "-c",\
             "curl -g -L -J -O -A \"$1\" -b \"$2\" -c \"$2\"" \
             " -e \"$3\" \"$4\"; read", \
             "surf-download", useragent, cookiefile, r, u, NULL \
        } \
}

/* PLUMB (uri) | called when uri does not begin with about */
#define PLUMB(u) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "xdg-open \"$0\"", u, NULL \
        } \
}

/* VIDEOPLAY (uri)                                         */
#define VIDEOPLAY(u) { \
        .v = (const char *[]){ "/bin/sh", "-c", \
             "mpv --really-quiet \"$0\"", u, NULL \
        } \
}

/* site specific styles                                    */
static SiteSpecific styles[] = {                                     

	/* regexp               file in $styledir */
	{ ".*",                 "default.css" },

};

static SiteSpecific certs[] = {                                      /* cite specific certs                                     */

	/* regexp               file in $certdir */
	{ "://suckless\\.org/", "suckless.org.crt" },

};

#define MODKEY Mod4Mask

static Key keys[] = {     /* if using something other than MODKEY & GDK_SHIFT_MASK edit CLEANMASK() */

    /* modifier              keyval     function    arg */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_q, spawn,           SETPROP("_SURF_URI", "_SURF_GO", PROMPT_GO) },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_w, spawn,           SEARCH()                                         },    
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_e, spawn,           SETPROP("_SURF_FIND", "_SURF_FIND", PROMPT_FIND) },

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_r, reload,          { .i = 0   } }, /* reloads the current page         */

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_a, find,            { .i = +1  } }, /* switch to next find result       */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_s, stop,            { 0        } }, /* stops current page load          */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_d, zoom,            { .i = 0   } }, /* resets zoom                      */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_f, find,            { .i = -1  } }, /* switch to previous find result   */

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_y, navigate,        { .i = -1  } }, /* navigates backwards in history   */
    { MODKEY|GDK_SHIFT_MASK, GDK_KEY_u, zoom,            { .i = -1  } }, /* zooms page out                   */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_i, zoom,            { .i = +1  } }, /* zooms page in                    */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_o, navigate,        { .i = +1  } }, /* navigates forwards in history    */

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_h, scrollh,         { .i = -10 } }, /* viewport percentage scroll value */   
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_j, scrollv,         { .i = -10 } }, /* viewport percentage scroll value */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_k, scrollv,         { .i = +10 } }, /* viewport percentage scroll value */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_l, scrollh,         { .i = +10 } }, /* viewport percentage scroll value */

	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_n, clipboard,       { .i = 1   } }, /* copies selection to clipboard    */
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_m, clipboard,       { .i = 0   } }, /* pastes into field from clipboard */

    /*
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_c,      toggle,             { .i = CaretBrowsing } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_g,      toggle,             { .i = Geolocation   } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_s,      toggle,             { .i = JavaScript    } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_i,      toggle,             { .i = LoadImages    } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_b,      toggle,             { .i = ScrollBars    } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_t,      toggle,             { .i = StrictTLS     } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_m,      toggle,             { .i = Style         } },
	{ MODKEY|GDK_SHIFT_MASK, GDK_KEY_d,      toggle,             { .i = DarkMode      } },
    */

};

static Button buttons[] = {      /* target can be OnDoc, OnLink, OnImg, OnMedia, OnEdit, OnBar, OnSel, OnAny */

	/* target       event mask      button  function           argument         stop event                   */

	{ OnLink,       0,              2,      clicknewwindow,    { .i = 0  },              1 },
	{ OnLink,       MODKEY,         2,      clicknewwindow,    { .i = 1  },              1 },
	{ OnLink,       MODKEY,         1,      clicknewwindow,    { .i = 1  },              1 },
	{ OnAny,        0,              8,      clicknavigate,     { .i = -1 },              1 },
	{ OnAny,        0,              9,      clicknavigate,     { .i = +1 },              1 },
	{ OnMedia,      MODKEY,         1,      clickexternplayer, { 0       },              1 },

};

#define HOMEPAGE "https://duckduckgo.com/"
