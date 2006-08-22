Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GFaHF-0003rM-OC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 10:43:01 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GFaHC-0000IG-6V
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 22 Aug 2006 10:43:01 -0700
Date: Tue, 22 Aug 2006 13:42:33 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060822174233.GA5471@ccure.user-mode-linux.org>
References: <20060821215641.GQ11651@stusta.de>
	<20060822022012.GA7070@ccure.user-mode-linux.org>
	<20060822160741.GB11651@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060822160741.GB11651@stusta.de>
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
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Aug 22, 2006 at 06:07:41PM +0200, Adrian Bunk wrote:
> I didn't find a corresponding open bug in the gcc Bugzilla.
> 
> Can someone verify whether it's still present, and if yes, open a gcc 
> bug?

Yup, it's easy enough to check.

> It's set globally in arch/i386/Makefile:
>   cflags-$(CONFIG_REGPARM) += -mregparm=3

IIRC, there used to be functions explicitly declared as __regparam or
something, and that's what I was grepping for.  Does this turn every
function with three or fewer parameters into a regparam function?

> That's not pulled by UML, but if there are no outstanding problems with 
> regparm, we could both enable it uncomditionally on i386 and enable it
> on UML/i386.

That shouldn't be a problem.

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
