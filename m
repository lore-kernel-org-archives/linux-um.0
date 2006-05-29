Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FkYOc-00082B-31 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 May 2006 20:26:22 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FkYOa-0001rv-Gb
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 May 2006 20:26:22 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Warnings compiling linux-2.6.17-rc5
Message-ID: <20060529032647.GA4907@ccure.user-mode-linux.org>
References: <CBELIFGMBIEPIEOFCJFAGENACAAA.brocka@sterlingcgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CBELIFGMBIEPIEOFCJFAGENACAAA.brocka@sterlingcgi.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 28 May 2006 23:26:47 -0400
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: UML Developer's List <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 28, 2006 at 04:50:33PM -0700, Anthony Brock wrote:
> I just tried to compile a new guest kernel using the linux-2.6.17-rc5 kernel
> source and encountered the following warnings.
> WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_nosmp
> from .bss between 'stderr@@GLIBC_2.0' (at offset 0x82607c4) and
> 'completed.4463'

These I have no clue about.  I've seen them with a native build, so
they appear not to be UML-specific.  Looks like a broken linker.  The
resulting UML works fine, so this is nasty-looking, but non-fatal.

> WARNING: /mnt/lib/modules/2.6.17-rc5/kernel/net/ipv6/ipv6.ko needs unknown
> symbol strcpy

This is fixed in my current tree.

				Jeff


-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
