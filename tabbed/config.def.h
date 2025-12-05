static const char  font[]        = "GohuFont 11 Nerd Font:size=9";

static const char* normbgcolor   = "#1A1C1C";
static const char* normfgcolor   = "#AAABAC";
static const char* selbgcolor    = "#8AB6BB";
static const char* selfgcolor    = "#1A1C1C";
static const char* urgbgcolor    = "#8AB6BB";
static const char* urgfgcolor    = "#1A1C1C";

static const char  before[]      = "<";
static const char  after[]       = ">";
static const char  titletrim[]   = "...";
static const int   tabwidth      = 200;
static const Bool  foreground    = True;
static const int   barHeight	 = 24;
static       Bool  urgentswitch  = False;
static int         newposition   = 0;
static Bool        npisrelative  = False;

#define SETPROP(p) { \
        .v = (char *[]){ "/bin/sh", "-c", \
                "prop=\"`xwininfo -children -id $1 | grep '^     0x' |" \
                "sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' |" \
                "xargs -0 printf %b | dmenu -l 10 -w $1`\" &&" \
                "xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
                p, winid, NULL \
        } \
}

#define MODKEY ControlMask

static const Key keys[] = {

	/* modifier             key        function     argument */

	{ MODKEY|ShiftMask,     XK_Return, focusonce,   { 0 } },
	{ MODKEY|ShiftMask,     XK_Return, spawn,       { 0 } },

	{ MODKEY,               XK_l,      rotate,      { .i = +1 } },
	{ MODKEY,               XK_h,      rotate,      { .i = -1 } },
	{ MODKEY|ShiftMask,     XK_l,      movetab,     { .i = +1 } },
    { MODKEY|ShiftMask,     XK_h,      movetab,     { .i = -1 } },

	{ MODKEY,               XK_Tab,    rotate,      { .i = 0 } },

	{ MODKEY,               XK_grave,  spawn,       SETPROP("_TABBED_SELECT_TAB") },

	{ MODKEY,               XK_1,      move,        { .i = 0 } },
	{ MODKEY,               XK_2,      move,        { .i = 1 } },
	{ MODKEY,               XK_3,      move,        { .i = 2 } },
	{ MODKEY,               XK_4,      move,        { .i = 3 } },
	{ MODKEY,               XK_5,      move,        { .i = 4 } },
	{ MODKEY,               XK_6,      move,        { .i = 5 } },
	{ MODKEY,               XK_7,      move,        { .i = 6 } },
	{ MODKEY,               XK_8,      move,        { .i = 7 } },
	{ MODKEY,               XK_9,      move,        { .i = 8 } },
	{ MODKEY,               XK_0,      move,        { .i = 9 } },

	{ MODKEY,               XK_q,      killclient,  { 0 } },

	{ MODKEY,               XK_u,      focusurgent, { 0 } },
	{ MODKEY|ShiftMask,     XK_u,      toggle,      { .v = (void*) &urgentswitch } },

	{ 0,                    XK_F11,    fullscreen,  { 0 } },

};
