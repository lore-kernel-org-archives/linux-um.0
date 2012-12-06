Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richardcochran@gmail.com>) id 1TgVNW-0004se-W2
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 06:56:15 +0000
Received: from mail-ea0-f175.google.com ([209.85.215.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TgVNU-0002Fv-UC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2012 06:56:14 +0000
Received: by mail-ea0-f175.google.com with SMTP id h11so2411341eaa.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 05 Dec 2012 22:56:06 -0800 (PST)
Date: Thu, 6 Dec 2012 07:55:59 +0100
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20121206065558.GA2700@netboy.at.omicron.at>
References: <1354717253-8737-1-git-send-email-paul.chavent@onera.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1354717253-8737-1-git-send-email-paul.chavent@onera.fr>
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
Subject: Re: [uml-devel] [PATCH] net: fixup tx time stamping for uml vde
	driver.
To: Paul Chavent <Paul.Chavent@onera.fr>
Cc: richard@nod.at, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, netdev@vger.kernel.org

On Wed, Dec 05, 2012 at 03:20:53PM +0100, Paul Chavent wrote:
> Call skb_tx_timestamp after write completion.
> 
> Signed-off-by: Paul Chavent <paul.chavent@onera.fr>

The subject line would better describe the changes if it would read,
"enable tx time stamping in the uml vde driver."

Can you please also add support for ethtool get_ts_info?

Thanks,
Richard

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

