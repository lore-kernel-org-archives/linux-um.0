Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Awj1G-00049R-BE for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 06:31:14 -0800
Received: from gort.metaparadigm.com ([203.117.131.12])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwirF-0003h8-KO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 06:20:53 -0800
Received: from localhost (unknown [127.0.0.1])
	by gort.metaparadigm.com (Postfix) with ESMTP id B20191AC93
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2004 22:20:44 +0800 (SGT)
Received: from gort.metaparadigm.com ([127.0.0.1])
	by localhost (gort [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04114-03 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2004 22:20:44 +0800 (SGT)
Received: from metaparadigm.com (cm210.gamma72.maxonline.com.sg
	[202.156.72.210])
	by gort.metaparadigm.com (Postfix) with ESMTP id ECC321AC05
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 27 Feb 2004 22:20:43 +0800 (SGT)
Message-ID: <403F523B.2090602@metaparadigm.com>
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.3 skas mode host and guest success
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
Date: Fri, 27 Feb 2004 22:20:43 +0800
To: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

Hi All,

After hunting through the list. I couldn't find a patch
that cleanly applies to 2.6.3 (on top of latest uml patch)
to re-enable skas host support.

So after merging parts of Paulo's and Ingo's skas patches
for 2.6.0 and 2.6.2, I now have a single patch that cleanly
applies and runs for me both as a host and guest with 2.6.3
rediffed against the latest uml patch.

First apply 2.6.3-rc2.1 uml patch (cleanly applies to 2.6.3)

   http://www.user-mode-linux.org/mirror/uml-patch-2.6.3-rc2-1.bz2

Then apply the skas patch:

   http://www.metaparadigm.com/~mclark/uml/uml-2.6.3-skas-1.patch

It includes the following changes:

   * PROC_MM Kconfig
   * add back skas ptrace support
   * export ldt functions with mm argument
   * export do_mmap2 with mm argument
   * compatibility wrapper for do_mmap_pgoff
   * proc_mm now uses __init_new_context

Use at your own risk - it boots and runs skas mode guest here ;)

~mc


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
