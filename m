Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRBMS-0001hn-FL
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 28 Apr 2005 08:55:32 -0700
Received: from moraine.clusterfs.com ([66.96.26.190])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRBMQ-000582-Pj
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 28 Apr 2005 08:55:32 -0700
Received: from [192.168.1.214] (unknown [218.247.142.130])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by moraine.clusterfs.com (Postfix) with ESMTP id 79C6131009B
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 28 Apr 2005 11:55:25 -0400 (EDT)
Message-ID: <4271073D.3030800@yahoo.com.cn>
From: "Mei,Jia" <cfs_eric@yahoo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] gdb debugging problem on uml-2.6.10
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
Date: Thu, 28 Apr 2005 23:54:37 +0800
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

When I try gdb-5.3.90 with uml in vanilla-2.6.10 kernel. I found a problem.

When I set a breakpoint somewhere, and after some step, uml will
always get a SIGTRAP signal and trap into gdb.

Does anyone met the same problem as me? Any known fix for it?

thanks!

Eric


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
