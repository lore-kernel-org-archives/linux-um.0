Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDJJb-0002bN-00 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 02:02:59 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CDJJZ-0002yI-Oy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 02:02:58 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Signal handling: use the kernels restorer 
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C42@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 1 Oct 2004 10:57:25 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

> Can you fix your mailer so that it doesn't wrap patches?
> 
> I mostly applied that (by hand since it was corrupt :-).
I would really like to fix this. The problem is, I *have* to use
Outlook, and I could not find a menu to change the behavior. Until now I
only could change the mail format to be plain text (instead of http).
I'm trying to get help from our system admins, but still got none :-(.

> 
> > But if a user directly calls sys_sigaction() without glibc being 
> > involved (e.g. via "int 0x80"), he can reset SA_RESTORER. Now the 
> > kernel should use it's own restorer-stub. On i386 it's located in
the 
> > vsyscall-page. UML must use the old method of putting it onto the 
> > stack. The patch modifies the signal-stack-setup to get the restorer
> > on the stack working.
> 
> This is the part I didn't apply.  As the comment says, gdb uses that
as a signature, and I don't want to change it for that reason.  Let's
just leave it  the same as as x86, even if that's wrong.
I don't know exactly, which part of the patch you talk about. If it is
writing the restorers code to stack, please note, there have to be
different restorers in setup_signal_stack_sc() and
setup_signal_stack_si(). They must use different systemcalls
(sys_sigreturn / sys_rt_sigreturn) to remove the signal stack frame
(refer to arch/i386/kernel/signal.c). With the patch applied, UML
exactly does, what i386 does. And it must do so, because in UML the code
on the stack could be used in special cases.

> > While testing that stuff, I could crash UML by using the wrong 
> > systemcall-number in the restorer-stub (has been wrong for 
> > sys_sigreturn). I think, there is no check in sys_(rt_)sigreturn(), 
> > whether the contents of the stack is wrong.
> 
> If the syscall number is wrong, then it'll never hit sys_sigreturn.
It sounds like there's some other sanity-checking that's missing.
No. The restorer written in setup_signal_stack_sc() has been wrong. So
the wrong syscall has been done with the wrong stack pointer (missing a
"popl %eax" at the beginning of the restorer.

> 
> > Unfortunately at the moment I can't see, what UML prints out,
because 
> > messages to console are not displayed (don't know why, yet). If the 
> > system runs, I can use dmesg, but when it is crashed ...
> 
> At gdb, printf "%s", log_buf
Thank you. I'll try that.

> 
> 				Jeff

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
