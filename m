Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.12] (helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CATkG-0004DS-7G for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Sep 2004 06:34:48 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CATkD-0004Yf-Ie
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Sep 2004 06:34:48 -0700
Message-Id: <200409230336.i8N3a8iF004364@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Additions to the incremental patches page
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
Date: Wed, 22 Sep 2004 23:36:08 -0400
To: user-mode-linux-devel@lists.sourceforge.net
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>

I've added my mm tree to 
	http://user-mode-linux.sourceforge.net/patches.html

It's currently at 2.6.9-rc2-mm2.

This is what I'm feeding to Andrew, so having people find problems before
he gets them would be good.  Currently, the patches are BlaisorBlade's
patchset.  

I sent everything up to line-fix-buffer-data except use-va_end to Andrew
this evening.

It stops building at dma-mapping.  I'm currently looking into this.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
