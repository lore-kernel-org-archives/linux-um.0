Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRSSl-0003E0-3H for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 04:47:59 -0700
Received: from aa014msr.fastwebnet.it ([85.18.95.74])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GRSSi-0002og-H0
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Sep 2006 04:47:59 -0700
Date: Sun, 24 Sep 2006 13:46:39 +0200
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20060924114638.GB27881@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] 2.6.18 SKAS patch fails to apply (1 failed HUNK)
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
To: UML-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Paolo Giarrusso <blaisorblade@yahoo.it>

Hello Paolo,

with the following change the patch applies and hopefully works, still
building here but mm/fremap.o is done so I'm quite optimistic :) (__prot
is used in the code, not prot).

NOTE: I hope sourceforge smtp won't reject my message...

--- ./skas-2.6.18-rc4-v9-pre9-fremap.patch.orig	2006-09-24 12:37:57.000000000 +0200
+++ ./skas-2.6.18-rc4-v9-pre9-fremap.patch	2006-09-24 13:03:18.000000000 +0200
@@ -1454,7 +1454,7 @@
   */
 -asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 +long __remap_file_pages(struct mm_struct *mm, unsigned long start, unsigned long size,
- 	unsigned long prot, unsigned long pgoff, unsigned long flags)
+ 	unsigned long __prot, unsigned long pgoff, unsigned long flags)
  {
 -	struct mm_struct *mm = current->mm;
  	struct address_space *mapping;

-- 
mattia
:wq!

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
