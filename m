Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CHV5V-0005XK-PO for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 15:25:45 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CHV5T-0002sz-Te
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Oct 2004 15:25:45 -0700
Message-Id: <200410122333.i9CNXq3P004254@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel panic "read of switch_pipe failed" in 2.6.8.1 
In-Reply-To: Your message of "Sat, 09 Oct 2004 20:41:56 EDT."
	<lars-37F7DA.20415609102004@sea.gmane.org> 
References: <lars-37F7DA.20415609102004@sea.gmane.org> 
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
Date: Tue, 12 Oct 2004 19:33:52 -0400
To: Lars Kellogg-Stedman <lars@oddbit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

lars@oddbit.com said:
> I'm occasionally seeing the following during the UML boot process:
>   Kernel panic: read of switch_pipe failed, errno = 9 

What's the full output?

This has happened once or twice before, and the cause was something closing
the wrong file descriptor.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
