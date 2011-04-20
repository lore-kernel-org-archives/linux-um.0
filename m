Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard@nod.at>) id 1QCfbQ-000493-Iv
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2011 22:10:28 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QCfbO-0006r5-Rs
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 20 Apr 2011 22:10:28 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Apr 2011 00:10:04 +0200
References: <201104131258.46657.richard@nod.at>
	<1303173986-21430-1-git-send-email-nolan@cumulusnetworks.com>
In-Reply-To: <1303173986-21430-1-git-send-email-nolan@cumulusnetworks.com>
MIME-Version: 1.0
Message-Id: <201104210010.04410.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um: Add a "ucast" ethernet transport.
To: Nolan Leake <nolan@cumulusnetworks.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nolan Leake <nolan@sigbus.net>, user-mode-linux-devel@lists.sourceforge.net

Am Dienstag 19 April 2011, 02:46:26 schrieb Nolan Leake:
> From: Nolan Leake <nolan@sigbus.net>
> 
> The "ucast" transport is similar to the mcast transport (and, in fact,
> shares most of its code), only it uses UDP unicast to move packets.
> 
> Obviously this is only useful for point-to-point connections between
> virtual ethernet devices.
> 
> Signed-off-by: Nolan Leake <nolan@cumulusnetworks.com>
> ---
>  Documentation/uml/UserModeLinux-HOWTO.txt |   10 ++
>  arch/um/drivers/Makefile                  |    4 +-
>  arch/um/drivers/mcast.h                   |   24 ----
>  arch/um/drivers/mcast_kern.c              |  120 ------------------
>  arch/um/drivers/mcast_user.c              |  165 -------------------------
>  arch/um/drivers/umcast.h                  |   27 ++++
>  arch/um/drivers/umcast_kern.c             |  188
> +++++++++++++++++++++++++++++ arch/um/drivers/umcast_user.c             | 
> 186 ++++++++++++++++++++++++++++ 8 files changed, 413 insertions(+), 311
> deletions(-)
>  delete mode 100644 arch/um/drivers/mcast.h
>  delete mode 100644 arch/um/drivers/mcast_kern.c
>  delete mode 100644 arch/um/drivers/mcast_user.c
>  create mode 100644 arch/um/drivers/umcast.h
>  create mode 100644 arch/um/drivers/umcast_kern.c
>  create mode 100644 arch/um/drivers/umcast_user.c
> 

One small nit-pick, please use "git format-patch --find-renames ...".
Otherwise tools like git-blame will produce bad results.

Thanks,
//richard

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

