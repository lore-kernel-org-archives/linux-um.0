Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-list2-b.sourceforge.net ([10.3.1.8]
	helo=sc8-sf-list2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrqlJ-0008AQ-Bo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 21:18:53 -0700
Message-Id: <200408030517.i735HZUE026250@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: Your message of "Mon, 02 Aug 2004 22:47:55 EDT."
	<410EFCDB.8080404@enterasys.com> 
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com> 
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
Date: Tue, 03 Aug 2004 01:17:35 -0400
To: "D. Bahi" <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

dbahi@enterasys.com said:
> Executable is mapped outside of range (nil)-0x52c00000 valgrind:
> do_exec(/local/dbahi/kernels/linux-2.4.26_uml-patch-2.4.26-2um/linux)
> failed: Cannot allocate memory
>
> How does one get around this sudden valgrind exit? 

If I remember right, there is a hard-coded address in valgrind.  If the process
loads above that you get that error.  Changing it and rebuilding doesn't seem
to hurt anything.

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
