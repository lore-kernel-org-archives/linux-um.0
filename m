Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AMw69-000178-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 20 Nov 2003 13:12:21 -0800
Received: from pisces.lunarpages.com ([64.235.234.123])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AMw69-00042W-3e
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 13:12:21 -0800
Received: from adsl-66-125-109-149.dsl.scrm01.pacbell.net ([66.125.109.149] helo=nexxus)
	by pisces.lunarpages.com with asmtp (Exim 4.24)
	id 1AMw67-0004fM-OP
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 20 Nov 2003 13:12:19 -0800
Message-ID: <000201c3afaa$fed85f40$6801a8c0@nexxus>
From: "sean whalen" <swhalen@denature.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] further scheduling weirdness
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
Date: Thu, 20 Nov 2003 13:12:15 -0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi All --
Continuing yesterday's thread where 2.6.0-test9-um was bombing on a
schedule_timeout() or interruptible_sleep_on_wait() call due to a null
pointer dereference in sched.c, I decided to try 2.4.22-um and see what
calling schedule_timeout() would do.  Again it crashes at sched.c:564, which
is a different place and has a different back trace.  This time the back
trace is:

(gdb)
451             schedule();
(gdb)
Kernel panic: kernel BUG at sched.c:564!
In interrupt handler - not syncing
 start_idle_thread (stack=0xa023e000, switch_buf_ptr=0xa023c578,
       fork_buf_ptr=0x2) at process.c:281
 281             if(n == 0)
(gdb) bt
#0  start_idle_thread (stack=0xa023e000, switch_buf_ptr=0xa023c578,
     fork_buf_ptr=0x2) at process.c:281
#1  0xa00fd15b in start_uml_skas () at process_kern.c:167
#2  0xa00f7421 in linux_main (argc=0, argv=0xa0800000) at um_arch.c:382
#3  0xa000d3a6 in main (argc=8, argv=0xbffff824, envp=0xbffff848)
at arch/um/main.c:143

This is simply due to a schedule_timeout call in a module.  Does anyone have
any ideas on this?  It seems to critical a function to actually be broken.

Thanks,
    -Sean

-
sean whalen . ucdavis security lab
swhalen at denature.org || node99.org

'if god had wanted us to evolve past the non sequitur,
he wouldn't have left all these fish in the tub.'



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
