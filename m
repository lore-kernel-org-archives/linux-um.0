Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BxPpU-0001eE-3K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 05:46:12 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BxPpR-00085x-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Aug 2004 05:46:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id 403B7217B3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 14:46:04 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00285-04
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 14:46:02 +0200 (CEST)
Received: from [10.0.2.5] (port-212-202-42-103.dynamic.qsc.de [212.202.42.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id 85B6B21791
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Aug 2004 14:46:02 +0200 (CEST)
Message-ID: <41234F99.6020208@exse.net>
From: seb <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] debug 2.6.7
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
Date: Wed, 18 Aug 2004 14:46:17 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

---------------------------
Starting MTA: exim4.
Starting PostgreSQL database server: postmaster.
Starting OpenBSD Secure Shell server: sshd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: cron.

Debian GNU/Linux 3.1 vhost tty0

vhost login: Out of Memory: Killed process 3773 (xmlhandler.fcpl).
Kernel panic: Kernel mode fault at addr 0x5be8c750, ip 0x40325b88
In interrupt handler - not syncing
 ---Type <return> to continue, or q <return> to quit---Detaching after 
fork from child process 30031.


Program exited with code 01.
(gdb)
------------------------------

how do I get a backtrace for this ?


started with:
handle SIGSEGV pass nostop noprint
handle SIGUSR1 pass nostop noprint
break panic





/sebastian


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
