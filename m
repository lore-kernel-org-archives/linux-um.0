Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsdZd-0001K0-H7
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:53:49 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AsdR4-00058R-S8
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:44:58 -0800
From: Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20040215232525.7c2f38a8.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com>
References: <20040215232525.7c2f38a8.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: Segfault of UML-TT on FC1
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
Date: Mon, 16 Feb 2004 02:50:11 -0500 (EST)
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com


On Sun, 15 Feb 2004, Pete Zaitcev wrote:

> The &__bss_start at this point is a01c6000, abd brk_start is a1f33000,
> and so memcpy segfaults when it steps on the hole.
> 
> Does anyone have a suggestion what to do about this?

the workaround is to install the setarch rpm, and then do:

	i386 ./linux <args>

(but it would be nice to find the brk assumption in UML and change it to
work with the FC1 brk changes.)

	Ingo


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
