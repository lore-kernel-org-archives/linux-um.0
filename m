Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPOyV-0001bg-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 11:03:27 -0700
Received: from mout0.freenet.de ([194.97.50.131])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DPOyQ-0003HD-OY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 11:03:27 -0700
Received: from [194.97.55.191] (helo=mx7.freenet.de)
	by mout0.freenet.de with esmtpa (Exim 4.51) id 1DPOyI-0004bB-6h
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:03:14 +0200
Received: from ib6b6.i.pppool.de ([85.73.182.182] helo=bakunin.copyleft.de)
	by mx7.freenet.de with esmtpsa (ID freenet_bakunin@freenet.de)
	(TLSv1:AES256-SHA:256) (Exim 4.51 #8) id 1DPOyH-0002r3-W3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:03:14 +0200
Received: from kraehe by bakunin.copyleft.de with local (Exim 4.50)
	id 1DPOyI-0004d8-WD for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 23 Apr 2005 20:03:15 +0200
From: kraehe <kraehe@copyleft.de>
Message-ID: <20050423180314.GA17743@copyleft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] uml 2.4 (32 bit) on skas 2.6 (64 bit)
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
Date: Sat, 23 Apr 2005 20:03:14 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Moin Guru's,

  i purchased an AMD64 box recently - so i now have a 64bit system
  running 2.6.11.7 in 64bit mode and 32bit emulation. I've tried the
  skas-2.6.11-v9-pre1.patch on the 64bit host and I now have 

durruti:/usr/src/linux-2.6.11.7-skas3-v9-amd64 $ l /proc/mm*
--w--w--w-  1 root root 0 2005-04-23 19:57 /proc/mm
--w--w--w-  1 root root 0 2005-04-23 19:57 /proc/mm64

  but, when old UMLs are runing into problems after mounting root,
  e.g. 2.4.22 (with some old patch) :

TCP: Hash tables configured (established 4096 bind 4096)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Unable to load interpreter
Kernel panic: kernel BUG at memory.c:377!

  or 2.4.30 (with uml-2.4.28-bs2-pre11.patch) :

Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
  [ ... system goes up to full load without any work ]

  any idea where/how to proceed ? any new better/newer patches to
  addess the idea of running a 32bit UML on a 64bit SKAS host ?

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
