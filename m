Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CBbo7-0007dn-F4 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 09:23:27 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CBbo5-0007ke-Sb for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Sep 2004 09:23:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 2B555232FA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 18:23:24 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25525-46
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 18:23:21 +0200 (CEST)
Received: from [10.0.6.6] (pD9F632E1.dip.t-dialin.net [217.246.50.225])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 01C412326D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 26 Sep 2004 18:23:20 +0200 (CEST)
Message-ID: <41570919.3020403@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] java does not run in 2.6.8.1
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
Date: Sun, 26 Sep 2004 18:23:21 +0000
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

using 2.6.8.1 (+latest incremental patches) as guest, ibm java 1.4.2 
does not work.

daeron:/usr/local/lib/jre/bin# strace ./java
execve("./java", ["./java"], [/* 17 vars */]) = 0
set_thread_area({entry_number:-1 -> 0, base_addr:0x4017d5a0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0,useable:1}) = 123
set_thread_area({entry_number:-1 -> 0, base_addr:0x4017d6e0, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0,useable:1}) = 123
JVMDG218: JVM is not fully initialized - will not do dump processing.
+++ killed by SIGSEGV +++

If I boot that filesystem with 2.4.24 java works normally.

If I remove /lib/tls , it works also.

/sebastian



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
