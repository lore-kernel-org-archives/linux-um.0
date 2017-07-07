Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dTbSJ-0001c6-Ct
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 22:10:31 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dTbSF-0001Ah-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 22:10:31 +0000
References: <CAFLxGvypP43dRGJDkMU+4OojDDrwC+7eX3uq0pH+9He6EEBfKQ@mail.gmail.com>
	<20170707211013.17956-1-thomas@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <195e897b-34db-f29f-fdff-f2c86ce86193@nod.at>
Date: Sat, 8 Jul 2017 00:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170707211013.17956-1-thomas@m3y3r.de>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH] um: Fix gcc-plugins dependency
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>, user-mode-linux-devel@lists.sourceforge.net

Thomas,

Am 07.07.2017 um 23:10 schrieb Thomas Meyer:
> Ensure to build the gcc-plugins for user-offsets.s
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

Please describe the problem what this commit solves.
IOW the compiler error.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

