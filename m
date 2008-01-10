Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCnFX-0003vp-VS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:34:32 -0800
Received: from one.firstfloor.org ([213.235.205.2] ident=nobody)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCnFX-0008Mz-KH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:34:31 -0800
Date: Thu, 10 Jan 2008 03:37:01 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20080110023701.GB20813@one.firstfloor.org>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<p734pdmput0.fsf@bingen.suse.de>
	<E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
	<20080109213258.GC15612@one.firstfloor.org>
	<E1JCioy-0006os-6i@pomaz-ex.szeredi.hu>
	<20080110021404.GA11287@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080110021404.GA11287@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org, harvey.harrison@gmail.com

On Wed, Jan 09, 2008 at 09:14:04PM -0500, Jeff Dike wrote:
> On Wed, Jan 09, 2008 at 10:50:48PM +0100, Miklos Szeredi wrote:
> > > FASTCALL is useless and should not make a difference. It enables
> > > regparm on specific functions, but that should not make a difference
> > > if it works or not.
> > 
> > __down_write() in include/asm-x86/rwsem.h seems to assume, that the
> > semaphore pointer is passed in %eax down to rwsem_down_write_failed(),
> > so regparm does make a difference there.
> 
> And rwsem_down_write_failed seems to think it's getting the pointer in
> %eax:

That's a left over from when it was called by magic inline assembly.
I suspect it would be better to switch it just over to stack args
for consistent and then declare it asmlinkage

-Andi

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
