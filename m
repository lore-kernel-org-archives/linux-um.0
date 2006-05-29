Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkdMh-0001Bh-Fo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 01:44:43 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FkdMh-0003SM-JW for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 01:44:43 -0700
Received: from mail.scgiservices.com ([198.107.3.67])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FkdMg-0000UO-91
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 May 2006 01:44:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by mail.scgiservices.com (Postfix) with ESMTP id 8FB6E3C5CA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:44:41 -0700 (PDT)
Received: from mail.scgiservices.com ([127.0.0.1])
	by localhost (mail [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18053-03 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:44:40 -0700 (PDT)
Received: from SCG2 (c-67-160-154-69.hsd1.or.comcast.net [67.160.154.69])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail.scgiservices.com (Postfix) with ESMTP id 843293C590
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 May 2006 01:44:40 -0700 (PDT)
From: "Anthony Brock" <brocka@sterlingcgi.com>
Subject: RE: [uml-devel] Warnings compiling linux-2.6.17-rc5
Message-ID: <LEEIJGBJEEABAGOFFGAHKEHGDGAA.brocka@sterlingcgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20060529032647.GA4907@ccure.user-mode-linux.org>
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
Date: Mon, 29 May 2006 01:44:40 -0700
To: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

> -----Original Message-----
> On Sun, May 28, 2006 at 04:50:33PM -0700, Anthony Brock wrote:
> > WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/net/ipv6/ipv6.ko
> needs unknown
> > symbol strcpy
>
> This is fixed in my current tree.

Before I forget, this warning is still occurring even after applying the
patches mentioned in my previous post. Is there a different tree I should be
patching from? Or is this tree the correct one for testing your patches? Or
does this lag your "current" tree by some time period?

Thanks,

Tony



-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
