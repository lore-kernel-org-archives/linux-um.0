Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZQev-0006C7-Hf for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 01:20:25 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CZQeu-0003As-CF
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 01:20:25 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041201090203.GD12963@bytesex>
References: <20041130200845.2C5058BAFE@zion.localdomain>
	<20041130152017.129e134c.akpm@osdl.org>
	<200412010120.39579.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412010120.39579.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: VFS interactions with UML and other big UML changes
	(was: Re: [patch 1/2] Uml - first part rework of run_helper()
	and users.)
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
Date: Wed, 1 Dec 2004 10:02:03 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, user-mode-linux-devel@lists.sourceforge.net

> > uml-terminal-cleanup.patch
> 
> I don't know technically this one. It won't probably go in 2.6.10, I think 
> later... tested in the SuSE tree, but let's be quiet in merging _big_ things, 
> ok? It was also tested in a different tree, so it perfectly working on 2.6.9 
> does not mean perfectly working on current kernels.

Tested by me on 2.6.10-rc2-bk<something> as well.  It needed some
trivial adaptions to the tty layer changes done by Linus compared
to the old 2.6.9 version.  I'm pretty confident it wouldn't break
anything, but as it is to big to be classified as ObviouslyCorrect[tm]
fix it probably should not go to into 2.6.10 but be merged in the
2.6.11 cycle.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
