Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbeKQ-0005Lq-N8 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 04:20:26 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbeKL-0005OY-8D
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 04:20:24 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Merging some of your patches
Message-ID: <20041207120349.GC21667@bytesex>
References: <200411301945.07814.blaisorblade_spam@yahoo.it>
	<200411302003.08104.blaisorblade_spam@yahoo.it>
	<20041202114819.GA31396@bytesex>
	<200412040458.38846.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412040458.38846.blaisorblade_spam@yahoo.it>
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
Date: Tue, 7 Dec 2004 13:03:49 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> > > uml-general-protection-fault - from the comment, it seems that if that
> > > were a page fault, it would be fixable, while we always prefer to guess
> > > it's a GFP and so to die horribly. If this is true, it cannot be merged.
> 
> > That triggeres if some application within uml tries to access I/O ports
> > (which it can't obviously).
> Only or also? Are you seeing specific behaviour improving here (i.e. hwclock 
> or anything else, even X11)?

hwinfo (suses hardware detection tool) stops hanging, especially the
vmware test (which tries to access one of the magic ports used for
communication with vmware).  It rarely shows up otherwise, usually the
apps first try to get permissions via ioperm(), which fails.  They
usualy bail out then because of that and don't even try to access a I/O
port.

> > The processor raises a GPF then, and uml 
> > without that patch tries to handle it as page fault ...
> 
> If you mean the comment is outdated, it could be ok... but this *must* be in 
> the comments of the patch.

Maybe it's just badly explained.  It's also some time ago I wrote that
and I never looked at it again.

>  *      bit 2 == 0 means kernel, 1 means user-mode
> 
> i.e., the fault on the host has happened on kernel code. If you go to the 
> trouble of explaining that it can't be a page fault, or that it can on 
> special conditions (I guess it's difficult - a page fault in kernel code 
> never gives a SIGSEGV IMHO) and that accessing I/O ports gives a fault in 
> kernel code (which does not make sense for me)

IIRC it *looks* like a kernel mode page fault (because the info passed
on via FAULTINFO is incomplete), but it isn't one.  As a kernel mode
page fault shouldn't happen I used that to detect the GPF case.  Seems
to do fine normally, maybe it blows up if a real kernel mode page fault
happens due to a uml kernel bug.

> The rest of the message assumes PTRACE_EX_FAULTINFO might be still needed.

Explicitly passing the fault info certainly is the cleaner solution.

> > On the other hand skas4 has been vaporware only up to now.
> 
> This is the reason I don't want to wait for that to fix such things.

I also don't want to wait one more year.  But if there is a chance to
get skas4 work within a more reasonable time frame I'd prefeare that
route.

> http://www.kerneltraffic.org/kernel-traffic/kt20030106_199.html#4

I remember that discussion ;)

> Also, Jeff explained the API multiple times over the ML - just search (it's 
> just amazing to see how well Jeff managed to advertise SKAS4 as "The Next Big 
> Thing(tm)!).

Hmm, well, a google search wasn't that successful, althrough a few
mailing list hist where in there (so it's actually indexed by google).

> Code: you can see an idea bundled inside the x86_64 patch against 2.6.4, the 
> way SKAS3 is bundled in the normal 2.4 UML patch. It is basically just a raw 
> idea - if it is ever seriously discussed,

This never being discussed is the first problem.

> I have tons of concerns on that code. From missing security hooks, to
> the fact that moving current->mm might not be enough (you need some
> state which is elsewhere, especially the personality flags when you
> run 32bit processes inside a native UML for AMD64, but possibly more -
> the problem also shows up if you want to merge SKAS3 and GrSecurity
> *properly*) to the lack of any locking around current->mm.

skas3 sufferes from that as well, right?

> Status: Go to the diary page on the site and search SKAS4 - there's a recent 
> entry about Jeff giving it a try.

Yep, I've seen that.  No url to the current code through so one could
help somehow by reviewing / testing / debugging stuff.

> Yes, but while skas4 *is* not yet ready, if you want to fix this issue, this 
> week we can get a new SKAS version.
> 
> And we are already supporting SYSEMU, so supporting such things is not new.

sysemu is independant from skas (and can also used in tt mode).  Would
be nice to have these as separated patches btw, so we could try to get
sysemu merged mainline.

> case 2: we can confine changes into a very few specific functions. It would 
> seem the case from the idea itself, but if Jeff was getting problems with 
> signals (!), it does not make sense

Not clear yet why according to the diary, but without patches it's hard
to help getting skas4 out of the door by looking at these issues ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
