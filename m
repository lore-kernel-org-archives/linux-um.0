Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJTiN-0005cb-RC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 02:54:19 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DJTiN-0000bj-BQ for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 02:54:19 -0700
Message-ID: <42550348.1070309@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<200504062117.45623.blaisorblade@yahoo.it>
	<425437F0.70804@fujitsu-siemens.com>
	<200504062150.36496.blaisorblade@yahoo.it>
In-Reply-To: <200504062150.36496.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Thu, 07 Apr 2005 11:54:16 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Blaisorblade wrote:
> On Wednesday 06 April 2005 21:26, Bodo Stroesser wrote:
>>Currently they are the same for 2.4 and 2.6, but worst case that might
>>change in future versions.
> 
> Yes maybe in principle, however the errno values are part of the ABI.
I agree.
> 
>>Only debugger could note this, as ERESTART_XXXX 
>>is unvisible to user programs.
> 
> Well, the debugger is a user program, so even this one, which is almost 
> internal, is part of the ABI.
I agree.

> #ifndef ERESTARTNOINTR
> #define ERESTARTNOINTR KERN_ERESTARTNOINTR
> #endif
This is the solution, I like.
Here is, what strace programmers do, to decode ERESTARTXXXXX
results (from syscall.c):

... snip ...
#include <errno.h>
... snip ...
#ifdef LINUX
#ifndef ERESTARTSYS
#define ERESTARTSYS     512
#endif
#ifndef ERESTARTNOINTR
#define ERESTARTNOINTR  513
#endif
#ifndef ERESTARTNOHAND
#define ERESTARTNOHAND  514     /* restart if no handler.. */
#endif
#ifndef ENOIOCTLCMD
#define ENOIOCTLCMD     515     /* No ioctl command */
#endif
#ifndef ERESTART_RESTARTBLOCK
#define ERESTART_RESTARTBLOCK 516       /* restart by calling sys_restart_syscall */
#endif
#ifndef NSIG
#define NSIG 32
#endif
#ifdef ARM
#undef NSIG
#define NSIG 32
#undef NR_SYSCALL_BASE
#define NR_SYSCALL_BASE __NR_SYSCALL_BASE
#endif
#endif /* LINUX */
... snip ...

So, I'll modify my patch as you suggested.

	Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
