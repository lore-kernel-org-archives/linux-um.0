Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcrYx-00032T-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 12:40:27 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CcrYv-0004y7-Sb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 12:40:27 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: SKAS4 future and present (was: Re: [uml-devel] Merging some of your
	patches)
References: <200411301945.07814.blaisorblade_spam@yahoo.it>
	<200412040458.38846.blaisorblade_spam@yahoo.it>
	<20041207120349.GC21667@bytesex>
In-Reply-To: <20041207120349.GC21667@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412101951.14321.blaisorblade_spam@yahoo.it>
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
Date: Fri, 10 Dec 2004 19:51:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>

On Tuesday 07 December 2004 13:03, Gerd Knorr wrote:
> > > > uml-general-protection-fault - from the comment, it seems that if
> > > > that were a page fault, it would be fixable, while we always prefer
> > > > to guess it's a GFP and so to die horribly. If this is true, it
> > > > cannot be merged.
> > >
> > > That triggeres if some application within uml tries to access I/O ports
> > > (which it can't obviously).

> > Only or also? Are you seeing specific behaviour improving here (i.e.
> > hwclock or anything else, even X11)?

> hwinfo (suses hardware detection tool) stops hanging, especially the
> vmware test (which tries to access one of the magic ports used for
> communication with vmware).  It rarely shows up otherwise, usually the
> apps first try to get permissions via ioperm(), which fails.  They
> usualy bail out then because of that and don't even try to access a I/O
> port.

Ok, thanks...

> > > The processor raises a GPF then, and uml
> > > without that patch tries to handle it as page fault ...

> > If you mean the comment is outdated, it could be ok... but this *must* be
> > in the comments of the patch.

> Maybe it's just badly explained.

Possibly... the problem is that the comment says it *may* work while I'm 
trying to make sure it *does* work always or to fix it...

> It's also some time ago I wrote that 
> and I never looked at it again.

> >  *      bit 2 == 0 means kernel, 1 means user-mode
> >
> > i.e., the fault on the host has happened on kernel code. If you go to the
> > trouble of explaining that it can't be a page fault, or that it can on
> > special conditions (I guess it's difficult - a page fault in kernel code
> > never gives a SIGSEGV IMHO) and that accessing I/O ports gives a fault in
> > kernel code (which does not make sense for me)

> IIRC it *looks* like a kernel mode page fault (because the info passed
> on via FAULTINFO is incomplete), but it isn't one.

Well, I actually checked the value being passed by one of those functions; 
now, they seem to be registered as the processor trap handler, which means 
that checking the Intel manual would give the real API for the general case 
(bits may have different meanings for GPF traps) ...

> As a kernel mode 
> page fault shouldn't happen I used that to detect the GPF case.

> Seems 
> to do fine normally, maybe it blows up if a real kernel mode page fault
> happens due to a uml kernel bug.

Yes, if the kernel gets a page fault, the usermode process shouldn't get a 
SIGSEGV... 

However, we must make really sure that it's this way...

> > The rest of the message assumes PTRACE_EX_FAULTINFO might be still
> > needed.

> Explicitly passing the fault info certainly is the cleaner solution.
Yes, it may be done soon.
> > > On the other hand skas4 has been vaporware only up to now.
> >
> > This is the reason I don't want to wait for that to fix such things.

> I also don't want to wait one more year.  But if there is a chance to
> get skas4 work within a more reasonable time frame I'd prefeare that
> route.

When I get to work on Bodo's improvements to SYSEMU (on which I have some 
doubts I already posted) I'll also try adding that... UML must already handle 
some others similar "API-extensions", including probably 
PTRACE_SYSEMU_SINGLESTEP (or another kind of idea).

> > Also, Jeff explained the API multiple times over the ML - just search
> > (it's just amazing to see how well Jeff managed to advertise SKAS4 as
> > "The Next Big Thing(tm)!).

> Hmm, well, a google search wasn't that successful, althrough a few
> mailing list hist where in there (so it's actually indexed by google).

> > Code: you can see an idea bundled inside the x86_64 patch against 2.6.4,
> > the way SKAS3 is bundled in the normal 2.4 UML patch. It is basically
> > just a raw idea - if it is ever seriously discussed,

> This never being discussed is the first problem.

Yes, but I never bothered *really* asking Jeff to publish it - that's just the 
habits one can get used, as doing a solo-development... even waiting for the 
patch to be ready and polished up is not wise, when there are multiple 
developers which might like it. "Release often - release earlier" is 
important.

Also, while in that discussion, Linus proposed that API, it does not mean that 
if we implement that exact API, it gets accepted by everyone without 
concerns. We should get into this mindview...

> > I have tons of concerns on that code. From missing security hooks, to
> > the fact that moving current->mm might not be enough (you need some
> > state which is elsewhere, especially the personality flags when you
> > run 32bit processes inside a native UML for AMD64, but possibly more -
> > the problem also shows up if you want to merge SKAS3 and GrSecurity
> > *properly*) to the lack of any locking around current->mm.

> skas3 sufferes from that as well, right?

Yes, both of not saving current->flags and the missing locking around 
current->mm.

I think that a wmb(); call after setting current->mm may be enough - we get 
non-reproducible crashes and somebody posts the backtraces, but never figured 
out what's happening. In fact, if you think at it, it's difficult that no 
memory flushing is done when doing a context switch... also to get an Oops, 
you probably need to have child->mm to point at a freed and overwritten 
mm_struct...

However, since I don't know which access rules are used in the kernel onto 
current->mm (everything is written by assuming that current->mm won't 
change).

Probably, in SuSE there is someone who knows better (don't know if Andrea 
Arcangeli will ever care, but it would be nice)... since you include SKAS 
in your kernel, getting it reliable is interesting also for you all in SuSE.

See my other mail, regarding the outdated SKAS version in SuSE 9.1 and its 
bugs.

> > Status: Go to the diary page on the site and search SKAS4 - there's a
> > recent entry about Jeff giving it a try.

> Yep, I've seen that.  No url to the current code through so one could
> help somehow by reviewing / testing / debugging stuff.

> > Yes, but while skas4 *is* not yet ready, if you want to fix this issue,
> > this week we can get a new SKAS version.

> > And we are already supporting SYSEMU, so supporting such things is not
> > new.

> sysemu is independant from skas (and can also used in tt mode).
Yes, this support is merged somewhere (both -bb and -bk), but disabled for now 
in -bb just in case some other problem pops up with it...

> Would 
> be nice to have these as separated patches btw, so we could try to get
> sysemu merged mainline.

Yes, they are splitout on my disk, never found time to package and describe 
it. However, the -bb patchset offers exactly that! I put those patches at the 
beginning of the UML tree, to notice early any conflict between SKAS+SYSEMU 
and UML.

I've also posted once the SYSEMU fixes to LKML, but they didn't get much 
attention. Maybe they looked like a random idea for ptrace() without much 
uses (I marketed those patches as generally useful, rather than being about 
UML); also I didn't CC Roland McGrath, the ptrace maintainer.

> > case 2: we can confine changes into a very few specific functions. It
> > would seem the case from the idea itself, but if Jeff was getting
> > problems with signals (!), it does not make sense

> Not clear yet why according to the diary, but without patches it's hard
> to help getting skas4 out of the door by looking at these issues ...
We have more urgent stuff to get fixed right now...
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
