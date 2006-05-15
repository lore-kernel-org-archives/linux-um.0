Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FfcMa-0000NT-HI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 05:39:52 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FfcMZ-00087u-8G
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 May 2006 05:39:52 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: Bug#366915: [uml-devel] Re: Bug#366915: user-mode-linux: fails
	when host kernel is linux-image-2.6.16-1-k7
Message-ID: <20060515123954.GA3337@ccure.user-mode-linux.org>
References: <20060512035019.18151.73446.reportbug@doof.home>
	<20060512200806.GA27800@inferi.kami.home>
	<20060515034427.GE21383@ccure.user-mode-linux.org>
	<58990.217.33.203.18.1147687738.squirrel@picard.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58990.217.33.203.18.1147687738.squirrel@picard.linux.it>
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
Date: Mon, 15 May 2006 08:39:54 -0400
To: Mattia Dongili <malattia@linux.it>
Cc: Paul Dwerryhouse <paul@dwerryhouse.com.au>, 366915@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, May 15, 2006 at 12:08:58PM +0200, Mattia Dongili wrote:
> Oh, I found
> CONFIG_PAGE_OFFSET=0xB0000000
> 
> may this be the problem? I found reports telling it broke other SW:
> http://lists.debian.org/debian-kernel/2006/04/msg00042.html

Yup, that's the problem.  They did spring a split change on you.

On rc4, UML will run if you enable host 2G/2G support.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
