Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z8ugA-000664-Jm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Jun 2015 18:18:14 +0000
Received: from mail-vn0-f48.google.com ([209.85.216.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z8ug9-0001gc-UZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Jun 2015 18:18:14 +0000
Received: by vnbg129 with SMTP id g129so19484752vnb.9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 27 Jun 2015 11:18:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
References: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
Date: Sat, 27 Jun 2015 20:18:08 +0200
Message-ID: <CAFLxGvxMttkMFkm9CuQUmDfbaYLpMmCX1Hy0B_VDzpX2-LNX-A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] missed musl compatibility patch
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Jun 26, 2015 at 10:36 AM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> I'm sorry but one patch that is necessary for compilation against
> musl libc was still missing in the series I sent earlier.
> (Thank you very much for applying!)

Okay. We can merge it for -rc2.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

