Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H4LHJ-0001RV-RI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 10:00:54 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H4LHE-0006BS-Ai
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Jan 2007 10:00:50 -0800
Date: Tue, 9 Jan 2007 12:55:08 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070109175508.GC5434@ccure.user-mode-linux.org>
References: <20070105235251.GW20714@stusta.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070105235251.GW20714@stusta.de>
Subject: Re: [uml-devel] [FYI: 2.6.16 patch] fix the UML compilation
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
To: Adrian Bunk <bunk@stusta.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 06, 2007 at 12:52:52AM +0100, Adrian Bunk wrote:
> FYI:
> I've applied the patch below to the 2.6.16 tree to fix the UML 
> compilation on systems with recent kernel headers.
> 
> Please complain if anything is wrong with it.

With this patch, if it builds, it's good.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
