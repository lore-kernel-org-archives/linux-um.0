Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GNBlb-0003Tx-UK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 10:09:48 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GNBlZ-0005XL-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Sep 2006 10:09:47 -0700
Date: Tue, 12 Sep 2006 13:08:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060912170841.GA7980@ccure.user-mode-linux.org>
References: <20060829083009.95142.qmail@web25224.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060829083009.95142.qmail@web25224.mail.ukl.yahoo.com>
Subject: Re: [uml-devel] Using -fcombine for UML
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
To: Paolo Giarrusso <blaisorblade@yahoo.it>
Cc: UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Aug 29, 2006 at 10:30:09AM +0200, Paolo Giarrusso wrote:
> Look there, it would be very useful IMHO for UML:
> 
> http://lkml.org/lkml/2006/8/24/212

Yeah, looks interesting, but a bunch of work.  When you build a directory
at a time, everything that is exposed to the outside needs to be declared
__global.

This is useful documentation in its own right, but it will take some time
to do.

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
