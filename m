Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAuh2-0001f1-2R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 10:53:32 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DAugx-0000TL-6A for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Mar 2005 10:53:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Partial fix! - Was: Re: [BUG report] UML
	linux-2.6 latest BK doesn't compile
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200503072044.49206.blaisorblade@yahoo.it>
	<200503080010.j280ABbc005264@ccure.user-mode-linux.org>
In-Reply-To: <200503080010.j280ABbc005264@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503132106.35599.blaisorblade@yahoo.it>
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
Date: Sun, 13 Mar 2005 21:06:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>

Ok, I think I finally solved this problem.

A note for Jeff: I forgot to send this email and complained to you because you 
didn't answer... Sorry Jeff.

However, I explained what I say here to him in chat and we agreed on the fix.

I'm sending this anyway... and I'm attaching the correct fix we discussed.

On Tuesday 08 March 2005 01:10, Jeff Dike wrote:
> blaisorblade@yahoo.it said:
> > a) wrong because you say __GNUC_PATCHLEVEL__ > 4 rather than >=

> Correct, this is now fixed.

> > b) wrong because for he the link failed on __bb_init_func at the
> > beginning. So  in the case you need to export BOTH symbols.

> Incorrect, the link failure was caused by trying to export __bb_init_func,
> which makes a reference to it, which was subsequently not being resolved.
No, the link failure was when linking the first object together in the final 
file.

The symbol was referred to by the wrappers inserted by GCC for gprof / 
gcov, not by the symbol exporting.

Quoting Anton:
> Yes.  I finally found a way to get it to compile.  Compiling without TT
> mode and WITHOUT static build it still fails with the same problem
> (__bb_init_func problem I already reported).  But compiling without TT
> but WITH static build the __bb_init_func problem goes away but instead I
> get a __gcov_init missing symbol in my modules.

And it was fixed when linking statically, as you see (because the symbol is 
not defined in dynamic libraries - don't know if this is a bug of glibc, I 
hope not).

What was needed was the addition of another EXPORT_SYMBOL, but it couldn't be 
added for everybody because it causes the build to fail for old compilers 
which don't export the symbol.

And "old compilers" include normal gcc 3.3.4 (I verified this on my Gentoo 
system).

Also, maybe adding a dependency on static linking for GCOV is needed, maybe.

After some successful testing (maybe I didn't test all cases), however, 
something strange happened: the build started failing because now GCC 
requires the GCOV options (-fprofile-arcs -ftest-coverage) even during 
linking (because the gcov helper functions are now in a separate library). I 
said "strange" because the same build succeeded with gcc 3.3.4, and I didn't 
understand the difference at first.

This required two changes:
- excluding the profiling options from the mk_* utilities.
- adding the GCOV options to linking (this is even documented now). I've 
retested that this wasn't needed with gcc 3.3.4 (and I guess older ones).

Finally, I got an unresolved symbol on __bb_fork_func, and I wasn't able to 
solve this (is it maybe a bug in libc or whatever? I don't know).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
