Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5uDD-0005oK-TD for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 15:49:47 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1C5uD9-00081T-8s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Sep 2004 15:49:47 -0700
Message-Id: <200409102352.i8ANql0O004842@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc 
In-Reply-To: Your message of "Wed, 25 Aug 2004 22:06:26 EDT."
	<20040826020626.GA28471@malice.crymeariver.org> 
References: <20040826020626.GA28471@malice.crymeariver.org> 
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
Date: Fri, 10 Sep 2004 19:52:47 -0400
To: David Jeffery <djeffery@britsys.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

djeffery@britsys.net said:
> The problem is caused by the incorrect implementation of sys_clone().
>  sys_clone() is an ugly beast that has different arguements depending
> on  the architecture.  For i386 and ppc, the child tid is passed as
> the  5th arguement instead of as the 4th arguement as as some other
> architectures (like x86-64) do.  The 4th arguement on i386 and ppc
> doesn't look to be used by the kernel. 

This is fixed in my tree.  It was a lot simpler than your patch, or what I
led you to believe.  I just moved sys_clone from syscall_kern.c to
arch/um/sys-i386/syscalls.c and fixed the interface.

Other architectures will now lack it, but that'll be easy to fix.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
