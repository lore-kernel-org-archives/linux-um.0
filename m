Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxUDp-0004np-G5 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:55:21 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AxU2a-0007XQ-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 29 Feb 2004 08:43:44 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] host context switch reduction
References: <20040229043549.GA8583@ccure.user-mode-linux.org>
In-Reply-To: <20040229043549.GA8583@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402291748.19810.blaisorblade_spam@yahoo.it>
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
Date: Sun, 29 Feb 2004 17:48:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 05:35, domenica 29 febbraio 2004, Jeff Dike ha scritto:
> The patches below are from Laurent Vivier who didn't make them public. 
> They add a new feature to ptrace on the host which cuts down on the number
> of context switches needed for a UML system call, plus makes UML use it.
>
> There's some interest in this, so I'm putting it out as-is.  I haven't
> played with it.
>
> Laurent did some performance testing and found ~40% speedup on a getpid
> loop, and a 3.5% speedup on a kernel build.
>
> 				Jeff

That is very interesting (I've not yet looked well at the code). About the 
same subject, I've had a very vague idea passing through my head: on 2.6 the 
vsyscall stuff can use whatever mechanism it likes to talk with the kernel - 
int 0x80, or possibly something else. However a binary can legitimately still 
use the int 0x80, so we cannot avoid ptracing it (which would possibly be the 
faster thing to do).

For instance, some trick possibly with normal IPC (futexes, SysV messages or 
whatever; I think the futexes are the faster one). If we somehow mark the 
needed syscalls with a not-intercept flag and on ptrace we specify something 
as "exclude the not-intercept syscalls", we could actually have an 
improvement. The not-intercept syscalls could be the ones done through 
sysenter (anyway, UML is not able to handle sysenter syscalls right now, 
since it would need to learn the new register layout, since there has 
probably been been some change).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
