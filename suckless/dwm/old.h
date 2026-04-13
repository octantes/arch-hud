static const char         col_black[]    = "#1A1C1C";
static const char         col_gray[]     = "#AAABAC";
static const char         col_magenta[]  = "#986C98";
static const char         col_gray1[]    = "#1A1C1C";
static const char         col_gray2[]    = "#1A1C1C";
static const char         col_gray3[]    = "#AAABAC";
static const char         col_gray4[]    = "#1A1C1C";
static const char         col_cyan[]     = "#986C98";

static const char *colors[][3]           = {

	[SchemeNorm] = { col_gray,  col_black,    col_black    },
	[SchemeSel]  = { col_black, col_magenta,  col_magenta  },

};

static const char         *fonts[]       = { "GohuFont 11 Nerd Font:size=10" };
static const char         dmenufont[]    =   "GohuFont 11 Nerd Font:size=10";
static const Layout       layouts[]      = { { "[ T ]", tile    }, { "[ F ]", NULL    }, { "[ M ]", monocle } };
static const Rule         rules[]        = { { "placeholder window class",    NULL,          NULL, 0, 0, -1 } };
static const char         *tags[]        = {   "1", "2", "3", "4", "5", "6", "7", "8", "9"                    };

static const unsigned int borderpx       = 0;          /* border pixel of windows                           */
static const unsigned int snap           = 32;         /* snap pixel                                        */
static const unsigned int minwsz         = 20;         /* minimal heigt of a client for smfact              */
static const int          showbar        = 1;          /* 0 means no bar                                    */
static const int          topbar         = 1;          /* 0 means bottom bar                                */
static const char         ptagf[]        = "[%s %s]";  /* format of a tag label                             */
static const char         etagf[]        = "[%s]";	   /* format of an empty tag                            */
static const int          lcaselbl       = 1;	       /* 1 means make tag label lowercase                  */
static const float        mfact          = 0.25;       /* factor of master area size [0.05..0.95]           */
static const float        smfact         = 0.25;       /* factor of tiled clients [0.00..0.95]              */
static const int          nmaster        = 1;          /* number of clients in master area                  */
static const int          resizehints    = 0;          /* 1 means respect size hints in tiled resizals      */
static const int          lockfullscreen = 1;          /* 1 will force focus on the fullscreen window       */
static const int          mainmon        = 0;          /* xsetroot will only change the bar on this monitor */
static const int          refreshrate    = 74.99;      /* refresh rate (per second) for client move/resize  */
static char               dmenumon[2]    = "0";        /* monitor for dmenu launch                          */

#define MODKEY Mod4Mask
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

#define TAGKEYS(KEY,TAG) \
{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} }, \

#define TABBEDST(prog) { "tabbed", "-c", "-r", "2", "st", "-w", "", "-e", prog, NULL }

static const char        *termcmd[]      = { "st",                     NULL };
static const char        *dmenucmd[]     = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };

static const char        *tabsurfcmd[]   = { "tabbed", "-c", "surf", "-e", NULL };
static const char        *tabtermcmd[]   = { "tabbed", "-c", "-r", "2", "st", "-w", "", NULL };

static const char        *tabhtopcmd[]   = TABBEDST("htop");
static const char        *tabrmpccmd[]   = TABBEDST("rmpc");
static const char        *tabrangcmd[]   = TABBEDST("ranger");
static const char        *tabnvimcmd[]   = TABBEDST("nvim");

static const Key keys[] = {

	/* modifier                     key        function        argument             */

    { MODKEY,                       XK_Tab,    view,           {0}                  },

    { MODKEY,                       XK_q,      spawn,          {.v = tabnvimcmd}    },
    { MODKEY,                       XK_w,      spawn,          {.v = tabsurfcmd}    },
    { MODKEY,                       XK_e,      spawn,          {.v = tabhtopcmd}    },
    { MODKEY,                       XK_r,      spawn,          {.v = tabrmpccmd}    },
    { MODKEY,                       XK_t,      spawn,          {.v = tabrangcmd}    },

    { MODKEY,                       XK_a,      setlayout,      {.v = &layouts[0]}   },
	{ MODKEY,                       XK_s,      setlayout,      {.v = &layouts[1]}   },
	{ MODKEY,                       XK_d,      setlayout,      {.v = &layouts[2]}   },

	{ MODKEY,                       XK_z,      togglebar,      {0}                  },
    { MODKEY|ShiftMask,             XK_x,      quit,           {0}                  },
    { MODKEY,                       XK_x,      zoom,           {0}                  },
    { MODKEY|ShiftMask,             XK_c,      killclient,     {0}                  },

    { MODKEY|ShiftMask,             XK_space,  togglefloating, {0}                  },

	{ MODKEY,                       XK_y,      focusstack,     {.i = +1 }           },
	{ MODKEY,                       XK_u,      focusstack,     {.i = -1 }           },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 }           },
	{ MODKEY,                       XK_o,      incnmaster,     {.i = -1 }           },

	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05}         },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05}         },
	{ MODKEY,                       XK_k,      setsmfact,      {.f = +0.05}         },
	{ MODKEY,                       XK_j,      setsmfact,      {.f = -0.05}         },

    { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd  }    },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = tabtermcmd }   },
    { MODKEY,                       XK_Return, spawn,          {.v = termcmd }   },

	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 }           },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 }           },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 }           },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 }           },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)

};

static const Button buttons[] = {

	/* click                event mask      button          function        argument           */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0}                },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[0]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0}                },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd }    },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0}                },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0}                },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0}                },
	{ ClkTagBar,            0,              Button1,        view,           {0}                },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0}                },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0}                },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0}                },

    /* click: ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin  */

};
