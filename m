Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GZTjT-0002hR-66 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 07:46:23 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GZTjN-0000wf-GW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Oct 2006 07:46:22 -0700
Date: Mon, 16 Oct 2006 10:44:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061016144453.GB4350@ccure.user-mode-linux.org>
References: <452C29F2.8050908@theshore.net>
	<20061013200747.GB5517@ccure.user-mode-linux.org>
	<200610140243.00086.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200610140243.00086.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x92c00000, ip 0x80bcead
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
Cc: user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

On Sat, Oct 14, 2006 at 02:42:59AM +0200, Blaisorblade wrote:
> > > Kernel panic - not syncing: Kernel mode fault at addr 0x92c00000, ip
> > > 0x80bcead
> Jeff, are these addresses normal? They tell that the binary is a statically 
> linked one - but what is the memory layout? Chris, can you post 
> cat /proc/<pid>/maps on a running instance of that kernel, together with host 
> and guest config (the guest's one is contained there, I know, but I don't 
> have the time to extract).

I'm not sure.  I've never trusted the numbers coming from that panic
message (which hurts debugging, I know).  I don't believe the fault
address, and the IP doesn't match anything in the symbol table, so I
don't believe that either.

> I.e. all the rest are bogus functions?

No.  Above the skb_checksum frame, there are lots of occurrences of
dst_output, which is a function pointer being passed down the stack.
What remains looks like the remnants of old stacks.

Between csum_partial and skb_checksum, there's a big frame (and I
don't know what's causing that) with what looks like old stack in it.

> There are automated solutions for this - compiling with frame pointers allows
> correct backtracing with a runtime penalty but is implemented; however, we 
> could reuse (not copy, please, we cannot maintain it) the x86 DWARF unwinder 
> (instead of using frame pointer and to slow down fast paths, additional 
> out-of-line debug info are used when the stack trace is output) - but we 
> should implement this latter one. Jeff, can you take a look at it?

Yup, that sounds like a good idea.

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
