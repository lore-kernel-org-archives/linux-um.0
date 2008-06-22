Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KAMeF-00015A-2u for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 03:18:15 -0700
Received: from an-out-0708.google.com ([209.85.132.249])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KAMeC-00007H-At
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Jun 2008 03:18:14 -0700
Received: by an-out-0708.google.com with SMTP id b21so472889ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Jun 2008 03:18:11 -0700 (PDT)
Message-ID: <fc593b510806220318q7cca3494lc7bbb36637d3aa47@mail.gmail.com>
Date: Sun, 22 Jun 2008 12:18:10 +0200
From: "Laurent Wandrebeck" <l.wandrebeck@gmail.com>
In-Reply-To: <20080621223401.C97C.WEIYI.HUANG@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080621223401.C97C.WEIYI.HUANG@gmail.com>
Subject: Re: [uml-devel] [uml-user] arch/um/os-Linux/helper.c: Removed
	duplicated include
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

2008/6/21 Huang Weiyi <weiyi.huang@gmail.com>:
> Removed duplicated include file <linux/limits.h> in
> arch/um/os-Linux/helper.c.
>
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
Thanks for spotting it, I added your patch to my tree.
You can git clone
git://gitorious.org/low-unofficial-linux-uml-hacking-tree/mainline.git
or http://git.gitorious.org/low-unofficial-linux-uml-hacking-tree/mainline.git
if you're willing to test latest linus-git tree plus skas4.
Regards,
Laurent.

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
