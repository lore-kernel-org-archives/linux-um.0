Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9D6Q-0001FN-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 18:08:42 -0800
Received: from 70-56-134-246.albq.qwest.net ([70.56.134.246]
	helo=montezuma.fsmlabs.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9D6P-0008PM-6c
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 18:08:42 -0800
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.61.0503091840210.22633@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503091908040.2903@montezuma.fsmlabs.com>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
	<200503092052.24803.blaisorblade@yahoo.it>
	<20050309224259.J25398@flint.arm.linux.org.uk>
	<20050309145044.764bc056.akpm@osdl.org>
	<Pine.LNX.4.61.0503091840210.22633@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: [patch 1/1] unified spinlock initialization
	arch/um/drivers/port_kern.c
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
Date: Wed, 9 Mar 2005 19:09:08 -0700 (MST)
To: linux-os <linux-os@analogic.com>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, blaisorblade@yahoo.it, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

On Wed, 9 Mar 2005, linux-os wrote:

> We need to retain the spin_lock_init(&lock) because not all spin-locks
> are allocated at compile-time. They might be allocated from kmalloc()
> on startup, probably in a structure, along with other so-called
> global data.

Not to worry my good man, it's not going anywhere.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
