Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9A1w-0006WG-8u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 14:51:52 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1D9A1t-0001qM-Q2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 14:51:52 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050309145044.764bc056.akpm@osdl.org>
In-Reply-To: <20050309224259.J25398@flint.arm.linux.org.uk>
References: <20050309094234.8FC0C6477@zion>
	<20050309171231.H25398@flint.arm.linux.org.uk>
	<200503092052.24803.blaisorblade@yahoo.it>
	<20050309224259.J25398@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Date: Wed, 9 Mar 2005 14:50:44 -0800
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: blaisorblade@yahoo.it, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, domen@coderock.org, amitg@calsoftinc.com, gud@eth.net

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
>  I'm not convinced about the practicality of converting all static
>  initialisations to code-based initialisations though

This is the first one I recall seeing.  All the other conversions were replacing

	static spinlock_t lock = SPIN_LOCK_UNLOCKED;

with
	static DEFINE_SPINLOCK(lock);

and replacing

	{
		lock = SPIN_LOCK_UNLOCKED;
	}

with

	{
		spin_lock_init(lock);
	}



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
