Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Tgh4P-0007WQ-1z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 19:25:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tgh4M-0007Ur-U0
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 19:25:17 +0000
In-Reply-To: <20121206185742.GA2175@netboy.at.omicron.at>
References: <1354807505-21222-1-git-send-email-paul.chavent@onera.fr>
	<20121206185742.GA2175@netboy.at.omicron.at>
MIME-Version: 1.0
From: Richard Weinberger <richard@nod.at>
Date: Thu, 06 Dec 2012 20:25:27 +0100
Message-ID: <c4e79fec-779a-4ddf-8330-87e54486b4f8@email.android.com>
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
Subject: Re: [uml-devel] [PATCH] net : enable tx time stamping in the vde
	driver.
To: Richard Cochran <richardcochran@gmail.com>, Paul Chavent <Paul.Chavent@onera.fr>
Cc: netdev@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net



Richard Cochran <richardcochran@gmail.com> schrieb:

>On Thu, Dec 06, 2012 at 04:25:05PM +0100, Paul Chavent wrote:
>> This new version moves the skb_tx_timestamp in the main uml
>> driver. This should avoid the need to call this function in each
>> transport (vde, slirp, tuntap, ...). It also add support for ethtool
>> get_ts_info.
>> 
>> Signed-off-by: Paul Chavent <paul.chavent@onera.fr>
>
>Acked-by: Richard Cochran <richardcochran@gmail.com>

Queued for 3.8.

Thanks,
//richard

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

