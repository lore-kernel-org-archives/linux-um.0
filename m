Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtfCw-0006WG-Mv
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 19:50:38 -0800
Received: from [192.197.110.221] (helo=kgb02.kgbinternet.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Atf0K-0001zk-W4
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 19:37:37 -0800
Received: from nimbus (static24-72-41-155.reverse.accesscomm.ca [24.72.41.155])
	(authenticated (0 bits))
	by kgb02.kgbinternet.com (8.12.10/8.11.6) with ESMTP id i1J3jIfK021048
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 18 Feb 2004 21:45:24 -0600
From: "Keith Bjorndahl" <keith@kgbinternet.com>
Message-ID: <LHEAJMAMIDOPELFNOGOFGECBCAAA.keith@kgbinternet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: skas3 patch fails against vanilla-2.4.25
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 18 Feb 2004 21:45:15 -0600
To: user-mode-linux-devel@lists.sourceforge.net

I went at it another way and also failed...

I tried to take my skas-patched 2.4.24 and apply the 2.4.25 patch to it.

On compilation, the changes to process.c appear to break the skas patch. 



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
