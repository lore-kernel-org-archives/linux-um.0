Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPPYQ-0003Lx-Ji for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 11:40:34 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DPPYP-0006Ld-3H
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 11:40:34 -0700
Received: from [194.97.50.144] (helo=mx1.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.51) id 1DPPYN-0003hs-DL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:40:31 +0200
Received: from ib6b6.i.pppool.de ([85.73.182.182] helo=bakunin.copyleft.de)
	by mx1.freenet.de with esmtpsa (ID freenet_bakunin@freenet.de)
	(TLSv1:AES256-SHA:256) (Exim 4.51 #8) id 1DPPYN-00007Q-6g
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:40:31 +0200
Received: from kraehe by bakunin.copyleft.de with local (Exim 4.50)
	id 1DPPYO-0004fO-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:40:32 +0200
From: kraehe <kraehe@copyleft.de>
Message-ID: <20050423184032.GA17889@copyleft.de>
References: <20050423180314.GA17743@copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423180314.GA17743@copyleft.de>
Subject: [uml-devel] Re: uml 2.4 (32 bit) on skas 2.6 (64 bit) - add on
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
Date: Sat, 23 Apr 2005 20:40:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Moin Guru's,

  I've just tried that, 2.4.30 with uml-2.4.28-bs2-pre11.patch works
  on a 2.6.11.7-amd64 host without any SKAS patches. So TT mode is
  fine. The 2.4.22 bug my UML runs when in SKAS reads as :

	/*
	 * This is a long-lived spinlock. That's fine.
	 * There's no contention, because the page table
	 * lock only protects against kswapd anyway, and
	 * even if kswapd happened to be looking at this
	 * process we _want_ it to get stuck.
	 */
	if (address >= end)
		BUG();            <-- Kernel panic: kernel BUG at memory.c:377!
	spin_lock(&mm->page_table_lock);
	flush_cache_range(mm, address, end);
	tlb = tlb_gather_mmu(mm);

  perhaps this old 2.4.22 code helps to point the problem with SKAS host
  and newer 2.4.30 UML clients (/me hopes they are same problem ;-)

Bye Michael
-- 
  mailto:kraehe@copyleft.de             UNA:+.? 'CED+2+:::Linux:2.4.29'UNZ+1'
  http://www.xml-edifact.org/           CETERUM CENSEO WINDOWS ESSE DELENDAM


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
