Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQOLK-0002Yf-5h for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 04:35:06 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQOLG-0006Ar-NO
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 26 Apr 2005 04:35:06 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050426043359.6674dc49.akpm@osdl.org>
In-Reply-To: <20050424181909.81B8F33AED@zion>
References: <20050424181909.81B8F33AED@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/7] uml: fix syscall table by including
	$(SUBARCH)'s one, for i386
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
Date: Tue, 26 Apr 2005 04:33:59 -0700
To: blaisorblade@yahoo.it, Mikael Pettersson <mikpe@csd.uu.se>
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it wrote:
>
>  linux-2.6.12-paolo/arch/i386/kernel/entry.S                 |  292 ------------
>   linux-2.6.12-paolo/arch/i386/kernel/syscall_table.S         |  291 +++++++++++

gack.  Any time anyone touches the syscall tables I have to delicately
rework 8,000 perfctr patches.

So I folded all the perfctr patches into a single patch for now.  Later
I'll split it out into core and architectures.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
