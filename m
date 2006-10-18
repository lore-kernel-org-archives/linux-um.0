Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GaGcG-0004fK-OS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 11:58:12 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GaGcG-0007Zt-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Oct 2006 11:58:12 -0700
Date: Wed, 18 Oct 2006 14:56:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061018185646.GD6566@ccure.user-mode-linux.org>
References: <451E9BAB.5030009@linuxbox.cz>
	<20061016150259.GA4381@ccure.user-mode-linux.org>
	<1161116486.2709.15.camel@nik-nb>
	<200610180139.55496.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610180139.55496.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host,
	x86_64	guest , problems with noprocmm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Nikola Ciprich <nikola.ciprich@linuxbox.cz>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Oct 18, 2006 at 01:39:55AM +0200, Blaisorblade wrote:
> Jeff, I remember vaguely a recent (>=2.6.17) patch about udelay fixing a 
> misbehaviour, would you please complete my recollection and verify the 
> interaction with this?

There were two problems.

One was that the declaration and definition of most arch
__const_udelay were mismatched.  It was simply a name mismatch, would
not cause miscompilation, but did cause conceptual problems:

arch/i386/lib/delay.c:
	inline void __const_udelay(unsigned long xloops)

include/asm-i386/delay.h:
	extern void __const_udelay(unsigned long usecs);

I'm also somewhat interested in how something that's defined inline in
a C file will be accessible to other files such that an extern
declaration would be needed.

The second problem (IIRC) was the mismatch you noted, although I
can't find that part of the patch any more.  I didn't understand the
magic constants in asm-i386/delay.h, and didn't see the comments in
arch/i386/lib/delay.c, which might have helped.

> This bug is here at least since 2.6.16.
> Suggested solution:
> 1) have _our own_ delay.h, to avoid depending on subarchs' changes
> 2) first avoid playing so complex tricks, then maybe copy their 
> implementation (note it is slightly different already among x86 and
> x86_64).

This sounds reasonable.

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
