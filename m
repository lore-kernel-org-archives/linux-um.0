Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BCK9g-0008Qw-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 08:12:24 -0700
Received: from covered.with.vernix.org ([64.209.120.201] ident=qmailr)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BCK9g-0008Py-Ac for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Apr 2004 08:12:24 -0700
From: "Nicholas E. Walker" <new@vernix.org>
Subject: Re: [uml-devel] Re: [uml-user] Network lags
Message-ID: <20040410151220.GB1297@vernix.org>
References: <Pine.LNX.4.59.9.0404091209570.10714@hathi.bw-networx.net>
	<185d01c41e23$5996cc00$2000000a@schlepptopp>
	<189201c41e30$d434cc70$2000000a@schlepptopp>
	<200404091626.i39GQqsf002414@ccure.user-mode-linux.org>
	<c58kbu$el1$1@sea.gmane.org>
	<20040410140840.GB5782@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040410140840.GB5782@ccure.user-mode-linux.org>
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
Date: Sat, 10 Apr 2004 11:12:20 -0400
To: skoehler@upb.de
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Apr 10, 2004 at 10:08:40AM -0400, Jeff Dike wrote:
> On Sat, Apr 10, 2004 at 01:06:51PM +0200, Sven K?hler wrote:
> > is there any way for the UML-kernel to allocate a non-swappable 
> > memore-region in the host's memory? this could be especially important 
> > for dedicated host-machines that are only to run UMLs.
> 
> Yes, but there's no way I'm going to support anything like that.
> 
> What I am going to do is make it possible to manage the host's memory
> so that it doesn't swap, and the UMLs in effect are mlocked.

You could try mounting ramfs on /tmp.  ramfs is similar to tmpfs, except
that the contents cannot be swapped.  It doesn't usefully report
used/free space, so it is somewhat problematic to have it mounted on
/tmp unless you're just running UML kernels.

However, this is sort of a misguided idea.  If you have enough memory,
nothing will get swapped unless something in memory is so unused that it
would be more efficient to swap it out and use the memory for cache.
Locking the UML memory space into real memory isn't going to give you
any more memory, and increases the change that the OOM killer is going
to come out and play.  So do the reasonable thing and get more memory or
run fewer UMLs.

Nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
