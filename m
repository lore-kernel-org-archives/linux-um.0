Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvBhv-0006fK-M1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 00:44:55 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvBaQ-0003o2-4V for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Feb 2004 00:37:10 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040223083801.GA28222@elte.hu>
References: <200402221604.19495.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402221604.19495.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Fwd: [uml-user] Host 2.6.2/3 + CFQ + BlaisorBlade
	patches == host panic
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
Date: Mon, 23 Feb 2004 09:38:01 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> Hi Ingo, could you please take a look at this report? With CONFIG_SMP
> enabled and the skas patch applied (last version, which includes all
> your changes) the kernel is BUGging during switch_mm.

is UML SMP-ready? There seem to be a handful of data structures that
should be per-CPU for correctness. (eg. userspace_pid?)

	Ingo


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
