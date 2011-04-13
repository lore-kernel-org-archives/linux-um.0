Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <richard@nod.at>) id 1Q9xmn-0003JN-5Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 10:59:01 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Q9xmh-0003BC-0e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Apr 2011 10:59:01 +0000
From: Richard Weinberger <richard@nod.at>
Date: Wed, 13 Apr 2011 12:58:46 +0200
References: <1302652293.17952.33.camel@voxel>
In-Reply-To: <1302652293.17952.33.camel@voxel>
MIME-Version: 1.0
Message-Id: <201104131258.46657.richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um: Add a "ucast" ethernet transport
To: Nolan Leake <nolan@cumulusnetworks.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Hi,

Am Mittwoch 13 April 2011, 01:51:33 schrieb Nolan Leake:
> The "ucast" transport is similar to the mcast transport (and, in fact,
> shares most of its code), only it uses UDP unicast to move packets.
> 
> Obviously this is only useful for point-to-point connections between
> virtual ethernet devices.
> 
> Signed-off-by: Nolan Leake <nolan@cumulusnetworks.com>
> ---
>  Documentation/uml/UserModeLinux-HOWTO.txt |   10 +++
>  arch/um/drivers/mcast.h                   |    7 ++-
>  arch/um/drivers/mcast_kern.c              |   82 +++++++++++++++++++--
>  arch/um/drivers/mcast_user.c              |  113
> +++++++++++++++++------------ 4 files changed, 157 insertions(+), 55
> deletions(-)
> 

Sorry, your mailer screwed the patch.
Please use git send-email.

With your patch drivers/mcast* would contain unicast stuff.
This is a bit confusing.
Either rename the mcast files or put everything which have mcast 
and ucast in common into a separate file.

Are you using this patch in a production environment?

Thanks,
//richard

------------------------------------------------------------------------------
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

