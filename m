Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKhM8-0003pC-CT for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 11:08:08 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CKhM5-0007M5-Ji for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 11:08:08 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel panic: check_ptrace : child exited with status
	0x100
References: <200410081159.i98Bxgr03954@trolli.pdb.fsc.net>
	<200410142033.06629.blaisorblade_spam@yahoo.it>
	<417699B2.6090909@fujitsu-siemens.com>
In-Reply-To: <417699B2.6090909@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410212006.05008.blaisorblade_spam@yahoo.it>
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
Date: Thu, 21 Oct 2004 20:06:05 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, jdike@addtoit.com, "Christopher S. Aker" <caker@theshore.net>

On Wednesday 20 October 2004 19:00, Bodo Stroesser wrote:
> BlaisorBlade wrote:
> > Yes, I confirm the patch I sent in my previous email for the host. I
> > still need to test that, but I'll do this soon. It's reattached as
> > "fix-sysemu-when-changing-state.patch".

> OK. Now I've had time to test with sysemu. But unfortunately the patch for
> the 2.6 host isn't enough! It still crashes if sysemu is switched off
> dynamically via /proc/sysemu.
Yes, I had seen this, but had not found a clue, even if I came across the 
problematic code. THANKS FOR FIXING THIS!!!!! YU-UH!

> The problem is in arch/i386/kernel/entry.S. The latest host-patch v6
> inhibits the syscall-handler to be called, but does not prevent
> do_syscall_trace to be called after this for syscall completion
> interception. The appended patch fixes this. It reuses the TIF_SINGLESTEP
> flag to remember "we come from PTRACE_SYSEMU and now are in
> PTRACE_SYSCALL", since the flag is unused in the depicted situation.

> Feel free to change it, if you see the need to use  an other or a new
> defined flag for this.

To use a new one you must be careful - there is interest in this using a 
little flag number. When you get more than 7 flags, you must test for them 
with "testw" instead of "testb". And if this happens in the syscall fast 
path, people on LKML start benchmarking the performance loss (I've actually 
read something such on kerneltrap.org). Well, at least on the syscall fast 
path. If the test is done only under ptrace, then it's not a problem.

Btw, the problem IMHO is not actually reading one more byte. The first SYSEMU 
patch, instead, added one more conditional jump to the fast-path. Which is 
bad, as noted by Jeff - one conditional jump can cost tens of cycles IIRC 
(I'm not completely sure, but if branch predition fails, the processor must 
empty its pipelines - even more costly on Pentium4).

So, I'll maybe add another flag.

> The patch is tested, AFAICS, it works fine, i.e. sysemu can be switched on
> and off dynamically without crash.

> For the 2.4 host, this seems to be not relevant. But I could read the
> source only. Does anyone know, whether sysemu on/off works on host 2.4?

Yes, it works. In fact, I developed that with 2.4 hosts. I understand the 
difference.

I'm going to take a look at this and integrate it - at least a comment near 
the TIF_* definition for this trick is warranted, if not something cleaner. 
I'd prefer to make it like 2.4 hosts, where the SYSCALL flag is not tested at 
all in the SYSEMU case. I'll try to do this.

> --- linux-2.6.7-old/arch/i386/kernel/ptrace.c	2004-10-20 16:57:25.148861788
> +0200 +++ linux-2.6.7/arch/i386/kernel/ptrace.c	2004-10-20
> 17:08:47.722062593 +0200 @@ -598,6 +598,16 @@
>
>   	if (!test_thread_flag(TIF_SYSCALL_TRACE) && !is_sysemu)
>   		return 0;
> +	/* We can detect the case of coming from PTRACE_SYSEMU and now
> +	 * running with PTRACE_SYSCALL, by TIF_SINGLESTEP being set
> +	 * additionally.
> +	 * If so let's reset the flag and return without action.
> +	 */
> +	if (test_thread_flag(TIF_SINGLESTEP) &&
> +	    test_thread_flag(TIF_SYSCALL_TRACE)) {
> +		clear_thread_flag(TIF_SINGLESTEP);
> +		return 0;
> +	}
>   	if (!(current->ptrace & PT_PTRACED))
>   		return 0;
>   	/* the 0x80 provides a way for the tracing parent to distinguish

> @@ -605,6 +615,15 @@
>   	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
>   				 ? 0x80 : 0));
This may be the raw 2.6.9 source - but currently (2.6.9-bk4) the source is 
this
       ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
                                 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 
0));

I think that the second version of your patch is safe against this, but I'm 
not looking at this in detail for now (no time, sorry).

> +	/* If we came here with PTRACE_SYSEMU and now continue with
> +	 * PTRACE_SYSCALL, entry.S used to intercept the syscall return. But it
> +	 * shouldn't!
> +	 * So we additionally use TIF_SINGLESTEP, which is always unused in this
> +	 * special case, to remember, we came from SYSEMU.
> +	 */
> +	if (is_sysemu && test_thread_flag(TIF_SYSCALL_TRACE))
> +		set_thread_flag(TIF_SINGLESTEP);

Ok, this is run when issuing the first tracing just after switching off 
SYSEMU.
>   	/*
>   	 * this isn't the same as continuing with a signal, but it will do
>   	 * for normal use.  strace only continues with a signal if the

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
