static const Block blocks[] = {

	/*  icon,        command,                                 interval,     signal    */
	{   " ",         "",                                      00,           0         },
	{   "",          "block-music.sh",                        05,           1         },
    {   "",          "block-disk.sh",                         30,           2         },
	{   "",          "block-systat.sh",                       30,           3         },
	{   "",          "date '+%A %Y/%m/%d %H:%M'",             05,           4         },
	{   "",          "echo -n 'kaste '",                      00,           5         },

};

static char delim[]          = " | ";
static unsigned int delimLen = 4;
