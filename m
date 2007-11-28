Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxOSf-00050J-6i for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 07:04:25 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxOSd-00023H-Jl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 07:04:25 -0800
Date: Wed, 28 Nov 2007 10:03:38 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071128150338.GA5501@c2.user-mode-linux.org>
References: <E1Ix3Du-0002aL-Ac@dorka.pomaz.szeredi.hu>
	<E1Ix58o-0004J5-Mz@dorka.pomaz.szeredi.hu>
	<20071127201105.GA9332@c2.user-mode-linux.org>
	<E1Ix73b-0004aI-Px@dorka.pomaz.szeredi.hu>
	<20071127222020.GA10096@c2.user-mode-linux.org>
	<20071127213801.4def3c23.akpm@linux-foundation.org>
	<E1IxJMf-00067v-2r@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxJMf-00067v-2r@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] leak in do_ubd_request
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Nov 28, 2007 at 10:37:53AM +0100, Miklos Szeredi wrote:
> > Do we have any idea which patch this patch fixes?
> 
> I seems like a mainline bug, and has been present for some time
> (forever?).
> 
> I have no idea why this wasn't noticed earlier.

Not forever, but it's been there for a while - it was introduced here:

commit 2adcec2197897365e0a0f657f1098cbfdb44bc8b
Author: Jeff Dike <jdike@addtoit.com>
Date:   Sun May 6 14:51:37 2007 -0700

    uml: send pointers instead of structures to I/O thread
    
    Instead of writing entire structures between UML and the I/O thread, we send
    pointers.  This cuts down on the amount of data being copied and possibly
    allows more requests to be pending between the two.
    
    This requires that the requests be kmalloced and freed instead of living on
    the stack.
    
    Signed-off-by: Jeff Dike <jdike@linux.intel.com>
    Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
