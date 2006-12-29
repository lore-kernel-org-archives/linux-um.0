Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H0RQy-0002xT-OX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H0RQy-0007gw-3z
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Dec 2006 15:46:44 -0800
Message-Id: <200612292341.kBTNfPGL005524@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 29 Dec 2006 18:41:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 0/6] UML - Locking, whitespace, style,
	and hotplug fixes
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This stuff is all post-2.6.20 material.

I'm fixing the locking through UML, and discovering other nastinesses along
the way.

Patches 1, 4, and 5 fix locking in the console and network drivers.

I have a huge raft of whitespace and style fixes which I will feed in as I
fix the locking in the same files.  The first installment of these are patches
3 and 6.

Patch 2 fixes problems getting hotplug errors back to the host, which I 
discovered while trolling through that code.

				Jeff


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
