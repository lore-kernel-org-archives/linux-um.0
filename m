Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMkhl-0001HS-Le for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:43:45 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FMkhl-0001pP-6z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 03:43:45 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
References: <200603230317.48384.blaisorblade@yahoo.it>
	<200603240044.06196.blaisorblade@yahoo.it>
	<20060324041724.GB8750@ccure.user-mode-linux.org>
In-Reply-To: <20060324041724.GB8750@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241243.34687.blaisorblade@yahoo.it>
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
Date: Fri, 24 Mar 2006 12:43:33 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Friday 24 March 2006 05:17, Jeff Dike wrote:
> On Fri, Mar 24, 2006 at 12:44:05AM +0100, Blaisorblade wrote:
> > Yes, that is true, but meanwhile give a testing to them, especially
> > regression test the new patches. I can't merge new patches in until
> > I'm sure they don't cause regressions.
>
> I took a quick look through the patches - here are some comments:
>
> uml-clean-arch_switch -
>
> This chunk is strange:
>
> @@ -141,7 +148,6 @@ static void new_thread_handler(int sig)
>  	set_cmdline("(kernel thread)");
>
>  	change_sig(SIGUSR1, 1);
> -	change_sig(SIGVTALRM, 1);
>  	change_sig(SIGPROF, 1);
>  	local_irq_enable();
>  	if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))
>
> If you're fixing a bug, you should say what it is.

We discussed this time ago, and read the description of the patch:

# Also, as suggested by Jeff, remove a redundant enabling of SIGVTALRM,
# comprised in the subsequent local_irq_enable(). I'm just a bit dubious if
# ordering matters there...

Note this pre-dates soft interrupts, however.

> uml-add-tls-support -

> copy_thread - OK for now, but we should move the CLONE_TLS bit into
> arch code.

> arch_ptrace - Do all arches have PTRACE_[GS]ET_THREAD_AREA, maybe move
> inside an ifdef PTRACE_GET_THREAD_AREA

No, only x86. x86_64 already is different (supports that only for emulated 
processes).

> Any patches that change new files should be merged into this, I
> think.  That basically means that the stack will mostly collapse into
> this one patch.  I didn't see any patches which add new bits of
> functionality which would make sense standalone.

> global-ldt-sem - We should be using mutexes now, not semaphores

That's your patch, but below I drop this.

> detect-2_4-host - is there no more direct way to detect TLS support?

Yes, there is. I'll fix this when I do x86/x86_64 host distinction.

> undo-global-ldt-sem - what's so horrible about the global?  it won't
> be highly contended, so making a single mutex saves memory from every
> ldt.

For memory: 500 existing processes (a huge number in practice) * 20 byte (and 
I think a semaphore is smaller) = 10 Kbyte. We waste more for the kernel 
stack of 1 thread.

For reason: the compilation problem can be avoided differently (and the 
subsequent patch also merges duplicated code).

I didn't like global_ldt_sem because I felt it unclean; if done for memory 
usage it's another story, but still we need to check this creates no locking 
problem (almost surely no, but I want to look at the code well).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
