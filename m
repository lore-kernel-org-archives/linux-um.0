Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GHnpi-0004Yj-IP for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 13:35:46 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GHnpg-0007fD-3F
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Aug 2006 13:35:46 -0700
Date: Mon, 28 Aug 2006 16:35:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060828203514.GC6728@ccure.user-mode-linux.org>
References: <20060821215641.GQ11651@stusta.de>
	<200608261256.36654.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200608261256.36654.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] arch/um/sys-i386/setjmp.S: useless #ifdef _REGPARM's?
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
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>

On Sat, Aug 26, 2006 at 12:56:36PM +0200, Blaisorblade wrote:
> Can anybody explain me how can we use REGPARM if we have to link with host 
> glibc?

Umm, yeah, good point.  This regparam behavior is different from the old
behavior, where regparam functions had to be declared as such.

However, this is a potential problem with all regparam users, who all
presumably use libc, so I'd imagine it works somehow.

> If we are going to use klibc instead of glibc that's ok (and this is not the 
> case I'm talking about), but I do not know that plan (and nobody discussed 
> the implications).

I've been idly considering that, but it's no more than idle consideration
right now.

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
