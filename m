Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCS6a-0002md-0j for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 16:41:44 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCS6Z-0007rx-FX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 16:41:43 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] Re: [uml-user] Network lags
In-Reply-To: <20040410164619.GA12830@osiris.silug.org>
Message-ID: <Pine.LNX.4.44.0404110135520.6583-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 11 Apr 2004 01:41:38 +0200 (CEST)
To: Steven Pritchard <steve@silug.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 10 Apr 2004, Steven Pritchard wrote:

> That behavior seems to be very dependent on the kernel you are
> running.  For example, a Red Hat 2.4.20 kernel seems to really, really
> want to swap:
> 
>              total       used       free     shared    buffers     cached
> Mem:       2064704    2053224      11480          0       9432    1212940
> -/+ buffers/cache:     830852    1233852
> Swap:      4176892    1597508    2579384
> 
> I would expect that system to be swapping, but not *nearly* that much.

The amount of swap used is not a good indication of how much your system
is swapping, only that there is/has been some memory pressure on your
system. What you need to monitor is the "si" column of vmstat 5 (or other
interval of choice).  so is not really relevant other than the I/O it
causes.

Why: The same page can exists both in memory and swap. The VM only 
discards the swap page when it no longer can be of any value. This is also 
why you need at least as much swap as you have memory for the swap to 
operate correctly.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
