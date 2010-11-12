Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1PGzTC-0002jy-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2010 19:39:34 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PGzT7-0006rN-Hr
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Nov 2010 19:39:34 +0000
From: Richard Weinberger <richard@nod.at>
Date: Fri, 12 Nov 2010 20:39:17 +0100
References: <1289517488-17628-1-git-send-email-richard@nod.at>
	<20101112112904.4b91d140.akpm@linux-foundation.org>
In-Reply-To: <20101112112904.4b91d140.akpm@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <201011122039.18025.richard@nod.at>
Subject: Re: [uml-devel] [PATCH] um: mark CONFIG_HIGHMEM as broken
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am Freitag 12 November 2010, 20:29:04 schrieb Andrew Morton:
> On Fri, 12 Nov 2010 00:18:08 +0100
> 
> Richard Weinberger <richard@nod.at> wrote:
> > Currently CONFIG_HIGHMEM is broken on User Mode Linux.
> > I'm not sure if it worked ever.
> 
> What is "broken" about it?

Currently it does not even build.
This is very annoying when using "make randconfig".

And it was never stable.
See commit ce2d2aed:
commit ce2d2aedcc3ca582fed90f44970e8b3e4f006a7d
Author: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Date:   Wed Jan 18 17:42:59 2006 -0800

    [PATCH] uml: arch Kconfig menu cleanups
    
    *) mark as "EXPERIMENTAL" various items that either aren't very stable or
       that are actively crashing the setup of users which don't really need them
       (i.e.  HIGHMEM and 3-level pagetables on x86 - nobody needs either,
       everybody reports "I'm using it and getting trouble").
    
    *) move net/Kconfig near to the rest of network configurations, and
       drivers/block/Kconfig near "Block layer" submenu.
    
    *) it's useless and doesn't work well to force NETDEVICES on and to disable
       the prompt like it's done.  Better remove the attempt, and change that to a
       simple "default y if UML".
    
    *) drop the warning about "report problems about HPPFS" - it's redundant
       anyway, as that's the usual procedure, and HPPFS users are especially
       technical (i.e.  they know reporting bugs is _good_).
    
    Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
    Cc: Jeff Dike <jdike@addtoit.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Thanks,
//richard

------------------------------------------------------------------------------
Centralized Desktop Delivery: Dell and VMware Reference Architecture
Simplifying enterprise desktop deployment and management using
Dell EqualLogic storage and VMware View: A highly scalable, end-to-end
client virtualization framework. Read more!
http://p.sf.net/sfu/dell-eql-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

