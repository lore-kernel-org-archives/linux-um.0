Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dbhjq-0003lc-IK	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2005 09:31:10 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1Dbhjm-0001yp-MN
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 May 2005 09:31:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 479B52A07A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 May 2005 09:31:01 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
 by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12653-03 for <user-mode-linux-devel@lists.sourceforge.net>;
 Fri, 27 May 2005 09:30:59 -0700 (PDT)
Received: from SCG2 (c-67-160-150-102.hsd1.or.comcast.net [67.160.150.102])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 8CFB32A068
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 May 2005 09:30:59 -0700 (PDT)
From: "Anthony Brock" <Anthony.Brock@oregonstate.edu>
Subject: RE: [uml-devel] Kernel panic with 2.6.11.6
Message-ID: <IFEIKNDOLFNCKMGAENCFIEMNDDAA.Anthony.Brock@oregonstate.edu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <s289ce60.062@ORANGE.OUS.EDU>
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
Date: Fri, 27 May 2005 09:30:57 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

Blaisor,

I've been testing your 2.6.11.8-bs5 release applied to a 2.6.11.10 source
tree. So far (3 days), it fixes the problem with kernel panics! Did I miss a
message from you concerning this? Or is this an "accidental" fix to the
console issues I've been having?

In any case, thanks!

Tony


> -----Original Message-----
> From: user-mode-linux-devel-admin@lists.sourceforge.net
> [mailto:user-mode-linux-devel-admin@lists.sourceforge.net]On Behalf Of
> Anthony Brock
> Sent: Tuesday, May 17, 2005 10:58 AM
> To: user-mode-linux-devel@lists.sourceforge.net
> Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
>
>
> Any ideas concerning this crash? Would any more information help?
> While this only affects the console, it is VERY annoying when
> trying to deploy a new server.
>
> Thanks!
>
> Tony
>
>
> >>> "Anthony Brock" <Anthony_Brock@ous.edu> 05/10/05 09:04AM >>>
> Well, the new version didn't waste any time! It crashed on my
> first keystroke. The output is below. This is on a 2.6.12-rc4
> guest with the full patch set from
> http://user-mode-linux.sourceforge.net/patches.html applied.
> Finally, I deleted 'include/asm-um/elf.h' from the source tree
> prior to compile.
>
> Let me know if you need any further details.
>
> Tony
>
> Breakpoint 1, panic (fmt=0x0) at kernel/panic.c:66
> 66      kernel/panic.c: No such file or directory.
>         in kernel/panic.c
> (gdb) bt
> #0  panic (fmt=0x0) at kernel/panic.c:66
> #1  0x08064e38 in segv (fi={error_code = 4, cr2 = 7, trap_no =
> 14}, ip=0, is_user=0, sc=0x0) at arch/um/kernel/trap_kern.c:176
> #2  0x080650ee in segv_handler (sig=11, regs=0x82a8fc4) at
> arch/um/kernel/trap_kern.c:277
> #3  0x080788a9 in sig_handler_common_skas (sig=11,
> sc_ptr=0x8065020) at arch/um/os-Linux/skas/trap.c:52
> #4  0x08074038 in sig_handler (sig=11) at arch/um/os-Linux/signal.c:31
> #5  <signal handler called>
> #6  chan_interrupt (chans=0x7, task=0x27, tty=0xbd36000, irq=2)
> at arch/um/drivers/chan_kern.c:533
> #7  0x08068260 in line_interrupt (irq=7, data=0xbd36000,
> unused=0x82a8fc4) at arch/um/drivers/line.c:30
> #8  0x0809efa3 in handle_IRQ_event (irq=2, regs=0x82a8fc4,
> action=0xbd877a0) at kernel/irq/handle.c:87
> #9  0x0809f09b in __do_IRQ (irq=2, regs=0x82a8fc4) at
> kernel/irq/handle...c:172
> #10 0x08060460 in do_IRQ (irq=7, regs=0xffffffff) at
> arch/um/kernel/irq...c:91
> #11 0x08060647 in sigio_handler (sig=29, regs=0x82a8fc4) at
> arch/um/kernel/irq.c:221
> #12 0x080788a9 in sig_handler_common_skas (sig=29,
> sc_ptr=0x80605e0) at arch/um/os-Linux/skas/trap.c:52
> #13 0x08074038 in sig_handler (sig=29) at arch/um/os-Linux/signal.c:31
> #14 <signal handler called>
> #15 0xb7f5a5bb in nanosleep () from /lib/tls/libc.so.6
> #16 0x08075794 in idle_sleep (secs=-4) at arch/um/os-Linux/time.c:155
> #17 0x080621d6 in default_idle () at arch/um/kernel/process_kern.c:206
> #18 0x08065ea8 in init_idle_skas () at
> arch/um/kernel/skas/process_kern.c:144
> #19 0x08049643 in start_kernel () at init/main.c:526
> #20 0x08065edc in start_kernel_proc (unused=0x0) at
> arch/um/kernel/skas/process_kern.c:161
> #21 0x08073949 in run_kernel_thread (fn=0x8065eb0
> <start_kernel_proc>, arg=0x0, jmp_ptr=0xfffffffc)
>     at arch/um/os-Linux/process.c:215
> #22 0x08065bea in new_thread_handler (sig=10) at thread_info.h:46
> #23 <signal handler called>
> #24 0xb7ed9ab1 in kill () from /lib/tls/libc.so.6
> #25 0x0000000e in ?? ()
> #26 0x0000001a in ?? ()
> #27 0xffffffff in ?? ()
> #28 0xbffff118 in ?? ()
> #29 0x080785ea in start_idle_thread (stack=0x82a7ad4,
> switch_buf_ptr=0x1, fork_buf_ptr=0x0) at
> arch/um/os-Linux/skas/process.c:507
> #30 0x080785ea in start_idle_thread (stack=0x82a4000,
> switch_buf_ptr=0x82a92d4, fork_buf_ptr=0x0)
>     at arch/um/os-Linux/skas/process.c:507
> #31 0x08065f41 in start_uml_skas () at
> arch/um/kernel/skas/process_kern.c:177
> #32 0x0806556d in linux_main (argc=137271040, argv=0x8000000) at
> arch/um/kernel/um_arch.c:437
> #33 0x08072d6b in main (argc=0, argv=0xbffff2a4, envp=0x0) at
> arch/um/os-Linux/main.c:154
>
>
> >>> Blaisorblade <blaisorblade@yahoo.it> 05/10/05 03:19AM >>>
> On Monday 09 May 2005 18:40, Anthony Brock wrote:
> > First, I would appreciate it if someone can remind me of where
> to download
> > the '-mm' tree.
> >
> > Second, I downloaded at attempted to compile 2.6.12-rc4.
> Unfortunately, I'm
> > unable to compile it due to the following error:
> Remove include/asm-um/elf.h, which is a 0-length file, and it
> will work. And
> this is the real fix...
> --
> Paolo Giarrusso, aka Blaisorblade
> Skype user "PaoloGiarrusso"
> Linux registered user n. 292729
> http://www.user-mode-linux.org/~blaisorblade
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_ids93&alloc_id281&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_idt12&alloc_id344&op=ick
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
