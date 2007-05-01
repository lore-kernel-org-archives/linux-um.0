Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hix2y-0000x0-VR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hix2w-0008Dx-GC
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 May 2007 11:25:56 -0700
Date: Tue, 1 May 2007 14:21:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070501182156.GA8373@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 0/6] cmpxchg cleanups and UML fixes
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This set is a combination of cmpxchg cleanups and UML fixes.

Patches 1 - 3 are the cmpxchg stuff -
	Remove tas() from all arches - I can't find any users.
	Move the i386 cmpxchg to asm-i386/cmpxchg.h
	Move the x86_64 cmpxchg to asm-x86_64/cmpxchg.h

Patches 4 - 6 fix things discovered while playing with pcap interfaces -
	Have the free wrapper detect malloced buffers and call libc free
	Fix the device initialization failure path and other small cleanups
	Allow pcap devices to be assigned MACs on the command line

This is all 2.6.22 material.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
