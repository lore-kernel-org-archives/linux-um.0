Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCLcb-0006rO-WE for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 09:46:21 -0700
Received: from osiris.silug.org ([64.240.156.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BCLcb-0005tM-4Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 09:46:21 -0700
Received: from osiris.silug.org (localhost [127.0.0.1])
	by osiris.silug.org (8.12.10/8.12.5) with ESMTP id i3AGkJlx012919
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 10 Apr 2004 11:46:19 -0500
Received: (from steve@localhost)
	by osiris.silug.org (8.12.10/8.12.10/Submit) id i3AGkJME012917
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 11:46:19 -0500
From: Steven Pritchard <steve@silug.org>
Subject: Re: [uml-devel] Re: [uml-user] Network lags
Message-ID: <20040410164619.GA12830@osiris.silug.org>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
	<20040410151220.GB1297@vernix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410151220.GB1297@vernix.org>
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
Date: Sat, 10 Apr 2004 11:46:19 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 10, 2004 at 11:12:20AM -0400, Nicholas E. Walker wrote:
> However, this is sort of a misguided idea.  If you have enough memory,
> nothing will get swapped unless something in memory is so unused that it
> would be more efficient to swap it out and use the memory for cache.

That behavior seems to be very dependent on the kernel you are
running.  For example, a Red Hat 2.4.20 kernel seems to really, really
want to swap:

             total       used       free     shared    buffers     cached
Mem:       2064704    2053224      11480          0       9432    1212940
-/+ buffers/cache:     830852    1233852
Swap:      4176892    1597508    2579384

I would expect that system to be swapping, but not *nearly* that much.

Steve
-- 
Steven Pritchard - K&S Pritchard Enterprises, Inc.
Email: steve@kspei.com             http://www.kspei.com/
Phone: (618)398-7360               Mobile: (618)567-7320


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
