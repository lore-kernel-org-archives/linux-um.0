Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B0S8x-00048c-0C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Mar 2004 13:18:35 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1B0Rss-00050U-Ut
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Mar 2004 13:01:59 -0800
Message-Id: <200403082133.i28LXpVa022891@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: [uml-user] UNIX socket networking 
In-Reply-To: Your message of "Sun, 07 Mar 2004 11:54:13 +0100."
	<20040307105414.EDC363BCB7@home.petschge.de> 
References: <200402290158.54770.jdizzl@xs4all.nl>
	<20040301201438.DE4903BCB7@home.petschge.de>
	<200403021909.47013.blaisorblade_spam@yahoo.it>
	<200403022240.25616.petschge@gmx.de>
	<20040307105414.EDC363BCB7@home.petschge.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 08 Mar 2004 16:33:51 -0500
To: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

petschge@web.de said:
> Here is a new version: 

The basic idea of allocating a socket inside UML and binding it to something
looks like it should work.  I would put the code that handles input from the
host side into an interrupt handler rather than the thread, though.

				Jef



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
