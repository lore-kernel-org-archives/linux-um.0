Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ASs1S-0007X3-Dt
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Dec 2003 22:04:02 -0800
Received: from [216.156.129.65] (helo=www.theshore.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ASs1R-0000X2-W0
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 06 Dec 2003 22:04:02 -0800
Received: from hawk (mothership.theshore.net [68.52.199.4])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id hB7660m4023065
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 7 Dec 2003 01:06:01 -0500
Message-ID: <004201c3bc87$e1b1ab30$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
References: <hreb08uo-864t61x4044mesis$86ap70@u3d7i.vp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] BUG: /proc/ has timestamp of Dec 31, 1969
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 7 Dec 2003 00:03:45 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Hello,

I've tested this with 2.4.20-3um and the most recent uml patch (6um) against
2.4.23, on a bunch of different host machines -- all of them mount /proc/ with a
date of Dec 31, 1969.

li-20:~# ls -ald /proc/
dr-xr-xr-x   37 root     root            0 Dec 31  1969 /proc/

There are distros that rely on /proc having a timestamp close to boot time, like
for cron clearing out /var/cron.

Thanks,
-Chris



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
