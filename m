Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AtUCW-0003nY-Lj
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 08:05:28 -0800
Received: from dhcp-20-253.via-eth.ch ([192.33.101.253] helo=spyro.moor.ws)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AtU0c-0001Qc-9o
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 18 Feb 2004 07:53:10 -0800
Message-ID: <40338C1B.1070800@meisterwerk.net>
From: Patrick Moor <uml@meisterwerk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] skas3 patch fails against vanilla-2.4.25
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
Date: Wed, 18 Feb 2004 17:00:27 +0100
To: user-mode-linux-devel@lists.sourceforge.net

hello

 >patching file arch/i386/kernel/ldt.c
 >Hunk #1 FAILED at 24.
i could manually correct this one

 >patching file arch/i386/kernel/process.c
 >Hunk #1 FAILED at 551.
 >Hunk #2 FAILED at 568.
 >...
 >patching file include/asm-i386/processor.h
 >Hunk #1 FAILED at 436.

but these two i couldn't fix.
("copy_segments" function seems to be gone)

anyone any ideas?

thanks
  patrick


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
