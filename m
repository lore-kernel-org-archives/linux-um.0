Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiUDl-0008LT-J1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 23:53:17 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiUDl-0007K1-6b for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 23:53:17 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: uml-patch-2.6.0
Message-ID: <20040119075351.GA4088@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<bu0gnf$ief$1@sea.gmane.org> <87y8sbbrup.fsf@bytesex.org>
	<200401160233.i0G2Xcrf004288@ccure.user-mode-linux.org>
	<20040118162112.GA15509@elte.hu>
	<20040118235730.GC21046@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118235730.GC21046@ccure.user-mode-linux.org>
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
Date: Mon, 19 Jan 2004 08:53:51 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: Gerd Knorr <kraxel@bytesex.org>, user-mode-linux-devel@lists.sourceforge.net


* Jeff Dike <jdike@addtoit.com> wrote:

> 2.4 UMLs work fine with these libcs.  I had been assuming (without any
> evidence) that there was some other capability check (like uname), and
> libc gets horribly confused when it sees a 2.6 kernel that doesn't
> have the thread_info stuff.

ok, i talked to Ulrich, and it turns out that ld.so in Fedora uses the
set_tid_address() syscall to find out whether the kernel has NPTL or not
[and thus whether to use the TLS glibc or the standard one]. In UML,
this particular syscall happens to work. So i'd suggest the patch below. 
(i'll test it soon.) Once the TLS syscalls are available in UML this
syscall can be turned back on.

	Ingo

--- linux/arch/um/kernel/sys_call_table.c.orig
+++ linux/arch/um/kernel/sys_call_table.c
@@ -521,7 +521,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_epoll_ctl ] = sys_epoll_ctl,
 	[ __NR_epoll_wait ] = sys_epoll_wait,
         [ __NR_old_remap_file_pages ] = old_remap_file_pages,
-        [ __NR_set_tid_address ] = sys_set_tid_address,
+        [ __NR_set_tid_address ] = sys_ni_syscall,
 	[ __NR_timer_create ] = sys_timer_create,
 	[ __NR_timer_settime ] = sys_timer_settime,
 	[ __NR_timer_gettime ] = sys_timer_gettime,


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
