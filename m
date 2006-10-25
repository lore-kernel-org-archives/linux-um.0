Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GcsWm-0004vi-F5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 16:51:20 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GcsWl-00048E-QP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Oct 2006 16:51:20 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Thu, 26 Oct 2006 01:51:11 +0200
References: <mailman.12366.1161176325.20332.user-mode-linux-user@lists.sourceforge.net>
	<200610210310.36985.blaisorblade@yahoo.it>
	<453FA3AD.1000307@marien.org>
In-Reply-To: <453FA3AD.1000307@marien.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610260151.12329.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] guest compiled with SUBARCH=i386 in
	deadloop ; not the toolchain anyway
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Frank Marien <frank@marien.org>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wednesday 25 October 2006 19:50, Frank Marien wrote:

> Blaisorblade wrote:
> > On Wednesday 18 October 2006 20:04, Frank Marien wrote:
> >   
> >> I reported previously that a kernel build before a gcc/glibc
> Sorry to keep you waiting ; epidemic of HD crashes (at work, at
> home..)..
> I think you missed my post to the list , last thursday:

Yes, I read currently the ML only at times...

> (It talks about my last attempt ; For the host, I tried all
> permutations
> of vanilla linus kernels, gentoo-patched ones with and without the
> corresponding skas patches, in 2.6.18, 2.6.18.1, some 2.6.17's,
> 2.6.16's, and 2 more recent ones from your site.. all the same
> result.
> 
> Same for the uml.. except I didn't patch with skas of course..

> ---cut here---
> 
> Message: 1
> Date: Thu, 19 Oct 2006 21:38:16 +0159
> From: Frank Marien <frank@marien.org>
> Subject: [uml-user] 32-bit uml loops around __const_udelay..
> To: user-mode-linux-user@lists.sourceforge.net
> Message-ID: <4537D43E.9070305@marien.org>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Dear list,
> 
> This kernel is vanilla 2.6.18.1 ; compiled ARCH=um with almost all
> kernel debug enabled and SUBARCH=i386 ; all I can get from it is:
> 
> ur linux-2.6.18.1-32 # strace -f ./vmlinux
> 
> [... forever until ^C ...]

> the ptrace called by my strace command gets is refused with EPERM,
> probably because the process is already being ptraced, being an UML
> and all..
Yes. But just because you are running strace -f. UML first thread ptraces UML 
child threads, which fails.
> gdb *will* work on it though (??)
Because strace without -f works on it.
> ur linux-2.6.18.1-32 # gdb ./vmlinux

> It's looping in or around __const_udelay in
> arch/um/sys-i386/delay.c
This is interesting.
> (gdb) b 38
> Breakpoint 1 at 0x806935f: file delay.c, line 38.
> (gdb) c
> Continuing.
> 
> Breakpoint 1, __const_udelay (usecs=4295000) at delay.c:38
> 38      }
> (gdb) n
> panic (fmt=0x82320a5 "check_ptrace: PTRACE_OLDSETOPTIONS failed,
> errno = %d") at panic.c:139
If that fmt is trustworthy (it may be misleading) it's not a panic fo r a 
lockup.

> ..and entering panic() because of detecting a lockup.. sigh.. I
> disable debugging options and make again and gdb again..
> 
> ur linux-2.6.18.1-32 # gdb ./vmlinux
> GNU gdb 6.4
> Copyright 2005 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you
> are welcome to change it and/or distribute copies of it under certain
> conditions. Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "x86_64-pc-linux-gnu"...Using host libthread_db
> library "/lib/libthread_db.so.1".
>
> (gdb) run
> Starting program: /usr/src/linux-2.6.18.1-32/vmlinux
>
> Program received signal SIGINT, Interrupt.
> 0x0806bbf2 in __const_udelay ()
> (gdb) l
> 1      
> /var/tmp/portage/glibc-2.4-r3/work/build-x86-x86_64-pc-linux-gnu-nptl/csu/c
>rti.S: No such file or directory. in
> /var/tmp/portage/glibc-2.4-r3/work/build-x86-x86_64-pc-linux-gnu-nptl/csu/c
>rti.S (gdb) n
> Single stepping until exit from function __const_udelay,
> which has no line number information.
> 0x0807592a in panic ()
> (gdb) n
> Single stepping until exit from function panic,
> which has no line number information.
> n
>
> Program received signal SIGINT, Interrupt.
> 0x0806bbd7 in __const_udelay ()
> (gdb) l
> 1       in
> /var/tmp/portage/glibc-2.4-r3/work/build-x86-x86_64-pc-linux-gnu-nptl/csu/c
>rti.S (gdb) n
> Single stepping until exit from function __const_udelay,
> which has no line number information.
> 0x0807592a in panic ()
>
> ..all that gets me is no way to debug.. but still panicking..
>
> ** Tried commenting out NOP, reducing number of loops by forcing n=10 ;
> commenting out body of function so no delay would occur.. same result..
> loops and panics..
There are various layers of functions there, but there is a known bug I 
reported to Jeff... __const_udelay() of UML supposes to be called with a 
microseconds value, but udelay() from i386 (which is reused by UML) calls it 
with a much higher value because it passes a value in a different unit.
> variable "n" is not in context.. strange
optimized out.
> .. what is the end condition, then? 
> I've seen i jumping to 100000, also.. doesn't make sense to me, this
> debugging session..
>
> IMHO this is using register variables and those are screwed up somehow. But
> I don't have any experience on i386 let alone Opteron machine code.:-(


> >> or some statement saying it's not supposed to work..
> >
> > My test scenario is (almost) always make ARCH=um SUBARCH=i386 and run it
> > on a 64bit system (it happened that I ran such kernels on 32bit systems
> > and I never found problems in this transition). I always take care to use
> > skas0 for 64bit guests or, for 32bit ones noprocmm or skas0 (both work,
> > 1st is faster) if the host is a 64bit SKAS-patched one.
>
> Okay, all that is good to know. I was going blind trying to get my
> 64-bit uml run in skas3..
Happy to have saved your time about this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
