Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHo32-0005wE-7r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 13:49:32 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GHo2y-0006D7-OG
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 13:49:32 -0700
Date: Mon, 28 Aug 2006 13:49:15 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060828134915.f7787422.akpm@osdl.org>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Mime-Version: 1.0
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>, Val Henson <val.henson@intel.com>, Hugh Dickins <hugh@veritas.com>

On Sat, 26 Aug 2006 19:33:35 +0200
Blaisorblade <blaisorblade@yahoo.it> wrote:

> Again, about 4 month since last time (for lack of time) I'm sending for final 
> review and for inclusion into -mm protection support for remap_file_pages (in 
> short "RFP prot support"), i.e. setting per-pte protections (beyond file 
> offset) through this syscall.

This all looks a bit too fresh and TODO-infested for me to put it in -mm at
this time.

I could toss them in to get some testing underway, but that makes life
complex for other ongoing MM work.  (And there's a _lot_ of that - I
presently have >180 separate patches which alter ./mm/*).

Also, it looks like another round of detailed review is needed before this
work will really start to settle into its final form.

So..   I'll await version 5, sorry.   Please persist.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
