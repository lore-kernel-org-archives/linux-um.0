Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWdVg-0006sQ-Es for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 12:08:40 -0700
Received: from mx2.suse.de ([195.135.220.15])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HWdVe-0000c4-0Z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 12:08:40 -0700
From: Andi Kleen <ak@suse.de>
Date: Wed, 28 Mar 2007 21:05:03 +0200
References: <20070327182746.GA8395@c2.user-mode-linux.org>
In-Reply-To: <20070327182746.GA8395@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703282105.03832.ak@suse.de>
Subject: Re: [uml-devel] [PATCH 1/6] i386 - fix cmpxchg warning
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>


>  #include <linux/compiler.h>
>  #include <asm/processor.h>
> +#include <asm/system.h>
Sorry no. system.h is the header from hell and putting it into a "basic" header
like atomic_t will likely cause all kinds of problems.

If it's a real issue move cmpxchhg into a different header and include that
from system.h and atomic.h. system.h has too much stuff anyways so it could
use any cleanup.

-Andi

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
