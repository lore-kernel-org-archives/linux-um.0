Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WsfXu-0001tX-Ii
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2014 21:50:02 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WsfXq-0005sz-Ou
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jun 2014 21:50:00 +0000
Message-ID: <5390E5FD.5030400@nod.at>
Date: Thu, 05 Jun 2014 23:49:49 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <538F275B.7000508@nod.at>
	<1401941724-6703-1-git-send-email-enjoymindful@gmail.com>
	<1401941724-6703-2-git-send-email-enjoymindful@gmail.com>
In-Reply-To: <1401941724-6703-2-git-send-email-enjoymindful@gmail.com>
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
Subject: Re: [uml-devel] [PATCH] remove csum_partial_copy_generic_i386 to
 clean up exception table
To: Honggang Li <enjoymindful@gmail.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Am 05.06.2014 06:15, schrieb Honggang Li:
> arch/x86/um/checksum_32.S had been copy & paste from x86. When build
> x86 uml, csum_partial_copy_generic_i386 mess up the exception table.
> In fact, exception table dose not work in uml kernel.

Are you sure that exception tables do not work on UML?
I said, I'm not sure. Can you please find out?

In arch/um/kernel/trap.c:segv() we have the mechanism for it:
        else if (!is_user && arch_fixup(ip, regs))
                goto out;

The interesting question is, is this by design or was it just copy&pasted from x86
many moons ago? :)

> And csum_partial_copy_generic_i386 never been called. So, delete it.

I like such clean ups. :-)

Thanks,
//richard

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

