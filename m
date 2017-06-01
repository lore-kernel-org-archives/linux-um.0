Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dGWRB-0008Ly-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 20:11:17 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dGWR9-0002dS-6F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2017 20:11:17 +0000
References: <20170524003232.14319-1-f.fainelli@gmail.com>
	<e2c13a8b-d0c3-74d1-dd1b-53a56f609c76@nod.at>
	<9f58b41d-ebe4-62a6-1aa4-e9222372ce86@gmail.com>
	<408132c9-6d55-7cba-e09a-f532d7fb9c6f@gmail.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <9617f203-cee2-96cf-aa76-8f42b1a4a9f6@nod.at>
Date: Thu, 1 Jun 2017 22:11:05 +0200
MIME-Version: 1.0
In-Reply-To: <408132c9-6d55-7cba-e09a-f532d7fb9c6f@gmail.com>
Subject: Re: [uml-devel] [PATCH v2] um: Avoid longjmp/setjmp symbol clashes
 with libpthread.a
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
To: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, "open list:USER-MODE LINUX (UML)" <user-mode-linux-user@lists.sourceforge.net>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Florian,

Am 01.06.2017 um 21:38 schrieb Florian Fainelli:
>> Presumably because we are not using the same glibc version? The one I
>> have installed on this machine is glibc-2.12, do you want me to attach a
>> copy of it?
> 
> Richard, what do we do with this?

I'd like to see the issues that Thomas sees also get addressed.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

