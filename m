Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWFPL-0005Mq-RQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 06:43:11 -0800
Received: from main.gmane.org ([80.91.229.2])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWFPK-0004bh-D9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Nov 2004 06:43:11 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1CWFPI-0001CQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Nov 2004 15:43:08 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Nov 2004 15:43:08 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Nov 2004 15:43:08 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87sm726j2h.fsf@aka.i.naked.iki.fi>
References: <20041119011337.74CDD7B9C9@zion.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: [patch 3/4] uml: remove most devfs_mk_symlink calls
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
Date: Mon, 22 Nov 2004 16:43:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net

blaisorblade spam wrote:
> Since now we have evidence of less and less users using devfs, we
> think that it will not cause too much problems.

Just checking - these changes do not remove support for using UML with
devfs, only removing automatic symlink creations, am I right?

We still depend on devfs working quite heavily, so I'm just making
sure.

TIA,
-- Naked




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
