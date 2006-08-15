Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCpRF-0007jZ-Ew for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 20:17:58 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GCpRC-0006ll-Ve
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 20:17:57 -0700
Date: Mon, 14 Aug 2006 23:17:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060815031733.GA7089@ccure.user-mode-linux.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
	<20060810020922.GO6908@waste.org>
	<20060810042216.GA7754@ccure.user-mode-linux.org>
	<20060810164548.GS6908@waste.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060810164548.GS6908@waste.org>
Subject: Re: [uml-devel] [PATCH] UML - support checkstack
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
To: Matt Mackall <mpm@selenic.com>
Cc: akpm@osdl.org, Joern Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Aug 10, 2006 at 11:45:48AM -0500, Matt Mackall wrote:
> > SUBARCH has a different meaning here.  For UML, it's the underlying,
> > host, architecture, not a variant architecture like Voyager.
> 
> Right, so it sounds like this breaks Voyager. Which I think means we
> ought to pass ARCH and SUBARCH and do the right thing inside
> checkstack.

There is no use of the symbol SUBARCH in arch/i386.  While this may be
jarring to people who know and love Voyager, it doesn't break
anything.

We could do what you suggest, but that sounds unnecessary.

I'd rather either
	leave things as they are
	rename SUBARCH

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
