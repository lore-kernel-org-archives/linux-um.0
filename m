Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x4H0-0007Cq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 05:40:38 -0700
Received: from [202.181.236.208] (helo=ms.instant-host.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19x4Gy-00021q-Q4
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 10 Sep 2003 05:40:37 -0700
Message-ID: <60343.202.181.236.220.1063198180.squirrel@secure.yoric.net>
From: "Vincent" <vincent@yoric.net>
Reply-To: vincent@yoric.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Kernel panic: I/O op mismatch
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 10 Sep 2003 20:49:40 +0800 (HKT)
To: user-mode-linux-devel@lists.sourceforge.net

i was running 2.4.20-um6. i just compiled 2.4.22-1 and 2.4.22-2 but they
both having the following errors. i am running on redhat 2.4.21-19 host
with skas patch.

VFS: Mounted root (ext2 filesystem) readonly.
Kernel panic: I/O op mismatch
In interrupt handler - not syncing

i saw a few post regarding this kernel panic, any patch available?

rgds,
 Vincent


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
