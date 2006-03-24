Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMdia-0003Tr-Qg for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 20:16:08 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMdiZ-0002Ku-7D
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Mar 2006 20:16:08 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: TLS support - status - need for re-testing
Message-ID: <20060324041724.GB8750@ccure.user-mode-linux.org>
References: <200603230317.48384.blaisorblade@yahoo.it>
	<20060323211424.GA6130@ccure.user-mode-linux.org>
	<200603240044.06196.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603240044.06196.blaisorblade@yahoo.it>
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
Date: Thu, 23 Mar 2006 23:17:24 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>

On Fri, Mar 24, 2006 at 12:44:05AM +0100, Blaisorblade wrote:
> Yes, that is true, but meanwhile give a testing to them, especially
> regression test the new patches. I can't merge new patches in until
> I'm sure they don't cause regressions.

I took a quick look through the patches - here are some comments:

uml-clean-arch_switch -

This chunk is strange:

@@ -141,7 +148,6 @@ static void new_thread_handler(int sig)
 	set_cmdline("(kernel thread)");
 
 	change_sig(SIGUSR1, 1);
-	change_sig(SIGVTALRM, 1);
 	change_sig(SIGPROF, 1);
 	local_irq_enable();
 	if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))

If you're fixing a bug, you should say what it is.  But the original
looks right, since the process has been scheduled and is running on
its kernel stack, so it should be able to take timer interrupts now.

uml-add-tls-support -

copy_thread - OK for now, but we should move the CLONE_TLS bit into
arch code.

arch_ptrace - Do all arches have PTRACE_[GS]ET_THREAD_AREA, maybe move
inside an ifdef PTRACE_GET_THREAD_AREA

Any patches that change new files should be merged into this, I
think.  That basically means that the stack will mostly collapse into
this one patch.  I didn't see any patches which add new bits of
functionality which would make sense standalone.

global-ldt-sem - We should be using mutexes now, not semaphores

detect-2_4-host - is there no more direct way to detect TLS support?

undo-global-ldt-sem - what's so horrible about the global?  it won't
be highly contended, so making a single mutex saves memory from every
ldt.

				Jeff




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
