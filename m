Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hwhilse@gmail.com>) id 1Z9TIC-0008UT-35
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 07:15:48 +0000
Received: from hilses.de ([213.133.103.163])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z9TIA-00062m-OX
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 07:15:48 +0000
Received: from [10.0.0.1] (helo=localhost) by hilses.de with esmtpa (Exim 4.85)
	(envelope-from <hwhilse@gmail.com>) id 1Z9TIC-00074o-QN
	for User-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 09:15:48 +0200
MIME-Version: 1.0
Date: Mon, 29 Jun 2015 09:15:48 +0200
From: Hans-Werner Hilse <hwhilse@gmail.com>
In-Reply-To: <CAFLxGvxMttkMFkm9CuQUmDfbaYLpMmCX1Hy0B_VDzpX2-LNX-A@mail.gmail.com>
References: <1435307774-3897-1-git-send-email-hwhilse@gmail.com>
	<CAFLxGvxMttkMFkm9CuQUmDfbaYLpMmCX1Hy0B_VDzpX2-LNX-A@mail.gmail.com>
Message-ID: <3faa85268de72e64ff74175f2cf74021@hilses.de>
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
To: User-mode-linux Devel <User-mode-linux-devel@lists.sourceforge.net>

Hi,

Am 2015-06-27 20:18, schrieb Richard Weinberger:
> On Fri, Jun 26, 2015 at 10:36 AM, Hans-Werner Hilse <hwhilse@gmail.com> 
> wrote:
>> I'm sorry but one patch that is necessary for compilation against
>> musl libc was still missing in the series I sent earlier.
>> (Thank you very much for applying!)
> 
> Okay. We can merge it for -rc2.

Please ignore for now, I need to fix this patch, unfortunately.
As it is, it breaks compilation on a much more important target - glibc.
I'll send a v2 once I got this right.

-hwh

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

