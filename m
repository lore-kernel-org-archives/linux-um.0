Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCeGA-00006h-DW for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 05:44:58 -0800
Received: from lea.cs.unibo.it ([130.136.1.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DCeG6-0003iH-T3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2005 05:44:58 -0800
Received: from [137.204.150.59] (unknown [137.204.150.59])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by lea.cs.unibo.it (Postfix) with ESMTP id B3F3C8B42F
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 19 Mar 2005 14:44:46 +0100 (CET)
Message-ID: <423C2CCC.9040809@cs.unibo.it>
From: Mattia Belletti <mbellett@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Getting fault address from a SIGSEGV
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
Date: Sat, 19 Mar 2005 14:44:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi all, 

   For a project I'm working on, I would need to get the fault address of
a ptraced child, whose SIGSEGV I've caught. I've tried to dig in UML 
source code to get how this is done, but I get lost after having 
followed the chain segv_handler <- sig_info <- sig_handler_common_tt <-
"r = &TASK_REGS(get_current())->tt;", since there the status I was 
looking for is stored in the thread_struct.regs, but I don't know where 
in the code such status is filled, and so where such information is 
taken from :-)
 

Hope you can light my way through the code ;-) 


-- 
Mat/tia Belletti             - Graduate student @ cs.unibo.it
ICQ: 33292311                - email: mbellett@cs.unibo.it
IRC: RedGlow                 - site(s): http://mbellett.web.cs.unibo.it/
RedGlow@jabber.linux.it/Gaim - Linux user 299762 @ machine 213003


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
