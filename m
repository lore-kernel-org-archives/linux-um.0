Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C04Z2-0004uq-9m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 13:40:12 -0700
Received: from ip-217-18-179-10.reverse.dsi.net ([217.18.179.10]
	helo=sindar.exse.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C04Z0-0006Wp-Qw for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 25 Aug 2004 13:40:12 -0700
Received: from localhost (localhost [127.0.0.1])
	by sindar.exse.net (Postfix) with ESMTP id EE53422B69
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Aug 2004 22:40:05 +0200 (CEST)
Received: from sindar.exse.net ([127.0.0.1])
	by localhost (sindar [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10772-36
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Aug 2004 22:40:05 +0200 (CEST)
Received: from [10.0.6.6] (pD9F6300D.dip.t-dialin.net [217.246.48.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sindar.exse.net (Postfix) with ESMTP id E775C219C2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 25 Aug 2004 22:40:04 +0200 (CEST)
Message-ID: <412CF94A.1030607@exse.net>
From: Sebastian <seb@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] crash with 2.6.7-bb6
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
Date: Wed, 25 Aug 2004 22:40:42 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

this happend with uml-2.5.6-bb6 :

(machine was idle, maybe some http traffic)

KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)
KERNEL: assertion (!atomic_read(&sk->sk_wmem_alloc)) failed at 
net/unix/af_unix.c (333)

more information necessary ?


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
