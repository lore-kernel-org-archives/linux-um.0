Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1MK1UG-0002S4-JI
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 02:48:24 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MK1UE-0002Zi-BG
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Jun 2009 02:48:24 +0000
Date: Thu, 25 Jun 2009 22:48:02 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090626024802.GA17655@c2.user-mode-linux.org>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090622085735.GB6499@cr0.nay.redhat.com>
	<20090622205226.fee30ba8.sfr@canb.auug.org.au>
	<20090625104901.GG6374@cr0.nay.redhat.com>
	<20090625145155.GA6383@c2.user-mode-linux.org>
	<20090626120111.ef8622ba.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090626120111.ef8622ba.sfr@canb.auug.org.au>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Amerigo Wang <xiyou.wangcong@gmail.com>, akpm@linux-foundation.org

On Fri, Jun 26, 2009 at 12:01:11PM +1000, Stephen Rothwell wrote:
> On out PowerPC host I am using
> 
> 	make ARCH=um SUBARCH=i386 CROSS_COMPILE=<path to i386 cross compiler>
> 
> I am just building defconfig, would another config also be useful?

defconfig is good - that's my normal test config.

> Currently plain "make ARCH=um" on PowerPC doesn't appear to work.

No, it won't.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

