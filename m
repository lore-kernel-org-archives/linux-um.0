Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGdjZ-0005H6-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 03 Nov 2003 04:23:02 -0800
Received: from linuxhacker.ru
	([217.76.32.60] helo=shrek.linuxhacker.ru ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AGdjZ-0008VV-A8
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 03 Nov 2003 04:23:01 -0800
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: [uml-devel] Sleeping process getting segfault signal
Message-ID: <20031103122114.GA10845@linuxhacker.ru>
References: <Pine.GSO.4.58.0311012137370.355@altair.dur.ac.uk> <200311020923.hA29Np9K029637@car.linuxhacker.ru> <200311030236.hA32aggX002499@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311030236.hA32aggX002499@ccure.karaya.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 3 Nov 2003 14:21:14 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: m.a.young@durham.ac.uk, user-mode-linux-devel@lists.sourceforge.net

Hello!

On Sun, Nov 02, 2003 at 09:36:42PM -0500, Jeff Dike wrote:
> > Jeff: I finally hit the problem yesterday with extra debug code to
> > save the sigmask. Here's what I see. (also include sigjump buffer that
> > was setup later than sigprocmask was run).
> > sigmask = {__val = {134284288
> (gdb) p/x 134284288
> $1 = 0x8010400
> Thats SIGSEGV (the one that matters here), SIGCHLD, and SIGIO.  So, we have
> to figure out how we're getting there with SIGSEGV blocked.  What's the stack
> at that point?

(gdb) bt
#0  0xa01658e3 in memcpy () at proc_fs.h:154
#1  0xa00d8075 in __do_user_copy (to=0x9fffef14, from=0xa02df7e0, n=800, 
    fault_addr=0xa57c0284, fault_catcher=0xa57c0288, 
    op=0xa00d8088 <__do_copy>, faulted_out=0xa57c3a80) at uaccess_user.c:29
#2  0xa00d80bb in __do_copy_to_user (to=0x9fffef14, from=0xa02df7e0, n=800, 
    fault_addr=0xa57c0284, fault_catcher=0xa57c0288) at uaccess_user.c:54
#3  0xa00cfd69 in setup_signal_stack_sc (stack_top=800, sig=17, 
    handler=2684350228, restorer=0x4004a978, regs=0xa57c0274, mask=0xa57c3b2c)
    at uaccess.h:61
#4  0xa00d4c87 in handle_signal (regs=0xa57c0274, signr=17, ka=0xa39586c4, 
    info=0xa57c3bf4, oldset=0x320, error=0) at signal_kern.c:114
#5  0xa00d4fdc in kern_do_signal (regs=0xa57c0274, oldset=0xa57c02f0, error=0)
    at signal_kern.c:231
#6  0xa00d5126 in do_signal (error=0) at signal_kern.c:262
#7  0xa00d32ce in interrupt_end () at process_kern.c:136
#8  0xa00db199 in sig_handler_common_tt (sig=11, sc_ptr=0x58) at trap_user.c:40
#9  0xa00d7f7a in sig_handler (sig=11, sc=

Bye,
    Oleg


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
