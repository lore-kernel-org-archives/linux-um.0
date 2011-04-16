Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <walch.martin@web.de>) id 1QB68K-0007Cg-Ro
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 14:05:56 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QB68I-0000qf-Hk for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 14:05:56 +0000
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9B44F18C2A60A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 16 Apr 2011 16:05:48 +0200 (CEST)
Received: from [46.223.68.51] (helo=tacticalops.localnet)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256) (WEB.DE 4.110 #2)
	id 1QB68C-0003W2-00 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Apr 2011 16:05:48 +0200
From: Martin Walch <walch.martin@web.de>
Date: Sat, 16 Apr 2011 16:04:17 +0200
MIME-Version: 1.0
Message-Id: <201104161604.18054.walch.martin@web.de>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] Linux Kernel Bug #32812 "ARCH=um,
	SUBARCH=i386: linking failure"
To: user-mode-linux-devel@lists.sourceforge.net

Hello UML maintainers,

I have run into a problem making a uml kernel for SUBARCH=i386 with support 
for XFS. This looks like a regression. Can you please take a look at

https://bugzilla.kernel.org/show_bug.cgi?id=32812

Thank you.

Martin Walch
-- 

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

