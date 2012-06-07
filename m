Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@sigma-star.at>) id 1Scm5d-0003hq-Ti
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 23:26:05 +0000
Received: from meriadoc.sigma-star.at ([178.63.61.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Scm5c-0008E1-KG
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Jun 2012 23:26:05 +0000
Received: from [95.130.255.111] (helo=mail.sigma-star.at)
	by meriadoc.sigma-star.at with esmtp (Exim 4.63)
	(envelope-from <richard@sigma-star.at>) id 1ScsSD-0007JU-2G
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jun 2012 08:13:49 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sigma-star.at (Postfix) with ESMTP id B406C16B402D
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  8 Jun 2012 00:16:49 +0200 (CEST)
Received: from mail.sigma-star.at ([127.0.0.1])
	by localhost (mail.sigma-star.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9vamkIptWQDx
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  8 Jun 2012 00:16:49 +0200 (CEST)
Received: from [192.168.0.2] (178-191-102-27.adsl.highway.telekom.at
	[178.191.102.27])
	by mail.sigma-star.at (Postfix) with ESMTPSA id 02CB016B402B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  8 Jun 2012 00:16:48 +0200 (CEST)
Message-ID: <4FD12850.5080004@sigma-star.at>
Date: Fri, 08 Jun 2012 00:16:48 +0200
From: Richard Weinberger <richard@sigma-star.at>
MIME-Version: 1.0
References: <4FD0BD2F.4090002@gmail.com>
In-Reply-To: <4FD0BD2F.4090002@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: fix ubd_file_size for read-only files
To: user-mode-linux-devel@lists.sourceforge.net

Am 07.06.2012 16:39, schrieb Martin P=E4rtel:
> Made ubd_file_size not request write access. Fixes use of read-only image=
s.
> =

> Signed-off-by: Martin P=E4rtel <martin.partel@gmail.com>

Applied!

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

