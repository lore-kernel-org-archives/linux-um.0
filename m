Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fg4zo-0006fX-9w for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 12:14:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fg4zj-0002Xk-F9
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 12:14:13 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Bug#366915: user-mode-linux: fails when host
	kernel is linux-image-2.6.16-1-k7
Message-ID: <20060516191438.GC6337@ccure.user-mode-linux.org>
References: <20060512035019.18151.73446.reportbug@doof.home>
	<20060512200806.GA27800@inferi.kami.home>
	<200605151239.49362.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605151239.49362.blaisorblade@yahoo.it>
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
Date: Tue, 16 May 2006 15:14:38 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Mattia Dongili <malattia@linux.it>, Paul Dwerryhouse <paul@dwerryhouse.com.au>

On Mon, May 15, 2006 at 12:39:48PM +0200, Blaisorblade wrote:
> The error message is different. However, I can't exclude there is the same 
> root cause acting in a different way, but I've now debugged this a bit and 
> this seems unlikely.

Have you learned anything?

See the register dumping patch I just posted and see if that tells you
anything new.

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
