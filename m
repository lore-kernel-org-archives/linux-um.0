Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATo1o-0007US-MR
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 12:00:16 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATo1m-0003of-Jf
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 09 Dec 2003 12:00:14 -0800
Message-Id: <200312092014.hB9KE0iY003447@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] provide asm/ldt.h 
In-Reply-To: Your message of "Tue, 09 Dec 2003 13:01:01 CST."
             <Pine.LNX.4.44.0312091259250.1263-100000@gradall.private.brainfood.com> 
References: <Pine.LNX.4.44.0312091259250.1263-100000@gradall.private.brainfood.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 09 Dec 2003 15:14:00 -0500
To: Adam Heath <adam@doogie.org>
Cc: Henrik Nordstrom <hno@marasystems.com>, Steve Bennett <steveb@snapgear.com>, user-mode-linux-devel@lists.sourceforge.net

adam@doogie.org said:
> The user-side of UML should not care about the kernel version *at
> all*.  It should only be concerned with the posix interface defined by
> the host compiling environment, and the arch interface defined by UML.

Ummm, you should perhaps read the thread before responding to it.  We are
talking about compiling userspace stuff inside UML against the UML 
/usr/include/asm.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
