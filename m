Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dJ0wV-0003jx-4l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jun 2017 17:09:55 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dJ0wT-0004kS-Fp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Jun 2017 17:09:55 +0000
References: <20170608160836.12196-1-krzk@kernel.org>
	<20170608161049.12421-22-krzk@kernel.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5875db91-1eb2-3c4c-faf7-a519458c1d18@nod.at>
Date: Thu, 8 Jun 2017 19:09:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170608161049.12421-22-krzk@kernel.org>
Subject: Re: [uml-devel] [PATCH 22/35] um: defconfig: Cleanup from old
 Kconfig options
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
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>

Am 08.06.2017 um 18:10 schrieb Krzysztof Kozlowski:
> Remove old, dead Kconfig option INET_LRO. It is gone since
> commit 7bbf3cae65b6 ("ipv4: Remove inet_lro library").
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

