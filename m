Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ahwm2-0003K9-T5 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:10:26 -0800
Received: from mailgate.uni-paderborn.de ([131.234.22.32])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Ahwm2-0007Zn-HM
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 12:10:26 -0800
Message-ID: <4009966E.6020406@upb.de>
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] cannot compile 2.6.1 uml-kernel, NPTL?
References: <bua04l$6uo$1@sea.gmane.org>
	<200401172100.36754.blaisorblade_spam@yahoo.it>
In-Reply-To: <200401172100.36754.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 17 Jan 2004 21:09:18 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

>>ld: BFD 2.14.90.0.6 20030820 assertion fail elf.c:3458
> 
> assertion failed means a bug. Would you retest with another binutils version? 
> On my system ld --version gives:

silly me, i should have realized that.

> GNU ld version 2.13.90.0.18 20030121
> 
> So probably you have a binutils bug. *Maybe* there is also something strange 
> in UML that triggers the bug, but an assertion failed is anyway a linker bug.

i will retry with binutils ...0.18, hope it helps.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
