Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZeWl-000474-T5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:13:27 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZeWh-0004hw-9C
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 17:13:27 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jA92kTHr017434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 8 Nov 2005 21:46:29 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200511081913.14657.rob@landley.net>
Subject: [uml-devel] Test for ethernet broadcast address?
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
Date: Tue, 8 Nov 2005 19:13:14 -0600
To: user-mode-linux-devel@lists.sourceforge.net

So I'm trying to play with ifenslave under UML, and my naieve attempt to go

./linux LD_ASSUME_KERNEL=2.4.1 eth0=daemon,11:11:11:11:11:11 \ 
eth1=daemon,22:22:22:22:22:22 rootfstype=hostfs rw init=/bin/sh

Led to unexpected results that eth0 had a mac addr of 00:00:00:00:00:00.  
Eventually, I tracked it down to this test in arch/um/drivers/net_kern.c:
if(addr[0] & 1){
        printk(KERN_ERR
               "Attempt to assign a broadcast ethernet address to a "
               "device disallowed\n");
        return(0);
}

My question is: where's the spec for what is and isn't a broadcast address?

RFC 894 says that "the" ethernet broadcast address is (only) FF:FF:FF:FF:FF:FF
http://www.freesoft.org/CIE/RFC/894/

So does Ethereal's wiki:
http://wiki.ethereal.com/Ethernet

Confused?

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
