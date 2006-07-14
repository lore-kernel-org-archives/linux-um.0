Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1UQH-0003yZ-Ly for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 13:38:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1UQG-0001Xk-6w
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 13:38:05 -0700
Date: Fri, 14 Jul 2006 16:37:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060714203744.GA6260@ccure.user-mode-linux.org>
References: <44B79AB9.3020401@garzik.org> <44B7A007.2010204@garzik.org>
	<200607142052.05666.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200607142052.05666.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML build broken everywhere?
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
Cc: Andrew Morton <akpm@osdl.org>, jdike@karaya.com, Jeff Garzik <jeff@garzik.org>, user-mode-linux-devel@lists.sourceforge.net, Linux Kernel <linux-kernel@vger.kernel.org>

On Fri, Jul 14, 2006 at 08:52:05PM +0200, Blaisorblade wrote:
> Jeff (Dike), please choose one of the "simple" patches I suggested (comment 
> out offending code, for instance) since you (correctly) deferred the real fix
> (incorporating klibc's setjmp implementation) to later.

Well, I have a patch which just copies the klibc setjmp stuff into the UML
tree until such time as klibc makes it into mainline.

Any objections?

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
