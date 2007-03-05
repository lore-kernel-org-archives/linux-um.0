Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOLSf-00079t-35 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:15:17 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOLSd-00059x-Fq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 14:15:16 -0800
Date: Mon, 5 Mar 2007 17:06:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070305220634.GC7702@ccure.user-mode-linux.org>
References: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070305204229.9072.17032.stgit@americanbeauty.home.lan>
Subject: Re: [uml-devel] [PATCH 00/11] Uml simple fixes
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
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 05, 2007 at 09:42:29PM +0100, Paolo 'Blaisorblade' Giarrusso wrote:
> Some tested UML fixes - should be applied for 2.6.21.

ACK on all of these except for 1, which won't apply to current -mm,
and 4, which might need some more work.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
