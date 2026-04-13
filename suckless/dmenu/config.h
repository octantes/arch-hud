static       int   topbar  = 1;
static const char *fonts[] = { "GohuFont 11 Nerd Font:size=10" };
static const char *prompt  = NULL;

static const char *colors[SchemeLast][2] = {

	/*                             #fg        #bg      */
	[SchemeNorm] =              { "#AAABAC", "#1A1C1C" },
	[SchemeSel] =               { "#1A1C1C", "#986c98" },
	[SchemeSelHighlight] =      { "#D8DADE", "#986C98" },
	[SchemeNormHighlight] =     { "#986C98", "#1A1C1C" },
	[SchemeOut] =               { "#1A1C1C", "#8AB6BB" },

};

static unsigned int lines          = 0;
static const char worddelimiters[] = " ";
