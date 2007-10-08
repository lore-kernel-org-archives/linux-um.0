Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ieu9h-0006EI-Gi for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:04:25 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ieu9f-0004Ks-1v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 Oct 2007 08:04:25 -0700
Date: Mon, 8 Oct 2007 11:04:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071008150417.GD5279@c2.user-mode-linux.org>
References: <200708191142.57281.toralf.foerster@gmx.de>
	<200708201730.37648.toralf.foerster@gmx.de>
	<20070820160537.GA3874@localhost.localdomain>
	<200710061514.28090.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200710061514.28090.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Oct 06, 2007 at 03:14:25PM +0200, Toralf F=F6rster wrote:
>   CC      arch/um/kernel/um_arch.o
>   CC      arch/um/kernel/umid.o
>   CC      arch/um/kernel/skas/clone.o
> arch/um/kernel/skas/clone.c:6:22: error: asm/page.h: No such file or dire=
ctory
> make[2]: *** [arch/um/kernel/skas/clone.o] Error 1
> make[1]: *** [arch/um/kernel/skas] Error 2
> make: *** [arch/um/kernel] Error 2

Try this:

Index: linux-2.6.22/arch/um/kernel/skas/clone.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.orig/arch/um/kernel/skas/clone.c	2007-10-05 10:42:22.00000=
0000 -0400
+++ linux-2.6.22/arch/um/kernel/skas/clone.c	2007-10-08 10:59:29.000000000 =
-0400
@@ -3,7 +3,6 @@
 #include <sys/mman.h>
 #include <sys/time.h>
 #include <asm/unistd.h>
-#include <asm/page.h>
 #include "ptrace_user.h"
 #include "skas.h"
 #include "stub-data.h"

				Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
