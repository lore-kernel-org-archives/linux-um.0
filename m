Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peterz@infradead.org>) id 1LEOoW-0004iG-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 13:57:48 +0000
Received: from bombadil.infradead.org ([18.85.46.34])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LEOoQ-0000ce-F8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Dec 2008 13:57:48 +0000
From: Peter Zijlstra <peterz@infradead.org>
In-Reply-To: <E1LB4QO-0005fk-7g@pomaz-ex.szeredi.hu>
References: <E1LB4QO-0005fk-7g@pomaz-ex.szeredi.hu>
Date: Sun, 21 Dec 2008 14:57:38 +0100
Message-Id: <1229867858.9487.238.camel@twins>
Mime-Version: 1.0
Subject: Re: [uml-devel] [regression] uml is very slow on 2.6.28 host
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, 2008-12-12 at 10:35 +0100, Miklos Szeredi wrote:
> When the UML boot gets to the userspace part it gets really really
> slow.  It takes about 20 times the normal time to fully boot.  CPU
> seems to be idle.
> 
> Guest version doesn't matter.  Host version 2.6.27 was OK, latest git
> is not OK.  I'm running 32bit guest on 64bit host.

Does:

http://lkml.org/lkml/2008/12/16/40

help any?

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
