Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ajo0M-0005O8-8L for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 15:12:54 -0800
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Ajo0L-0001qf-RE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jan 2004 15:12:54 -0800
From: Goetz Bock <bock+uml@blacknet.de>
Subject: Re: [uml-devel] [Sebastian.Koch@metatool.de: Re: ps u failed with
	signal 8 (FPE)]
Message-ID: <20040122230626.GI17709@shell.blacknet.de>
References: <20040122114858.GH11029@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040122114858.GH11029@bytesex.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 23 Jan 2004 00:06:26 +0100
To: uml devel <user-mode-linux-devel@lists.sourceforge.net>



On Thu, Jan 22 '04 at 12:48, Gerd Knorr wrote:
> "ps u" doesn't work in uml due to some values in /proc/meminfo being zero,
> see below for details,
Works fine here:

user@uml ~$ ps u
USER      PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
user     7112  0.0  0.0  2200    4 pts/1    S    Jan03   0:00 /bin/bash
user    12177  0.0  1.5  2192  444 pts/0    S    Jan09   0:00 -bash
user    12182  0.0  1.8  2312  520 pts/0    S    Jan09   0:00 screen -r
user    12219  0.0  4.6  2208 1288 pts/2    S    Jan09   0:00 /bin/bash
user    12224  0.0  2.5  2536  724 pts/2    R    Jan09   0:00 ps u
user@uml ~$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
 Mem:  28614656 27774976   839680        0   806912 21946368
Swap: 134209536 11239424 122970112
MemTotal:        27944 kB
MemFree:           820 kB
MemShared:           0 kB
Buffers:           788 kB
Cached:          20028 kB
SwapCached:       1404 kB
Active:           1968 kB
Inactive:        21180 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        27944 kB
LowFree:           820 kB
SwapTotal:      131064 kB
SwapFree:       120088 kB
user@uml ~$ cat /proc/version
Linux version 2.4.22-4bgstatic-6um (root@basel1.hfz.info) (gcc version 3.3) #1 Mon Dec 1 01:18:56 CET 2003

user@host ~$ cat /proc/version
Linux version 2.4.23-0tr1bg (root@basel1.hfz.info) (gcc version 3.3) #1 Sun Nov 30 17:08:50 CET 2003


So what version of uml are you talking about.
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /                     (c) 2003 as GNU FDL 1.1
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
