Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CaR1A-0007SO-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 19:55:32 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CaR19-0004DO-5I for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Dec 2004 19:55:32 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Merging some of your patches
References: <200411301945.07814.blaisorblade_spam@yahoo.it>
	<200411302003.08104.blaisorblade_spam@yahoo.it>
	<20041202114819.GA31396@bytesex>
In-Reply-To: <20041202114819.GA31396@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412040458.38846.blaisorblade_spam@yahoo.it>
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
Date: Sat, 4 Dec 2004 04:58:38 +0100
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Thursday 02 December 2004 12:48, Gerd Knorr wrote:
> > > In particular, from a general feeling, you should merge:
>
> Yep, I'm waiting for -rc3 as sync point for my next patchset, then go
> over the stuff, update if needed and submit what I think should go in.

> > uml-general-protection-fault - from the comment, it seems that if that
> > were a page fault, it would be fixable, while we always prefer to guess
> > it's a GFP and so to die horribly. If this is true, it cannot be merged.

> That triggeres if some application within uml tries to access I/O ports
> (which it can't obviously).
Only or also? Are you seeing specific behaviour improving here (i.e. hwclock 
or anything else, even X11)?

> The processor raises a GPF then, and uml 
> without that patch tries to handle it as page fault ...

If you mean the comment is outdated, it could be ok... but this *must* be in 
the comments of the patch.

I'm going to actually study what is happening there... 

from FAULTINFO implementation:

+                       { .is_write     = child->thread.error_code,

it seems that the error_code value is coded like the param of the i386 

asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code)

, where in fact I can read:
                tsk->thread.error_code = error_code | (address >= TASK_SIZE);

, but I see it generates a fault with trap_no == 14, i.e. page fault (are 
there no macros for that? This is absolutely ugly!), so I assume that:

asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)

which gives 13 as trap_no, has the same calling convention (enforced by the 
processor, probably).

for which I see:

 *      bit 2 == 0 means kernel, 1 means user-mode

i.e., the fault on the host has happened on kernel code. If you go to the 
trouble of explaining that it can't be a page fault, or that it can on 
special conditions (I guess it's difficult - a page fault in kernel code 
never gives a SIGSEGV IMHO) and that accessing I/O ports gives a fault in 
kernel code (which does not make sense for me) and explain all this in the 
comment, then the patch might me merged - and if it's not a workaround then 
PTRACE_EX_FAULTINFO disappears.

The rest of the message assumes PTRACE_EX_FAULTINFO might be still needed.

> > But what about adding a PTRACE_EX_FAULTINFO to SKAS3 and probe for it at
> > startup?

> Don't like that idea that much, given the fact that there is a
> incompatible change in the queue anyway where we can easily fix that.

> On the other hand skas4 has been vaporware only up to now.

This is the reason I don't want to wait for that to fix such things. Also, to 
do conservative coding, it's better to test this fixed API in SKAS3, so that 
we can identify any specific problem with it.

> At least I 
> havn't seen a single line of code, not even an announcement so far.

> Jeff, what is the current status?  Is there more than just the name?
> Design ideas?  Code?  If so, where?

Design ideas: tossed in various places, probably you want to look at the 
original Jeff / Linus discussion:

http://www.kerneltraffic.org/kernel-traffic/kt20030106_199.html#4

Also, Jeff explained the API multiple times over the ML - just search (it's 
just amazing to see how well Jeff managed to advertise SKAS4 as "The Next Big 
Thing(tm)!).

Code: you can see an idea bundled inside the x86_64 patch against 2.6.4, the 
way SKAS3 is bundled in the normal 2.4 UML patch. It is basically just a raw 
idea - if it is ever seriously discussed, I have tons of concerns on that 
code. From missing security hooks, to the fact that moving current->mm might 
not be enough (you need some state which is elsewhere, especially the 
personality flags when you run 32bit processes inside a native UML for AMD64, 
but possibly more - the problem also shows up if you want to merge SKAS3 and 
GrSecurity *properly*) to the lack of any locking around current->mm.

Now that I think to it, I may be wrong, but I've the doubt the sporadic panics 
I see about SKAS are simply race conditions on setting current->mm in 
PTRACE_SWITCH_MM:

+               child->mm = new;
+               child->active_mm = new;

is probably racy when you immediately switch on another process to the new 
task... normally, when returning from sys_ptrace, you probably hit a barrier 
somewhere, but imagine that the code gets preempted before hitting the 
barrier and another processor schedules the child... it will BUM somehow.

Also, the trick in switch_mm for the SMP case may not be enough... the per_cpu 
array of the active mm has a stale value, and if that array exists it 
probably is used, together with the stale value... **mumbling**

Status: Go to the diary page on the site and search SKAS4 - there's a recent 
entry about Jeff giving it a try.

> > Jeff Dike wanted to wait for SKAS4 to fix it, but as you see SKAS3 is
> > still under very active development.  Also, we get all the possible
> > compatibility we could, this way.

> Well, compatibility-wise there is no difference between skas4 and
> skas3new: To actually use that both host and uml machines must support
> that.

Yes, but while skas4 *is* not yet ready, if you want to fix this issue, this 
week we can get a new SKAS version.

And we are already supporting SYSEMU, so supporting such things is not new.

Supporting SKAS4 is much different, instead.

case 1: we need to copy over the SKAS folder and do changes all over.
In this case, I don't even know if we would anytime offer kernels working with 
boths... that could come as a bonus, if anyone finds the time to do such 
packaging, but I'm against merging something such in the kernel.

case 2: we can confine changes into a very few specific functions. It would 
seem the case from the idea itself, but if Jeff was getting problems with 
signals (!), it does not make sense

> With the exception that we'll have three skas versions to support 
> once skas4 is done: skas3old, skas3new + skas4.

> I'd prefeare to get skas4 out of the door quickly, and also see that
> one merged mainline.  That is more work _now_ of cource, but less
> maintainance work in the long run.  First, because we don't need
> skas3new then, and second because it can be merged mainline.

>   Gerd

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
