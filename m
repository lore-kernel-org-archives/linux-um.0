Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BzBGY-00070u-9U for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 02:37:26 -0700
Received: from adsl-212-20-233-177.lumison.co.uk ([212.20.233.177]
	helo=dizzydmz.morpheux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BzBGW-0003Ns-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 Aug 2004 02:37:26 -0700
Received: from [192.168.42.3]
	(IDENT:cYFZI+zU5zZbSOwUpWnGqQNY9TKoC/O5@sue.morpheux.org
	[192.168.42.3])
	by dizzydmz.morpheux.org (8.13.1/8.13.1) with ESMTP id i7N9b9U2023782
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 23 Aug 2004 10:37:14 +0100
Message-ID: <4129BAC5.9040406@morpheux.org>
From: Faye Gibbins <wibble@morpheux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Building UML on FC2?
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
Date: Mon, 23 Aug 2004 10:37:09 +0100
To: user-mode-linux-devel@lists.sourceforge.net


Has anyone had any luck building a UML 2.6 guest kernel on a FC2 host 
system? I installed the glibc i368 package and moved /lib/tls to 
/lib/tls.off, the compile of the host skass 2.6 kernel and guest 2.6 
went fine.

However when I ran it (in skas mode) it gets to "Initializing stdio 
console driver" and it just exists, google tells me this is a NPTL 
issue. This happens even if I don't use host file system.

I have some 2.4.* guest kernels I built on FC1 and they get past this 
stage just fine when run on FC2.

So if anyone has built a guest 2.6 on FC2 and got it to work please let 
me know how?

-- 
Yours
Faye

This time she's the lesser of two evils.

http://www.morpheux.org






-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
