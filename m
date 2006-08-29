Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHysE-0006lK-Ow for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 01:23:06 -0700
Received: from web25224.mail.ukl.yahoo.com ([217.146.176.210])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GHysA-00066w-Cg
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Aug 2006 01:23:06 -0700
Message-ID: <20060829082246.92663.qmail@web25224.mail.ukl.yahoo.com>
Date: Tue, 29 Aug 2006 10:22:45 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20060828134915.f7787422.akpm@osdl.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH RFP-V4 00/13] remap_file_pages protection
	support - 4th attempt
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
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Val Henson <val.henson@intel.com>, Hugh Dickins <hugh@veritas.com>

Andrew Morton <akpm@osdl.org> ha scritto: 

> On Sat, 26 Aug 2006 19:33:35 +0200
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> 
> > Again, about 4 month since last time (for lack of time) I'm
> sending for final 
> > review and for inclusion into -mm protection support for
> remap_file_pages (in 
> > short "RFP prot support"), i.e. setting per-pte protections
> (beyond file 
> > offset) through this syscall.

> This all looks a bit too fresh and TODO-infested for me to put it
> in -mm at
> this time.

It is possible, subsequent rounds of review should be near to each
other, but calling the code "new" is maybe exaggerate. I do not
remember all these TODOs but I may forget (and I don't have my box
right now, so I can't check).

> I could toss them in to get some testing underway, but that makes
> life
> complex for other ongoing MM work.  (And there's a _lot_ of that -
> I
> presently have >180 separate patches which alter ./mm/*).

That's fine. If this can help I could try to base next version
against -mm.

> Also, it looks like another round of detailed review is needed
> before this
> work will really start to settle into its final form.

That's ok, I prefer reviews to testing right now. Almost all but 1
patch (which is marked) is unit tested on i386, x86_64 and uml (but
if I don't have a multithreaded concurrent fault tester), so it's
time to catch remaining bugs by review.

> So..   I'll await version 5, sorry.   Please persist.

I'll try. I just hope we'll not have it next summer (I know it's my
problem, I'm not complaining on you).

Thanks!
Bye
--
Paolo Giarrusso 

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
