Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Ab0LS-0007Sl-3p
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 08:34:18 -0800
Received: from mx15.sac.fedex.com ([199.81.197.54])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1Ab0LR-0006Ck-Nl
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Dec 2003 08:34:17 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx15.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id hBTGYB1j002290
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Dec 2003 10:34:11 -0600 (CST)
	(envelope-from jchua@fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.10/8.12.10) with ESMTP id hBTGY9N9006016
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Dec 2003 10:34:10 -0600 (CST)
Received: from silk.corp.fedex.com (silk.corp.fedex.com [155.161.201.173])
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id hBTGWY025269
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 30 Dec 2003 00:32:34 +0800
From: Jeff Chua <jchua@fedex.com>
Message-ID: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Kernel mode fault at addr 0x48965000, ip 0x400e51a4
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Dec 2003 00:32:34 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


uml-patch-2.4.22-5 works fine, but newer patches fail during boot

Starting daemons: syslogd klogd inetd namedKernel panic: Kernel mode fault
at addr 0x48965000, ip 0x400e51a4


The following works ...
	uml-patch-2.4.22-5
	host 2.4.24-pre2

The following doesn't work ...
	uml-patch-2.4.23-1
	uml-patch-2.4.22-6
	uml-patch-2.4.22-7


The error is repeatable. If I don't mount lvm disks, and only uses initrd
ramdisk, the problem doesn't appear!


Thanks,
Jeff
[ jchua@fedex.com ]


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
