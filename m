Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@addtoit.com>) id 1MJqLy-0000bK-IT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2009 14:55:06 +0000
Received: from saraswathi.solana.com ([198.99.130.12])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJqLa-0008Lz-6b
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2009 14:55:06 +0000
Date: Thu, 25 Jun 2009 10:51:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20090625145155.GA6383@c2.user-mode-linux.org>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090622085735.GB6499@cr0.nay.redhat.com>
	<20090622205226.fee30ba8.sfr@canb.auug.org.au>
	<20090625104901.GG6374@cr0.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090625104901.GG6374@cr0.nay.redhat.com>
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
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On Thu, Jun 25, 2009 at 06:49:01PM +0800, Amerigo Wang wrote:
> make ARCH=um SUBARCH=ppc? Or something similar...

It would need to be
	make ARCH=um 
with an x86 cross-compiler.

				Jeff

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

