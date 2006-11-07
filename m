Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhWhY-00029T-FX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 11:33:40 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GhWhV-0005iZ-Pj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 11:33:40 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GhWhB-000601-Ky for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Nov 2006 20:33:18 +0100
Received: from dhcp65-62.ietf67.org ([130.129.65.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 07 Nov 2006 20:33:17 +0100
Received: from mcr by dhcp65-62.ietf67.org with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 07 Nov 2006 20:33:17 +0100
From: Michael Richardson <mcr@sandelman.ca>
Date: Tue, 07 Nov 2006 11:32:38 -0800
Message-ID: <eiqn0p$c0q$1@sea.gmane.org>
References: <eilvlj$b5r$1@sea.gmane.org> <eioacp$m4r$1@sea.gmane.org>
	<eiobbh$oq4$1@sea.gmane.org>
Mime-Version: 1.0
In-Reply-To: <eiobbh$oq4$1@sea.gmane.org>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


A UML built on debian sarge (machine name cassidy), (gcc-3.3.5, libc-2.3.2) works.
The same code built on debian etch (machine name marajade) (gcc-3.3.6 or gcc-4.1.2, glibc-2.3.6) fails.

A kernel built on the cassidy machine runs more successfully on the marajade machine.
It does fail when shutting down, which it didn't on cassidy.

I conclude that it may well be that my host kernel on marade is at fault.





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
