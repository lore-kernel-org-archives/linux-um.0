Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1Z8DzG-00007H-Ci
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2015 20:43:06 +0000
Received: from mail-vn0-f44.google.com ([209.85.216.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z8DzF-0006W5-Nk
	for User-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Jun 2015 20:43:06 +0000
Received: by vnav203 with SMTP id v203so12800624vna.8
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Thu, 25 Jun 2015 13:43:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
References: <1434014960-14774-1-git-send-email-hwhilse@gmail.com>
Date: Thu, 25 Jun 2015 22:42:59 +0200
Message-ID: <CAFLxGvzNcQYhO9a3Ndov1kxKPv_ZWZttHBsLtru=iBouGatU-A@mail.gmail.com>
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
Subject: Re: [uml-devel] [PATCH v2 0/3] musl compatibility patches
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <User-mode-linux-devel@lists.sourceforge.net>

On Thu, Jun 11, 2015 at 11:29 AM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> This set of patches facilitate compilation with the musl libc,
> either linked to shared libraries or static.
>
> Hans-Werner Hilse (3):
>   um: Do not use __ptr_t type for stack_t's .ss pointer
>   um: Do not use stdin and stdout identifiers for struct members
>   um: Include sys/types.h for makedev(), major(), minor()

All three patches applied. :-)

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

