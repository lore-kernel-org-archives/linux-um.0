Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H1TSD-0007VR-7R for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 12:08:17 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H1TSB-0004og-Mn
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Jan 2007 12:08:17 -0800
Date: Mon, 1 Jan 2007 15:03:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070101200301.GD20792@ccure.user-mode-linux.org>
References: <200612292341.kBTNfR3s005529@ccure.user-mode-linux.org>
	<20061229154802.b0768d6e.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061229154802.b0768d6e.rdunlap@xenotime.net>
Subject: Re: [uml-devel] [PATCH 1/6] UML - Console locking fixes
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 29, 2006 at 03:48:02PM -0800, Randy Dunlap wrote:
> /*
>  * Normally, ...

> 	if (
> 	(several of these)

Yeah, I'm working off the most blatant style violations at the moment.

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
