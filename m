Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G6WdE-0001nB-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jul 2006 11:00:17 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1G6Vxp-0004CW-E8 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jul 2006 10:17:29 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G5T4m-0007rn-7X
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jul 2006 13:00:25 -0700
Received: from slartibartfast.pa.net ([66.59.111.182])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1G5Rlj-0003DX-5t for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Jul 2006 11:36:37 -0700
Date: Tue, 25 Jul 2006 14:35:26 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.64.0607251401110.3223@sparrow>
MIME-Version: 1.0
Subject: [uml-devel] building 2.6.18-rc2 with Jeff's 2.6.17 patchset,
	add-stub-vmas patch issue
Reply-To: William Stearns <wstearns@pobox.com>
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
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Jeff Dike <jdike@addtoit.com>, William Stearns <wstearns@pobox.com>

Good afternoon, all,
 	A few of the patches don't apply - I skipped those.
 	Of those that do, it _looks_ like Bodo's add-stub-vmas.patch has 
an issue:

   LD      init/built-in.o
   LD      .tmp_vmlinux1
arch/um/sys-i386/built-in.o: In function `gate_vma_init':
arch/um/sys-i386/gate_vma.c:116: undefined reference to `proc_pid_maps_op'
arch/um/sys-i386/gate_vma.c:117: undefined reference to `proc_pid_maps_op'
arch/um/sys-i386/gate_vma.c:118: undefined reference to `proc_pid_maps_op'
arch/um/sys-i386/gate_vma.c:119: undefined reference to `proc_pid_maps_op'
collect2: ld returned 1 exit status
   KSYM    .tmp_kallsyms1.S
nm: '.tmp_vmlinux1': No such file
No valid symbol.
make: *** [.tmp_kallsyms1.S] Error 1

 	Reverting the patch allows the build to successfully finish.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
 	"Computers save time like kudzu prevents soil erosion."
(Courtesy of Al Castanoli <afn22800@afn.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
