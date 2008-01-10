Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCmw9-0001of-RT for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:14:29 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCmw9-0000Zv-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:14:29 -0800
Date: Wed, 9 Jan 2008 21:14:04 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080110021404.GA11287@c2.user-mode-linux.org>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<p734pdmput0.fsf@bingen.suse.de>
	<E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
	<20080109213258.GC15612@one.firstfloor.org>
	<E1JCioy-0006os-6i@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JCioy-0006os-6i@pomaz-ex.szeredi.hu>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@linux-foundation.org, andi@firstfloor.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, harvey.harrison@gmail.com

On Wed, Jan 09, 2008 at 10:50:48PM +0100, Miklos Szeredi wrote:
> > FASTCALL is useless and should not make a difference. It enables
> > regparm on specific functions, but that should not make a difference
> > if it works or not.
> 
> __down_write() in include/asm-x86/rwsem.h seems to assume, that the
> semaphore pointer is passed in %eax down to rwsem_down_write_failed(),
> so regparm does make a difference there.

And rwsem_down_write_failed seems to think it's getting the pointer in
%eax:

Dump of assembler code for function rwsem_down_write_failed:
0x08193599 <rwsem_down_write_failed+0>: push   %ebp
0x0819359a <rwsem_down_write_failed+1>: mov    %esp,%ebp
0x0819359c <rwsem_down_write_failed+3>: push   %ebx
0x0819359d <rwsem_down_write_failed+4>: mov    %eax,%ebx
0x0819359f <rwsem_down_write_failed+6>: sub    $0x10,%esp
0x081935a2 <rwsem_down_write_failed+9>: push   $0xffffffff
0x081935a4 <rwsem_down_write_failed+11>:        lea    0xffffffec(%ebp),%eax
0x081935a7 <rwsem_down_write_failed+14>:        push   %eax
0x081935a8 <rwsem_down_write_failed+15>:        push   %ebx
0x081935a9 <rwsem_down_write_failed+16>:        movl   $0x2,0xfffffff8(%ebp)
0x081935b0 <rwsem_down_write_failed+23>:        call   0x8193423 <rwsem_down_failed_common>

This is clearly taking something from %eax and something on the stack
(and a -1) and passing it to rwsem_down_failed_common, corresponding
to this:
	rwsem_down_failed_common(sem, &waiter,
				RWSEM_WAITING_BIAS - RWSEM_ACTIVE_BIAS);

So, this does look right to me.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
