Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ESdaJ-0004sy-1u	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Oct 2005 09:48:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1ESdaH-0001sM-36
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 20 Oct 2005 09:48:07 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.14-rc4;
	panic: do_syscall_stub : failed to wait for SIGUSR1/SIGTRAP
Message-ID: <20051020164047.GA5571@localhost.localdomain>
References: <Pine.LNX.4.64.0510122241080.6495@sparrow>
	<20051013161937.GA5352@ccure.user-mode-linux.org>
	<Pine.LNX.4.64.0510190006090.6385@sparrow>
	<Pine.LNX.4.64.0510190030300.6014@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510190030300.6014@sparrow>
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
Date: Thu, 20 Oct 2005 12:40:47 -0400
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Oct 19, 2005 at 12:35:50AM -0400, William Stearns wrote:
> Stub registers -
>         0 - 51ae
>         1 - 13
>         2 - 51ae
>         3 - 51ab
>         4 - 0
>         5 - 0
>         6 - 4
>         7 - 0
>         8 - 0
>         9 - 0
>         10 - 0
>         11 - ffffffff
>         12 - bfffe0dd
>         13 - 73
>         14 - 10202
>         15 - bffff008
>         16 - 7b

I should have asked for this earlier, but can you also do this in gdb:
	disas batch_syscall_stub batch_syscall_stub+0x30

gdb doesn't have to be attached to a paniced UML, or any UML at all.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
