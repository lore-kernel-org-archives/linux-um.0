Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C838S-00050a-EU for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 13:45:44 -0700
Received: from shell.blacknet.de ([80.254.131.106])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1C838R-0005lC-Nn
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Sep 2004 13:45:44 -0700
From: Goetz Bock <bock+uml@blacknet.de>
Message-ID: <20040916210145.GJ24624@shell.blacknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] skas3(-v3) for 2.4.27 with exec-shield
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
Date: Thu, 16 Sep 2004 23:01:45 +0200
To: user-mode-linux-devel@lists.sourceforge.net


Hi all,

as I've no realy idea about the internal work of the skas patches, I'll
have to bother you.

I'd like to run a 2.4.27 kernel with exec-shield patch and skas3, if
possible the -v3 version from BlaisorBlade, except that it does not
apply :-(

There are three conflicts in mm/mprotect.c but i suspect there are more
not working sections.

The patch seams to mainly change current->mm to mm, after defining 

    struct mm_struct * mm = vma->vm_mm;

unfortunately i've no idea how current-> mm and vma->vm_mm (aka mm)
relate. Are they the same?

Sorry, but obviosely I've no idea about the vm subsystem ... and not
more about the rest of the kernel :-(
-- 
/"\ Goetz Bock at blacknet dot de  --  secure mobile Linux everNETting
\ /       (c) 2004 Creative Commons, Attribution-ShareAlike 2.0 de
 X   [ 1. Use descriptive subjects - 2. Edit a reply for brevity -  ]
/ \  [ 3. Reply to the list - 4. Read the archive *before* you post ]


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
