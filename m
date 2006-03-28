Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FOMJu-0007fY-AQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:05:46 -0800
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FOMJs-0003w3-Ml
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Mar 2006 14:05:46 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <dvv6ir$ajn$1@sea.gmane.org>
	<200603280030.05911.blaisorblade@yahoo.it>
	<20060328200219.GC21540@ccure.user-mode-linux.org>
In-Reply-To: <20060328200219.GC21540@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603290005.38074.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [uml-user] Re: (implementation idea) Re: uml and
	nonstandard memory splits?
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
Date: Wed, 29 Mar 2006 00:05:37 +0200
To: user-mode-linux-user@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Jason Lunz <lunz@falooley.org>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 28 March 2006 22:02, Jeff Dike wrote:
> On Mon, Mar 27, 2006 at 11:30:05PM +0100, Blaisorblade wrote:
> > That is problem #1, and exists; but when answering I thought to problem
> > #2, i.e. that the stub code currently hardcodes the location of the stub
> > data page, and that this must be fixed; I didn't notice that we must
> > first put the stubs somewhere.

> I see - you're one problem ahead of me.

> I'm wondering if we can play some linker tricks for this.  Stick a
> word of data on the code page and put the data page address in it.
> Then the stub just reads that in order to get the data.

After you place the stubs somewhere, you can pass them the address in a 
register. Indeed, we already do that since the stack in located inside the 
data page, so you simply need to round that (hardcoding at compile-time the 
data size page, but we already do that).

Passing that in a memory word doesn't work unless you use Instruction Pointer 
relative addressing, only available (to my knowledge) in x86_64 as 
RIP-relative addressing.

> That will work, too, but (as you point
> out) requires a register.

Not a big problem - you can recalculate it at will so that's not a real 
problem as long as we can recalculate if without problems (which could 
probably require switching to full assembler).

> > > Another approach is to start with the current top of stack

> Hmmmm :-)  Maybe easier said than done.  I was thinking about figuring
> that out as basically the first thing in main, but I can think of
> reasons that wouldn't be robust.

Can we remove the assumption the pages are at the absolute top of the address 
space?

The guest process doesn't risk unmapping them because we stop it from that, 
with gate_vma's for instance, even if I know that's a work in progress from 
Bodo's comments (not yet begun).

We could block mmapping over the used address, and we must do that anyway - 
SKAS3 indeed would fail on 2G/2G and such hosts exactly because we don't do 
that and our mmap() returns addresses beyond host TASK_SIZE.

However, this doesn't happen because we already implement the "top of the 
stack" detection technique in arch/um/kernel/skas/mem.c. So we've well-tested 
code doing this, even if maybe at times suboptimal.

But how much does stack randomization changes? That's the only remaining 
doubt.
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
