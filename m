Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bs2YI-00049X-Gd for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Aug 2004 09:54:14 -0700
Message-Id: <200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: Your message of "Tue, 03 Aug 2004 15:31:44 BST."
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk> 
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 03 Aug 2004 13:50:22 -0400
To: Nicholas Nethercote <njn25@cam.ac.uk>
Cc: "D. Bahi" <dbahi@enterasys.com>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

njn25@cam.ac.uk said:
> What address was UML trying to load something at?  Is that adjustable?

It is now.  Get the load-low patch from 
	http://user-mode-linux.sourceforge.net/patches.html

It will make UML load where every normal process loads when CONFIG_MODE_SKAS
is on and CONFIG_MODE_TT is off.  This should get you past valgrind's address
space assumptions.

As a side-benefit, this will allow UML to have much greater physical memory
without needing to go to highmem.  If you take advantage of this, either enable 
CONFIG_STATIC_LINK or keep the physical memory size below about 750M.  The
reason is you don't want to push UML physical memory into the 0x40000000 area
occupied by shared libraries.  With CONFIG_STATIC_LINK, this problem goes away
and you can have physical memory up to about 2.75G.

Let me know if there are any problems.  It's not well tested - I ran it enough
to see it panic because it had no root filesystem.  My current work box doesn't
have skas on it yet, so I can't boot this one up totally.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
