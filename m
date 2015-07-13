Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <toralf.foerster@gmx.de>) id 1ZEfqK-00055o-UC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 15:40:32 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEfqK-0000ki-2Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 15:40:32 +0000
Received: from [192.168.178.24] ([85.176.185.111]) by mail.gmx.com (mrgmx001)
	with ESMTPSA (Nemesis) id 0M6zkD-1Z24wW1s05-00wjvg for
	<user-mode-linux-devel@lists.sourceforge.net>; Mon, 13 Jul 2015 17:40:25
	+0200
References: <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>
	<55A3A5E0.8030802@nod.at> <DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>
	<CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>
	<DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>
	<CAMuHMdWNE86shNgXqs8ZWJXeUf1L8eqK41GDfYvCHdFHefz9Kw@mail.gmail.com>
From: =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <55A3DBE3.8090304@gmx.de>
Date: Mon, 13 Jul 2015 17:40:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWNE86shNgXqs8ZWJXeUf1L8eqK41GDfYvCHdFHefz9Kw@mail.gmail.com>
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
Subject: Re: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: user-mode-linux-devel@lists.sourceforge.net

On 07/13/2015 05:26 PM, Geert Uytterhoeven wrote:
>         smtpencryption = ssl
I do have :
smtpencryption = tls


-- 
Toralf, pgp key: 872AE508 0076E94E

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

