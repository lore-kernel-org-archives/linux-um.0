Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1PJ4j3-000227-LN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 13:40:33 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PJ4j1-0003oA-SL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Nov 2010 13:40:33 +0000
Received: by pwi8 with SMTP id 8so824055pwi.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 18 Nov 2010 05:40:26 -0800 (PST)
Date: Thu, 18 Nov 2010 21:43:24 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Message-ID: <20101118134324.GA3800@hack>
References: <AANLkTi=xJb1LcGXeCcd_tJ+Q9vV5W4z3M-up_mrKeV9q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=xJb1LcGXeCcd_tJ+Q9vV5W4z3M-up_mrKeV9q@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 1/2] uml: Safely iterate list of winch
	handlers in line	driver.
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
To: Will Newton <will.newton@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel list <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 13, 2010 at 05:44:28PM +0000, Will Newton wrote:
>unregister_winch should use list_for_each_safe, as it can
>potentially delete from the list.
>
>Signed-off-by: Will Newton <will.newton@gmail.com>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton

Thanks.

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

