Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKk2A-0003Fj-75 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 13:59:42 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CKk28-00021V-DY
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 13:59:42 -0700
Message-Id: <200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Thu, 21 Oct 2004 17:25:55 +0200."
	<4177D503.2030409@fujitsu-siemens.com> 
References: <4177D503.2030409@fujitsu-siemens.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: Bad handling of invalif systemcalls
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
Date: Thu, 21 Oct 2004 18:09:02 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

bstroesser@fujitsu-siemens.com said:
> AFAICS, the only solution for this is using the PTRACE_O_TRACESYSGOOD
> option. This option seems to be specific for linux, but the problem
> maybe is specific for linux, too. 

Another solution is to read the instruction.

However TRACESYSGOOD is cleaner.  My only concern is whether that limits the
hosts that UML will run on.  If TRACESYSGOOD has been around for the 2.4
series, then that's OK.

I would be tempted to #define SIGSYSCALL (SIGTRAP + 0x80) or something just
to make the +0x80 bit less magic-looking.

> For the third patch I'm quite anxious, that there could go something
> wrong when using the debugger. I don't understand much about this.
> Maybe someone else could look into this? 

 				if(!tracing && (debugger_pid != -1)){
 					child_signal(pid, status);
 					continue;
 				}
 				tracing = 0;
				if(do_syscall(task, pid))
					sig = SIGUSR2;

OK, what this says is
	if we are running in the kernel, not userspace (!tracing)
	and we are debugging UML (debugger_pid != -1)
	then we fake the syscall-traced gdb into thinking the SIGTRAP was sent
	to the process

	Otherwise we call do_syscall, which will check the syscall number 
	and return true if it thinks it's handling a syscall.  In that case,
	we hit the process with SUGUSR2 in order to force it into the UML
	syscall handler.

So, if we get SIGTRAP + 0x80, we know we have a syscall, and the debugging
stuff can just go away.  You can look at this sort of mathematically, and
say SIGTRAP + 0x80 => tracing, so that if(!tracing...) can just be deleted.

Similarly, do_syscall will always return true, so you don't need to check its
return, which you have removed.

In the SIGTRAP case, you might as well inline do_sigtrap.  One line functions
are pretty much a waste.  In any case, I don't understand why you're doing
that.  orig_eax should already be -1.
	
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
