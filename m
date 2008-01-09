Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCipG-0002e6-12 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:51:06 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCipE-0003LH-Ds
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:51:06 -0800
In-reply-to: <20080109213258.GC15612@one.firstfloor.org> (message from Andi
	Kleen on Wed, 9 Jan 2008 22:32:58 +0100)
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<p734pdmput0.fsf@bingen.suse.de>
	<E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
	<20080109213258.GC15612@one.firstfloor.org>
Message-Id: <E1JCioy-0006os-6i@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Jan 2008 22:50:48 +0100
Subject: Re: [uml-devel] uml and -regparm=3
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: andi@firstfloor.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, akpm@linux-foundation.org, user-mode-linux-devel@lists.sourceforge.net, harvey.harrison@gmail.com

> FASTCALL is useless and should not make a difference. It enables
> regparm on specific functions, but that should not make a difference
> if it works or not.

__down_write() in include/asm-x86/rwsem.h seems to assume, that the
semaphore pointer is passed in %eax down to rwsem_down_write_failed(),
so regparm does make a difference there.

There's also some intervening magic in arch/x86/lib/semaphore_32.S,
that I don't quite understand, but which doesn't seem to make a
difference.

Miklos

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
