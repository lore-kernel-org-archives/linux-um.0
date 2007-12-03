Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzGR7-0008Fq-RM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 10:54:36 -0800
Received: from tetsuo.zabbo.net ([207.173.201.20])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzGR6-0003yT-J9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 10:54:33 -0800
Message-ID: <475450A1.9000103@oracle.com>
Date: Mon, 03 Dec 2007 10:53:21 -0800
From: Zach Brown <zach.brown@oracle.com>
MIME-Version: 1.0
References: <E1IzDHv-0003xj-Af@dorka.pomaz.szeredi.hu>
	<x49ir3fhg5n.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49ir3fhg5n.fsf@segfault.boston.devel.redhat.com>
Subject: Re: [uml-devel] [2.6.24 BUG] 100% iowait on host while UML is running
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>, jdike@addtoit.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org


> We could check ctx->reqs_active before scheduling to determine whether
> or not we are waiting for I/O, but this would require taking the
> context lock in order to be accurate.  Given that the test would be
> only for the sake of book keeping, it might be okay to do it outside
> of the lock.
> 
> Zach, what are your thoughts on this?

I agree that it'd be OK to test it outside the lock, though we'll want
some commentary:

	/* Try to only show up in io wait if there are ops in flight */
	if (ctx->reqs_active)
		io_schedule();
	else
		schedule();

It's cheap, safe, and accurate the overwhelming majority of the time :).

We only need it in read_events().  The other two io_schedule() calls are
only reached to wait on pending reqs specifically.

It still won't make sense for iocbs which aren't performing IO, but I
guess that's one more bridge to cross when we come to it.

Do you want to throw this tiny patch together and submit it?

- z

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
