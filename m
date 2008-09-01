Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaBdX-00077E-HK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 08:48:15 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KaBdV-0003Jo-PL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Sep 2008 08:48:15 -0700
Date: Mon, 1 Sep 2008 11:47:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080901154743.GA7584@c2.user-mode-linux.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291613420.15543@abydos.NerdBox.Net>
	<87ljycxldb.fsf@basil.nowhere.org>
	<20080901140618.GA5691@c2.user-mode-linux.org>
	<20080901142219.GH18288@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080901142219.GH18288@one.firstfloor.org>
Subject: Re: [uml-devel] [PATCH 1/6] base: Valgrind headers and Kconfig
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: jiayingz@google.com, dkegel@google.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Steve VanDeBogart <vandebo-lkml@NerdBox.Net>

On Mon, Sep 01, 2008 at 04:22:19PM +0200, Andi Kleen wrote:
> > Kernel code can't get headers from the system, unless you're thinking
> >        #include "/usr/include/valgrind.h"
> > or something similar.
> 
> Some um files at least least include sys/* files which are surely
> user space?  If they can include that why not valgrind.h? 

The userspace side of UML can (and, indeed must) use the system
headers.  Here, we can just #include <valgrind.h>.

However, the kernel side of UML, where the allocator annotations are,
can't use system headers.  The kernel side of things has to be
self-contained within the kernel tree.

	       	      	  	 Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
