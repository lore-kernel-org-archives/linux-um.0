Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BsjBX-0006Qj-1f for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 07:25:35 -0700
Message-Id: <200408051524.i75FOiCi002455@ccure.user-mode-linux.org>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: Your message of "Thu, 05 Aug 2004 10:28:00 BST."
	<Pine.LNX.4.60.0408051026120.21344@hermes-1.csi.cam.ac.uk> 
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
	<yek3c33tk5o.fsf@audi.uk.cyberscience.com>
	<20040804153541.GA7237@ccure.user-mode-linux.org>
	<yekacxbrlvi.fsf@audi.uk.cyberscience.com>
	<200408041800.i74I0Nvv007667@ccure.user-mode-linux.org>
	<2b464bd94c.work@loxley.compton.nu>
	<200408042102.i74L2Pvv008609@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408051026120.21344@hermes-1.csi.cam.ac.uk> 
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
Date: Thu, 05 Aug 2004 11:24:44 -0400
To: Nicholas Nethercote <njn25@cam.ac.uk>
Cc: Tom Hughes <thh@cyberscience.com>, dbahi@enterasys.com, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

njn25@cam.ac.uk said:
> To summarise:  you seem to be confident there won't be any problems,
> and  Tom's not so sure.  I'm not sure either, but the threads/signals/
> syscalls  stuff is the part of Valgrind I understand the least.  I
> would say, just  don't be shocked if you do this and weird things
> start happening :) 

Fair enough.  I'd just point out that this worked fine a couple of years ago,
so there's some basis for my confidence.  OTOH, that patch was never merged,
so possibly that basis has disappeared.

But I'd say that this is worth looking into, since valgrinding the kernel 
would be an immensely useful thing to be able to do.

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
