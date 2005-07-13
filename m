Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsqlW-0000Xo-Lq	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 16:35:46 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DsqlV-0006gE-7O	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 16:35:46 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
Message-ID: <20050713232934.GB16051@ccure.user-mode-linux.org>
References: <200507122346.40320.rob@landley.net>
	<20050713121520.GA4460@ccure.user-mode-linux.org>
	<200507131656.37695.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507131656.37695.rob@landley.net>
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
Date: Wed, 13 Jul 2005 19:29:34 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 13, 2005 at 04:56:37PM -0500, Rob Landley wrote:
> Here's the maps:
> 
> landley@driftwood:/proc/7972$ cat maps
> 08048000-08132000 rwxp 00000000 03:05 2801050    /home/landley/linux-2.6.12.2/linux
> 08132000-08165000 rw-p 08132000 00:00 0
> 08800000-0a000000 rw-s 00800000 03:05 4922001    /tmp/vm_file-gYGr1Q (deleted)
> b7eb7000-b7eb9000 rw-p b7eb7000 00:00 0
> b7eb9000-b7fdb000 r-xp 00000000 03:05 2371242    /lib/tls/i686/cmov/libc-2.3.2.so
> b7fdb000-b7fe4000 rw-p 00121000 03:05 2371242    /lib/tls/i686/cmov/libc-2.3.2.so
> b7fe4000-b7fe6000 rw-p b7fe4000 00:00 0
> b7fe6000-b7fe8000 r-xp 00000000 03:05 2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
> b7fe8000-b7fe9000 rw-p 00001000 03:05 2371260    /lib/tls/i686/cmov/libutil-2.3.2.so
> b7fe9000-b7feb000 rw-p b7fe9000 00:00 0
> b7feb000-b8000000 r-xp 00000000 03:05 2371080    /lib/ld-2.3.2.so
> b8000000-b8001000 rw-p 00015000 03:05 2371080    /lib/ld-2.3.2.so
> bffeb000-c0000000 rwxp bffeb000 00:00 0
> ffffe000-fffff000 ---p 00000000 00:00 0

This is the maps for the UML kernel, I think, rather than the maps for the
process under ptrace.

Was 7292 the value of pid at the point of the panic?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
