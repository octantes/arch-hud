static const Block blocks[] = {
	/*icon, command, Update Interval, Update Signal*/
	{" ", "", 0, 0 },
	{"", "music-control.sh", 30, 0 },
    {"", "system-size.sh", 30, 0 },
    {"", "home-size.sh", 30, 0 },
	{"", "system-stats.sh", 30, 0 },
	{"", "date-day.sh", 05, 0},
	{"", "echo -n 'kaste\u00a0'", 0, 0},
};

static char delim[] = " | ";
static unsigned int delimLen = 5;
