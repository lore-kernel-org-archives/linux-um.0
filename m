Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1XfVDC-0003Nh-Oz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Oct 2014 14:42:30 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XfVD9-0000eV-L4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Oct 2014 14:42:30 +0000
Message-ID: <54427C48.9050608@nod.at>
Date: Sat, 18 Oct 2014 16:42:16 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <544277C5.9030302@gmx.at>
In-Reply-To: <544277C5.9030302@gmx.at>
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
Subject: Re: [uml-devel] [PATCH] um: Remove unused bp stack-frame pointer
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-user@lists.sourceforge.net, Randy Dunlap <rdunlap@infradead.org>, Daniel Walter <dwalter@google.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Am 18.10.2014 um 16:23 schrieb Manfred Schlaegl:
> The pointer to bp stack-frame is no longer used. Removed it.

Good catch!

> This also removes a corresponding compiler-warning.

Which warning exactly?

Thanks,
//richard

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

