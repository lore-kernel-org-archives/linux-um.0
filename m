Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEgn5-0003ag-2s for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 21:19:07 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CEgn3-0006M1-FY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 21:19:07 -0700
Message-Id: <200410050526.i955Q022014441@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Signal handling: deliver segfault immediately 
In-Reply-To: Your message of "Fri, 01 Oct 2004 10:10:52 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C41@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C41@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 05 Oct 2004 01:26:00 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Bodo.Stroesser@fujitsu-siemens.com said:
> I've seen this occur with one of my small tests.

As an aside, can you send your test programs?

Bodo.Stroesser@fujitsu-siemens.com said:
> No, this will not produce nested frames. 

Here's the piece in question:

-	if(sig > 0){
+	while ( (sig = get_signal_to_deliver(&info, &ka_copy, regs,
NULL)) ) {
+		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(regs, sig, &ka_copy, &info, oldset);
-		return(1);
+		if ( ! handle_signal(regs, sig, &ka_copy, &info, oldset)
)
+			break;

That's somewhat misleading.  In the normal case, you break, and looping is
only done in the error case.  I'd prefer that the structure of the code reflect
how it normally runs.

> But a new SIGSEGV signal is queued. Normally do_signal() is called
> from interrupt_end(), so without the patch the user code will be
> started next without any signal handler being delivered and the
> SIGSEGV staying in queue! Call me pedantic, but I believe, that's not
> correct.

Yeah, I would agree with that.

> If it is writing the restorers code to stack, please note, there have
> to be different restorers in setup_signal_stack_sc() and
> setup_signal_stack_si(). They must use different systemcalls
> (sys_sigreturn / sys_rt_sigreturn) to remove the signal stack frame
> (refer to arch/i386/kernel/signal.c). With the patch applied, UML
> exactly does, what i386 does.

Yup.  I wasn't paying close enough attention, and compared the i386 rt handler
with the UML non-rt handler.

> No. sys_sigsuspend() modifies current->blocked before calling
> kern_do_signal(). Because of that, it takes a copy of the original
> mask and passes it to kern_do_signal(). This mask has to be restored
> by the signal handler at sys_sigreturn. But if an error occurs, the
> handler will not be started and the mask will not be restored. Then
> kern_do_signal returns to sys_sigsuspend() with the wrong mask set,
> sys_sigsuspend() returns (the original mask is lost at that moment)
> and the SIGSEGV-handler is started later when passing interrupt_end(),
> which calls do_signal() again. The SIGSEGV handler doesn't even see
> the real "original mask", because do_signal() now calls
> kern_do_signal() with current->blocked as oldset, which is the mask
> modified by sys_sigsuspend(). So I believe, handle_signal() should
> restore the original mask if setup_signal_stack_XX() returns an error.
> (For the first case I described, this is a NOOP.) 

OK, you win.  These are now all applied, and will reach Andrew in due course.

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
