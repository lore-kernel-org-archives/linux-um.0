Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FZVcb-000600-Oy for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 09:15:09 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FZVca-0006f6-2X
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Apr 2006 09:15:09 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [RFC] PATCH 0/4 - Time virtualization
Message-ID: <20060428151543.GA7397@ccure.user-mode-linux.org>
References: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
	<200604281333.41358.blaisorblade@yahoo.it>
	<20060428114823.GA3641@ccure.user-mode-linux.org>
	<200604281554.32665.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604281554.32665.blaisorblade@yahoo.it>
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
Date: Fri, 28 Apr 2006 11:15:43 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Fri, Apr 28, 2006 at 03:54:31PM +0200, Blaisorblade wrote:
> Additionally, if this flag ever goes into clone, it mustn't be named 
> CLONE_TIME, but CLONE_NEWTIME (or CLONE_NEWUTS). And given CLONE_NEWNS, it's 
> IMHO ok to have unshare(CLONE_NEWTIME) to mean "unshare time namespace", even
> if it's incoherent with unshare(CLONE_FS) - the incoherency already exists 
> with CLONE_NEWNS.

I wonder if they should be CLONE_* at all.  Given that we are likely
to run out of free CLONE_* bits, unshare will have to reuse bits that
don't have anything to do with sharing resources (CSIGNAL,
CLONE_VFORK, etc), and it doesn't seem that nice to have two different
CLONE_* flags with the same value, different meaning, only one of
which can actually be used in clone.

It seems better to use UNSHARE_*, with the current bits that are
common to unshare and clone being defined the same, i.e.
	#define UNSHARE_VM CLONE_VM

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
