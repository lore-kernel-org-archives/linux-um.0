Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asoc0-0001C2-Fe
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:41:00 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AsoYL-0001US-6W
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:37:13 -0800
Received: from ccure.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by ccure.user-mode-linux.org (8.12.5/8.12.5) with ESMTP id i1GK4isq024309
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 16 Feb 2004 15:04:44 -0500
Message-Id: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] uml-patch-2.4.24-1
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
Date: Mon, 16 Feb 2004 15:04:44 -0500
To: user-mode-linux-devel@lists.sourceforge.net

This patch updates UML to 2.4.24, and pushes out the fixes that have 
accumulated, including
        mconsole log (in combination with the next utilities release) will 
add a newline to the end of all input
        rebooting or halting a UML with mconsole sysrq will no longer hang
the client
        worked around the bug which caused /proc to have a 1970 date
        fixed a race which could cause a userspace signal to appear to have 
happened in the kernel and panicing it
        fixed some exec_shield brokenness.
        changed HZ to 100, fixing some time problems, including ps start times
drifting away from real time, and maybe some at brokenness

                                Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
