Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxxzV-0004jn-D5 for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:42:33 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxxVv-0008PE-UI
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:12:00 -0800
Message-Id: <200403020100.i2210dM9025649@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Mon, 01 Mar 2004 17:07:38 EST."
	<4043B42A.10803@nortelnetworks.com> 
References: <4043B42A.10803@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: problems with UML, issues with includes
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
Date: Mon, 01 Mar 2004 20:00:39 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

cfriesen@nortelnetworks.com said:
> 1) How do I fix the build  process to pick up the kernel includes (and
> why doesn't it do that by  default?).  

You don't.  The host's libc headers and the UML pool's kernel headers are
fundamentally incompatible.  You can't mix them, as you're trying to do
by including sched.h into a userspace file.

> 2) Any ideas why I'm getting
> the descriptor thing?

No, but get a stack trace or two from that printk, and that should help figure
it out.

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
