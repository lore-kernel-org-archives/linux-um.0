Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ar51b-0002uV-Ab
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 16:48:15 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Ar50l-0002M2-Bo
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 16:47:23 -0800
Message-Id: <200402120113.i1C1Dqip008480@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Compiling 2.6.3-rc1-mm1 in UML architecture 
In-Reply-To: Your message of "Wed, 11 Feb 2004 00:12:41 EST."
             <Pine.LNX.4.44.0402102352330.3217-100000@sparrow> 
References: <Pine.LNX.4.44.0402102352330.3217-100000@sparrow> 
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
Date: Wed, 11 Feb 2004 20:13:52 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, MOLNAR Ingo <mingo@elte.hu>

wstearns@pobox.com said:
> 	Next:
> 	In file included from arch/um/kernel/syscall_kern.c:22: arch/um/
> include/sysdep/syscalls.h:17: conflicting types for  `sys_ni_syscall'
> include/linux/syscalls.h:453: previous declaration of `sys_ni_syscall'
> .   UM types it as syscall_handler_t, include/linux types it as
> "asmlinkage long".
> 	I'm lost on this one.  No idea on how to resolve it. 

Just wait for the corresponding UML patch.  2.6 is changing relatively quickly
underneath me these days.

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
