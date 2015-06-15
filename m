Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Z4VhN-0006B8-20
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Jun 2015 14:49:17 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z4VhL-0001Hd-NI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Jun 2015 14:49:17 +0000
Message-ID: <557EE5E2.7080409@nod.at>
Date: Mon, 15 Jun 2015 16:49:06 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1434379436-8301-1-git-send-email-firogm@gmail.com>
In-Reply-To: <1434379436-8301-1-git-send-email-firogm@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] um: Fix a build error
To: Firo Yang <firogm@gmail.com>, jdike@addtoit.com
Cc: kernel-janitors@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

Am 15.06.2015 um 16:43 schrieb Firo Yang:
> Gcc5 failed to build uml.
> Update codes to test __GNUC__ with 5 will be happier.
> 
> Signed-off-by: Firo Yang <firogm@gmail.com>

The issue got already addressed by patches:
[PATCH 2/5] um: Stop abusing __KERNEL__
[PATCH 3/5] um: Remove copy&paste code from init.h

They will appear soon in Linus' tree.

Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

