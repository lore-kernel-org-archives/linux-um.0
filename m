Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1b46QH-0000pI-0K
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 12:54:29 +0000
Received: from mx0a-000f0801.pphosted.com ([67.231.144.122])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b46QF-0001w1-3s
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 May 2016 12:54:28 +0000
Received: from pps.filterd (m0048193.ppops.net [127.0.0.1])
	by mx0a-000f0801.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
	u4LCV2ea028628 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 May 2016 05:54:21 -0700
Received: from brmwp-exmb12.corp.brocade.com ([208.47.132.227])
	by mx0a-000f0801.pphosted.com with ESMTP id 232pd7g6bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 21 May 2016 05:54:21 -0700
From: Anton Ivanov <aivanov@Brocade.com>
Date: Sat, 21 May 2016 12:54:17 +0000
Message-ID: <57405A7B.2050309@brocade.com>
References: <20160521121106.13904-1-andrea.gelmini@gelma.net>
In-Reply-To: <20160521121106.13904-1-andrea.gelmini@gelma.net>
Content-Language: en-US
Content-ID: <6A4E59D96FEBC640ABD28BD2176E2272@brocade.local>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 0263/1529] Fix typo
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
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On 21/05/16 13:11, Andrea Gelmini wrote:
> Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
> ---
>   arch/um/os-Linux/time.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
> index 0e39b99..6caa556 100644
> --- a/arch/um/os-Linux/time.c
> +++ b/arch/um/os-Linux/time.c
> @@ -91,7 +91,7 @@ int os_timer_set_interval(void* timer, void* i)
>   /**
>    * os_timer_remain() - returns the remaining nano seconds of the given interval
>    *                     timer
> - * Because this is the remaining time of an interval timer, which correspondends
> + * Because this is the remaining time of an interval timer, which correspondences

corresponds.

>    * to HZ, this value can never be bigger than one second. Just
>    * the nanosecond part of the timer is returned.
>    * The returned time is relative to the start time of the interval timer.

------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

