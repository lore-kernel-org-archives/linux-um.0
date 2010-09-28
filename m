Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <davem@davemloft.net>) id 1P0hHM-0000LK-Pt
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:00:00 +0000
Received: from 74-93-104-97-washington.hfc.comcastbusiness.net ([74.93.104.97]
	helo=sunset.davemloft.net)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0hHL-0008FB-JC for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:00:00 +0000
Date: Tue, 28 Sep 2010 14:00:14 -0700 (PDT)
Message-Id: <20100928.140014.115950817.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
References: <AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928134721.f79a5955.akpm@linux-foundation.org>
	<AANLkTi=E7+CpJZE3XC7O1LvJu6LWfmvSxonskH4CYg25@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: torvalds@linux-foundation.org
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, julia@diku.dk, akpm@linux-foundation.org, shemminger@vyatta.com

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Sep 2010 13:57:04 -0700

> So perhaps something like the attached patch would make it work, and
> have the locking in place that apparently people think it should have?

I'm fine with this if it works:

Acked-by: David S. Miller <davem@davemloft.net>

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

