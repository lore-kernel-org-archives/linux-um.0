Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpEkS-0007Nv-Fz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 15:51:28 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CpEkQ-0004ax-Vs for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jan 2005 15:51:28 -0800
Received: from hawk (mothership.theshore.net [69.137.84.52])
	by www.theshore.net (8.12.9/8.9.1) with SMTP id j0DNpQTv030021
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Jan 2005 18:51:26 -0500
Message-ID: <001901c4f9ca$f72825d0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.10-um, /proc/stat is missing information
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
Date: Thu, 13 Jan 2005 17:52:36 -0600
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

I just verified this on a Debian install and an FC2 install.

Moving from 2.6.9-bb4 to 2.6.10-um vanilla, top reports either 100% user, or 100%
idle.

[2.6.10] # cat /proc/stat
cpu  645 1 0 0 0 0 0
cpu0 645 1 0 0 0 0 0
intr 63462 54820 0 174 10 8270 93 0 0 0 0 1 94 0 0
ctxt 108849
btime 1105659428
processes 1542
procs_running 2
procs_blocked 0

[2.6.9-bb4] # cat /proc/stat
cpu  407 0 1989 7536 252 28 1
cpu0 407 0 1989 7536 252 28 1
intr 15430 10185 0 48 1 5035 134 0 0 0 0 0 27 0 0
ctxt 10966
btime 1105660071
processes 1501
procs_running 1
procs_blocked 0

Looks like some information is missing from /proc/stat in 2.6.10.

-Chris



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
