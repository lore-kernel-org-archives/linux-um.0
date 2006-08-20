Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GEbPZ-0006kL-CO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 17:43:33 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GEbPW-0002dv-TT
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Aug 2006 17:43:33 -0700
Date: Sat, 19 Aug 2006 20:42:59 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060820004259.GA4465@ccure.user-mode-linux.org>
References: <200608171256.57196.peter@fusselt.net>
	<200608191653.43641.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200608191653.43641.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour in eth assignments
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
Cc: Peter Hovorka <peter@fusselt.net>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Aug 19, 2006 at 04:53:43PM +0200, Blaisorblade wrote:
> Do you really mean "tap112"? Nobody I think tried this. 

I have :-)  Read The Book (and BTW, I need to figure out a way to get you 
a copy).

> If this were, say, a buffer overflow, or a bug because tap112 does not exist,
> the source causes "unspecified behaviour", so totally unrelated changes can 
> change the actual behaviour to change.

I don't see anything on the host affecting this.  Something funky is happening
when the UML network subsystem chooses names for new interfaces.

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
