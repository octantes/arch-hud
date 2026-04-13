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

#define MODKEY ControlMask

#define SETPROP(p) { \
        .v = (char *[]){ "/bin/sh", "-c", \
                "prop=\"`xwininfo -children -id $1 | grep '^     0x' |" \
                "sed -e's@^ *\\(0x[0-9a-f]*\\) \"\\([^\"]*\\)\".*@\\1 \\2@' |" \
                "xargs -0 printf %b | dmenu -l 10 -w $1`\" &&" \
                "xprop -id $1 -f $0 8s -set $0 \"$prop\"", \
                p, winid, NULL \
        } \
}

static const Key keys[] = {

	/* modifier             key           function     argument */

	{ MODKEY,               XK_h,         rotate,      { .i = -1 }                    }, /* change left   */
    { MODKEY,               XK_j,         movetab,     { .i = -1 }                    }, /* moveto left   */
	{ MODKEY,               XK_Tab,       rotate,      { .i =  0 }                    }, /* change nexts  */
	{ MODKEY,               XK_k,         movetab,     { .i = +1 }                    }, /* moveto right  */
	{ MODKEY,               XK_l,         rotate,      { .i = +1 }                    }, /* change right  */

	{ MODKEY,               XK_1,         move,        { .i = 0  }                    }, /* move to tab 0 */
	{ MODKEY,               XK_2,         move,        { .i = 1  }                    }, /* move to tab 1 */
	{ MODKEY,               XK_3,         move,        { .i = 2  }                    }, /* move to tab 2 */
	{ MODKEY,               XK_4,         move,        { .i = 3  }                    }, /* move to tab 3 */
	{ MODKEY,               XK_5,         move,        { .i = 4  }                    }, /* move to tab 4 */
	{ MODKEY,               XK_6,         move,        { .i = 5  }                    }, /* move to tab 5 */
	{ MODKEY,               XK_7,         move,        { .i = 6  }                    }, /* move to tab 6 */
	{ MODKEY,               XK_8,         move,        { .i = 7  }                    }, /* move to tab 7 */
	{ MODKEY,               XK_9,         move,        { .i = 8  }                    }, /* move to tab 8 */
	{ MODKEY,               XK_0,         move,        { .i = 9  }                    }, /* move to tab 9 */

	{ MODKEY,               XK_Return,    fullscreen,  { 0       }                    },

	{ MODKEY,               XK_BackSpace, killclient,  { 0       }                    }, /* kill tab      */
    

};
