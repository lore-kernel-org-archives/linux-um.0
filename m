Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNHPC-0004D6-E9 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:01:58 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CNHPB-0003Kz-Gt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:01:58 -0700
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <20041027053602.GB30735@taniwha.stupidest.org>
	<200410282104.30482.blaisorblade_spam@yahoo.it>
	<20041028193329.GF851@taniwha.stupidest.org>
In-Reply-To: <20041028193329.GF851@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410282254.21944.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Why UML often does not build (was: Re: [PATCH] UML: Build
	fix for TT w/o SKAS)
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
Date: Thu, 28 Oct 2004 22:54:21 +0200
To: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

On Thursday 28 October 2004 21:33, Chris Wedgwood wrote:
> On Thu, Oct 28, 2004 at 09:04:30PM +0200, Blaisorblade wrote:
> > Hmm, this is true for some of them, not for other ones (mostly
> > fixups, but some wrong).

> ive been sending patches out for ages and they are getting nowhere.
"Not getting an answer" does not mean "getting nowhere". I'm not absolutely 
able, for instance, to understand the update for generic IRQs. I've seen the 
"compile only" fixes from Jeff. And they were "compile-only". But 
understanding the other changes from you is too difficult for me.

About Jeff, I still keep CC'ing him every time, but as he has admitted 
privately, he does not have the time to answer detailedly to each patch. 
Since I'm here from some time, I'm now using my own judgement on some little 
things (i.e. little compile-only fixes, or when a patch is being rejected for 
questionable reasons, or when it is reportedly safe).

I don't try to touch the real UML core without getting a review from Jeff, and 
anyone having a clue on what I'm doing is welcome.

> if people have better fixes, these have been weeks (in some cases
> months) to get them in

For instance, Jeff rejected the mconsole-proc rewrite. So, I tried harder, 
then updated the patch to just #ifdef out his version, and was going to send 
it in.

However, you are not entirely wrong. Jeff does not scale enough to the rate of 
kernel changes, and not even I can (I'm only a 1st year university student; 
luckily they have not yet started teaching anything new).

> > However, always CC both the -devel list (my request) and the LKML
> > (Andrew's request to me some time ago) when sending UML patches.

> i admit i've missed -devel most of the time,  i said ill do that from
> now on

> the fact remains, people have fixes that are weeks old or more and if
> you dont submit them to get them merged, then please let another
> potential suitable fix go in for now

> UML often doesn't build and less often runs correctly --- it probably
> one of the worst architectures for this in a sense (i don't know about
> the obscure stuff, i bet those break too --- but nobody uses them
> which isn't the case for UML)

Well, this is true. There are mainly these reasons:

1) the Linux Kernel often breaks when using certain GCC versions or certain 
binutils, and has to be fixed.

But UML is a binary doing the most unusual things on the world around, so it 
must cope also with different versions of libc / binutils / host kernel.

2) Uml is often not cared by mainline developers. It was merged in 2.6.9 and 
remained unworking for ages just because Linus ignored UML patches for ages. 
And right now, if UML does not compile it's for the Ingo Molnar's hardirq 
patch and for a missed silly prototype change for a TTY api change (they 
fixed the UML user, ended up changing one UML function prototype, forgot to 
do a trivial update to one user. One missed "grep" invocation, in fact).

3) Uml *is* strange. The kernel has his own linking script? Uml must have a 
merged version of the userspace one from binutils and of the kernel one.

Since it must remap its .text section away under his back, it has to copy the 
kernel image and remap the data with one one-shot function, which is 
statically linked - so you end up with symbol clashes on some glibc using 
NPTL, for trivial reasons - and so on.

4) We are too few. The currently active developers (and I mean only the one 
which this month have being working on it) are:

- Bodo Stroesser - he came in just now, but he's doing a tremendous work on 
getting SYSEMU working well.

- you, Chris

- Gerd Knorr, the Suse UML packager and maintainer.

- I and Jeff, for various other stuff.

The number nearly doubles if you just include work done before this summer, 
with Henrik Normstrod, M.A. Young and Ingo Molnar coming here. But that's the 
fact.

I.e., if after 2.6.9-rc4 for any reason I did not send the fixes (like being 
overloaded or away from the net), Jeff probably would have sent them (he was 
just about doing it). But let's say he was a bit away from the net, or he 
forgot some build fixes, even 2.6.9 wouldn't have worked for UML.

That said, with mainline inclusion UML is getting more work on from mainline. 
At least, most API changes are handled by the ones who submit them.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
