Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqgjN-0002BE-43 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 16:24:05 -0700
Received: from w218.z064002068.nyc-ny.dsl.cnc.net ([64.2.68.218])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BqgjM-0002oH-En for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 16:24:05 -0700
From: Allen Chan <alydar@users.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407301924.04914.alydar@users.sourceforge.net>
Subject: [uml-devel] Re: Incremental patches available
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
Date: Fri, 30 Jul 2004 19:24:02 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

While attempting to build and test a 2.6.7 kernel including the 
patches found on the new incremental patches page, I've bumped into 
into problems with a couple of the patches:

(1)  remap - apparently, this patch has already been applied as part 
of  uml-patch-2.6.7-1.bz2.
(2)  time - one of the patches included here attempts to modify 
um/arch/um/os/Makefile.  However, that file does not exist.  It looks 
like that file should be um/arch/um/os-Linux/Makefile.

The rest of the 2.6.7 patches (other than hostfs which the website 
says "*** This currently doesn't compile ***") appear to apply with 
no problems.

Now to compile and beat up on the new test kernel...


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
