Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1cjiJC-0007Wq-EV
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Mar 2017 08:11:26 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cjiJB-0001Ld-44
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Mar 2017 08:11:26 +0000
References: <20170302122200.0b261620@gmail.com>
	<7272a131-6167-6fed-5cdd-1cee80176a09@nod.at>
	<20170302141640.7cc2c691@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <382a3365-90f8-e813-3ee2-f1e39bab9f45@nod.at>
Date: Fri, 3 Mar 2017 09:11:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170302141640.7cc2c691@gmail.com>
Subject: Re: [uml-devel] [PATCH v2] um: Set number of CPUs
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
To: Nikola Kotur <kotnick@gmail.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Nikola,

Am 02.03.2017 um 14:16 schrieb Nikola Kotur:
> Define NR_CPUS required by the timer subsystem.
> 
> Fixes this make warning:
> 
>     scripts/kconfig/conf  --oldconfig arch/x86/um/Kconfig
>     kernel/time/Kconfig:155:warning: range is invalid
> 
> Signed-off-by: Nikola Kotur <kotnick@gmail.com>

Looks good!

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

