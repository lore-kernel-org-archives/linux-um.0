Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CcsMy-0008N4-Dn for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 13:32:08 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CcsMt-0002vK-FN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 13:32:08 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
References: <200412101645.iBAGjWA13367@trolli.pdb.fsc.net>
In-Reply-To: <200412101645.iBAGjWA13367@trolli.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412102228.07984.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [patch 1/1] make arch/um/kernel/skas/include/skas.h
	include asm/types.h
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
Date: Fri, 10 Dec 2004 22:28:07 +0100
To: bstroesser@fujitsu-siemens.com
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

On Friday 10 December 2004 17:45, bstroesser@fujitsu-siemens.com wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> make arch/um/kernel/skas/include/skas.h include asm/types.h
> This is necessary to have a typedef for __u64

*Probably* won't work, as headers in arch/um/include.... are also includable 
by userspace files, which can't include <asm/types.h>; well, it could happen 
to include the *host* asm/types.h, which will be bad on a x86_64 host, since 
you could get a "unsigned long" (which is safe) even when compiling a 32-bit 
UML!

Otherwise, there would not be includes in arch/um! They'd be in 
include/asm-um!

And yes, this sucks, but is reality.

Workaround it - unsigned long long is always a correct definition.
> Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> ---
>
>
> diff -puN arch/um/kernel/skas/include/skas.h~skas.h-include-types.h
> arch/um/kernel/skas/include/skas.h ---
> linux-2.6.10-rc2-mm4/arch/um/kernel/skas/include/skas.h~skas.h-include-type
>s.h 2004-12-10 15:53:03.726530054 +0100 +++
> linux-2.6.10-rc2-mm4-root/arch/um/kernel/skas/include/skas.h 2004-12-10
> 15:53:03.730528661 +0100 @@ -7,6 +7,7 @@
>  #define __SKAS_H
>
>  #include "sysdep/ptrace.h"
> +#include "asm/types.h"
>
>  extern int userspace_pid[];
>
> _

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
