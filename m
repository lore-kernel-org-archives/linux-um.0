Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GsPhF-0000Ku-IY for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Dec 2006 12:18:21 -0800
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GsPhC-0000Ko-Vl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Dec 2006 12:18:21 -0800
Date: Thu, 7 Dec 2006 21:18:11 +0100
Message-ID: <20061207201811.GA30867@cube.dyndns.org>
References: <20061203210608.GA2704@cube.dyndns.org>
	<200612072027.46049.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200612072027.46049.blaisorblade@yahoo.it>
From: rsnel@cube.dyndns.org
Subject: Re: [uml-devel] ZONE_DMA and dm_create->init_emergency_isa_pool
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
Cc: user-mode-linux-devel@lists.sourceforge.net

Hello,

On Thu, Dec 07, 2006 at 08:27:45PM +0100, Blaisorblade wrote:
> On Sunday 03 December 2006 22:06, rsnel@cube.dyndns.org wrote:
> > When I want to create a device mapper table in user-mode-linux, I get
> >
> > BUG: failure at mm/bounce.c:85/init_emergency_isa_pool()!
> > (full stack trace below)
> >
> > I think this behaviour was introduced by:
> > [PATCH] uml: get rid of ZONE_DMA use
> >
> > I got it to work by reversing the patch.
> Can you detail the used UML version? Thanks.

It happens, for example, with stock 2.6.19+"page.h compilation fix by Jeff".

> >      0901bd78:  [<080686b0>] show_regs+0xb4/0xb9
> >      0901bda4:  [<0805a4c3>] panic_exit+0x25/0x3f
> >      0901bdb8:  [<0807b018>] notifier_call_chain+0x1d/0x3c
> >      0901bdd8:  [<0807b0a7>] atomic_notifier_call_chain+0x11/0x13
> >      0901bdec:  [<0806f96e>] panic+0x52/0xdd
> >      0901be0c:  [<0809b91b>] init_emergency_isa_pool+0x4b/0x5d
> >      0901be28:  [<080f3cbd>] blk_queue_bounce_limit+0x33/0x48
> >      0901be3c:  [<081106a5>] alloc_dev+0xf4/0x285
> >      0901be64:  [<081109c1>] dm_create+0xb/0x20

The failing init_emergency_isa_pool is called from block/ll_rw_blk.c
because it finds that the system has DMA. With the introduction of 'get
rid of ZONE_DMA use' init_emergency_isa_pool started giving errors.
The proper fix probably consists of convincing block/ll_rw_blk.c that it
doesn't need DMA (<16MB) memory.

Greetings,

Rik.

-- 
Nothing is ever a total loss; it can always serve as a bad example.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
