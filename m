Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNI2t-0006Wq-K1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:42:59 -0700
Received: from pimout1-ext.prodigy.net ([207.115.63.77])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNI2s-0002fV-Do for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Oct 2004 14:42:59 -0700
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <20041028214242.GB2269@taniwha.stupidest.org>
References: <20041027053602.GB30735@taniwha.stupidest.org>
	<200410282104.30482.blaisorblade_spam@yahoo.it>
	<20041028193329.GF851@taniwha.stupidest.org>
	<200410282254.21944.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410282254.21944.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Why UML often does not build (was: Re: [PATCH] UML:
	Build fix for TT w/o SKAS)
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
Date: Thu, 28 Oct 2004 14:42:42 -0700
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>

On Thu, Oct 28, 2004 at 10:54:21PM +0200, Blaisorblade wrote:

> I'm not absolutely able, for instance, to understand the update for
> generic IRQs.

arch/um/kernel/irq.c is almost identical to the generic irq code
(ediff shows this nicely if that helps), the difference being
free_irq_by_irq_and_dev in free_irq --- which is why this was (nor
now) pushed into the UML drivers

i suspect the generated code before and after is almost identical

ideally this model needs a rework, but i don't see anyone having the
cycles to do this now so accommodating the generic-code is a sensible
solution for the interim

> For instance, Jeff rejected the mconsole-proc rewrite. So, I tried
> harder, then updated the patch to just #ifdef out his version, and
> was going to send it in.

it was later ACKed, you were cc'd on that email --- it's been merged

yes, that means we have merged code with slightly different semantics
than before --- but it also means it doesn't crash

you mentioned there is another solution to this --- i'd love to see
that before i rewrite this again to address Jeff's concern about the
requirement for /proc to be mounted (which is legitimate)

> 1) the Linux Kernel often breaks when using certain GCC versions or
> certain binutils, and has to be fixed.

this almost never happens these days, especially for i386 and amd64

i dont think i can recall it happenning in a big way for over a year
now

> But UML is a binary doing the most unusual things on the world
> around, so it must cope also with different versions of libc /
> binutils / host kernel.

UML also has to cope with ptrace changes and any semantics related to
this.  there has been some flux in this area recently and it's not
over yet sadly

UML is the most complicated ptrace-using code i think ive ever seen :)
and some of the code probably relies on semantics which are not well
defined so keeping up with those changes is important

part of that might be noticing when it breaks and screaming at roland,
i dont know

> 2) Uml is often not cared by mainline developers. It was merged in
> 2.6.9 and remained unworking for ages just because Linus ignored UML
> patches for ages.

was it submitted?  i really don't this the merge barrier is that high
from a maintainer for things like linux/arch/<foo> in most cases

the same is true for various drivers (it must be, so many of them are
horribly broken in places)

> And right now, if UML does not compile it's for the Ingo Molnar's
> hardirq patch and for a missed silly prototype change for a TTY api
> change (they fixed the UML user, ended up changing one UML function
> prototype, forgot to do a trivial update to one user.

UML has been described as 'abandonware' amongst other things, this
isn't completely unjustified.  Any efforts I think to help keep it
more inline with the rest of the kernel to change this perception I
think are great --- if we can get enough cleanups in, we might even be
able to get more of the mainline people buildling and checking against
UML so we get let breakage in the future.

I think to do this we should first fix some of the bogons we have
before adding new code and features.

> 4) We are too few. The currently active developers (and I mean only
> the one which this month have being working on it) are:

if we can get things more inline (fixes, track mainline, dont add new
features just yet) i think we can get more people to help out

right now it's too hard (too much effort) to most people to deal with

anyhow, i think enough has been said as we are mostly in voilent
agreement, if we can keep poking away at this i think we have a pretty
good shot and making UML less of a second-class citizen


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
