Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CYsEm-0006Zq-OU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 12:35:08 -0800
Received: from pool-141-154-235-89.bos.east.verizon.net ([141.154.235.89]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CYsEl-0002dZ-Pm
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Nov 2004 12:35:08 -0800
Message-Id: <200411292250.iATMoWOF004837@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] skas mode on a non-skas host
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
Date: Mon, 29 Nov 2004 17:50:32 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>

Prompted by some questions from Blaisorblade about whether something like skas
mode might be implemented on unpatched hosts, I went ahead and did exactly
that.

The basic idea is that in place of /proc/mm and PTRACE_FAULTINFO, we have a
couple of extra pages in the userspace process to hold code that we are going 
to use to make it change its address space and to handle segfaults so addresses
and access modes can be reported back to the kernel process.

The end result is something that is very close to skas mode, just as secure,
loses two pages of address space to UML rather than .5G, should be almost
as fast, and runs on a stock host kernel.

The patch is available as skas0 from my patches page -
	http://user-mode-linux.sourceforge.net/patches.html
and there is a good deal of commentary associated with it.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
