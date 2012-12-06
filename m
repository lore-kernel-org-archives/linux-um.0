Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richardcochran@gmail.com>) id 1Tgge1-0005fg-73
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 18:58:01 +0000
Received: from mail-ee0-f47.google.com ([74.125.83.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Tggdz-0006op-0N
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 18:58:01 +0000
Received: by mail-ee0-f47.google.com with SMTP id e51so3907606eek.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 06 Dec 2012 10:57:52 -0800 (PST)
Date: Thu, 6 Dec 2012 19:57:43 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20121206185742.GA2175@netboy.at.omicron.at>
References: <1354807505-21222-1-git-send-email-paul.chavent@onera.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1354807505-21222-1-git-send-email-paul.chavent@onera.fr>
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
To: Paul Chavent <Paul.Chavent@onera.fr>
Cc: richard@nod.at, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org

On Thu, Dec 06, 2012 at 04:25:05PM +0100, Paul Chavent wrote:
> This new version moves the skb_tx_timestamp in the main uml
> driver. This should avoid the need to call this function in each
> transport (vde, slirp, tuntap, ...). It also add support for ethtool
> get_ts_info.
> 
> Signed-off-by: Paul Chavent <paul.chavent@onera.fr>

Acked-by: Richard Cochran <richardcochran@gmail.com>

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

