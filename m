Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqsxM-0002i0-0h
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 03:55:04 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Aqsvh-0007E1-Jv
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 11 Feb 2004 03:53:21 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx13.sac.fedex.com (8.12.9p2/8.12.9) with ESMTP id i1BBsFu8044428
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 11 Feb 2004 05:54:15 -0600 (CST)
	(envelope-from jeff98@silk.corp.fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.11/8.12.11) with ESMTP id i1BBsAdg000457
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 11 Feb 2004 05:54:14 -0600 (CST)
Received: from silk.corp.fedex.com (silk.corp.fedex.com [155.161.201.173])
	by silk.corp.fedex.com (8.11.4/8.11.4) with ESMTP id i1BBqe002876
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 11 Feb 2004 19:52:40 +0800
From: Jeff Chua <jeff98@silk.corp.fedex.com>
Message-ID: <Pine.LNX.4.58.0402111946490.2438@silk.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] uml for 2.6.3-rc?
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
Date: Wed, 11 Feb 2004 19:52:40 +0800 (SGT)
To: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>


Is there a clean patch for 2.6.3-rc2?

I would like to try out uml, but it seems there's so many manual patches
to apply and still don't seems to hear anyone running it.

I've tried

- linux-2.6.1-skas3.patch	seems to apply and compile fine

- uml-patch-2.6.1-1.bz2 patch failed, compile failed.

1 out of 2 hunks FAILED -- saving rejects to file fs/proc/task_mmu.c.rej
1 out of 3 hunks FAILED -- saving rejects to file mm/memory.c.rej

complained about EFAULT not defined.



Thanks,
Jeff
[ jchua@fedex.com ]


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
