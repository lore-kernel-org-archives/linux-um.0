Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNtxj-0007hv-ST for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 06:39:55 -0700
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BNtxj-0002Ge-Fy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 06:39:55 -0700
From: Rik van Riel <riel@redhat.com>
Subject: Re: [uml-devel] Patch for 2.6.6
In-Reply-To: <200405112032.13202.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0405120938170.3394-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0405120938172.3394@chimarrao.boston.redhat.com>
Content-Disposition: INLINE
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
Date: Wed, 12 May 2004 09:39:14 -0400 (EDT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>, Jeff Chua <jeff98@silk.corp.fedex.com>, roland <for_spam@gmx.de>, gboutwel <gboutwel@praize.com>, Jeff Dike <jdike@addtoit.com>

On Tue, 11 May 2004, BlaisorBlade wrote:

> --- ./arch/um/kernel/physmem.c.saved    2004-05-11 19:24:53.000000000 +0200
> +++ ./arch/um/kernel/physmem.c  2004-05-11 19:25:16.000000000 +0200
> @@ -285,7 +285,7 @@

> -               INIT_LIST_HEAD(&p->list);
> +               INIT_LIST_HEAD(&p->lru);

This is correct.  Page->list is gone, now struct page
only has one list head left: page->lru.


-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
