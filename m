Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLD1O-0004zh-BK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 20:56:50 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CLD1N-0006bx-Jy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 20:56:50 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] What to send to Andrew next
References: <200410220516.i9M5GwFL007932@ccure.user-mode-linux.org>
	<200410221852.27232.blaisorblade_spam@yahoo.it>
	<200410222128.i9MLSmWY005910@ccure.user-mode-linux.org>
In-Reply-To: <200410222128.i9MLSmWY005910@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410230557.00754.blaisorblade_spam@yahoo.it>
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
Date: Sat, 23 Oct 2004 05:57:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 22 October 2004 23:28, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > 1) FOR INSTANCE, I sent the patch avoiding SIGPROF being touched by
> > change_signals(). Why did not you bother at it?
> > 2) copy_from_user_skas() does not make sense. When accessing the page
> > tables,  they would be happy to get some locking. If you want to take
> > a look to the  4G-4G patch from Ingo Molnar, which must do something
> > identical,
>
> Because I lost them, probably.  I'll go look for them.
>
> > Well, yes, but let's try to be fast on these. They are very good
> > patches and  fix also security problems.

> Yeah, syscall-security-* can go in now.  I want to see his test cases
> before pushing the signal delivery stuff though.

> > And why on x86_64 you do: #define NR_syscalls 1024

> > irq-bits - needed for mainline updates at least since -bk4, but not
> > complete.

> ?  That's removing code that's duplicated now in -mm but not mainline.

You refer to irq-bits here. No, it was merged at least since -bk4. Give a look 
at linux.bkbits.com - there is a nice web-interface for checking changelogs. 
Go to either 2.5 or 2.6 - they are the same repository.

> Not sure, that was in the patch I have left over from earlier this year,
> and I don't remember why it's there.
You refer to x86_64.
> Looks like we largely agree.  I'm not going to get to push stuff
> Andrew-ward until Sunday at least, so feel free to send stuff in
> beforehand.

I'm sending some trivial Kconfig changes just now - I'll be away on weekend.

We are also solving the problem on host 2.6.9 - the explaination seems to be 
that we should use PTRACE_KILL instead of just a SIGKILL. Is there any reason 
against that?

If you agree, I'll also merge some of these changes. You can also find, below, 
some issues I've not yet solved, but that I think I've tracked down. They are 
for later, however.

- rename the headers like  arch/um/kernel/skas/include/mmu.h and 
arch/um/kernel/tt/include/mmu.h to mmu-skas and mmu-tt, and update includes.
Including them with #include "../.. [....]" is ugly.

- This patch (apply by hand):

-static void winch_handler(int sig)
-{
-}
-
[...]
-       signal(SIGWINCH, winch_handler);
+       signal(SIGWINCH, SIG_IGN);

-

- not blocking SIGPROF in change_signals.

- I'm moving almost all code away from ubd_user.c to ubd_kern.c. This will 
allow using the new bio's, if needed, for the actual IO. Btw, a BIO contains 
multiple chunks of data; with AIO, we could even try to send them at once and 
see if performance increases (it should, but right now AIO is poorly 
supported).

- why do we disable kmalloc_ok in one piece of code?
I first didn't try answering and sent the patch allowing using kfree() in 
__wrap_free (the one about KMALLOC_START and KMALLOC_STOP, whose real aim was 
this).
While actually looking at this, the only explaination I found was that in that 
point we must be atomic, while kmalloc is not called atomically normally. So, 
we could simply add a global flag for using an atomic kmalloc, instead. 
However, the second way avoids any memory leak, but is still racy when UML is 
SMP. So a spinlock around those flags should be added.

- use the safe mconsole_proc() from Gerd Knorr. I'm just commenting out your 
version, until it's fixed. I understand your point, but until the proc 
command is broken, it's useless. Plus, try compiling HPPFS. It's so broken 
that it mistakes a <type> * for a <type>**, or something such. I have not 
fixed it because if it's so rotten, it will be better rewritten using 
externfs later. I marked it as BROKEN.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
