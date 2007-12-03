Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzH35-0003o1-9x for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 11:33:47 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzH34-0007BG-Ta
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 11:33:47 -0800
References: <E1IzDHv-0003xj-Af@dorka.pomaz.szeredi.hu>
	<x49ir3fhg5n.fsf@segfault.boston.devel.redhat.com>
	<475450A1.9000103@oracle.com>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 03 Dec 2007 14:33:06 -0500
In-Reply-To: <475450A1.9000103@oracle.com> (Zach Brown's message of "Mon\,
	03 Dec 2007 10\:53\:21 -0800")
Message-ID: <x49zlwrfua5.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
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
To: Zach Brown <zach.brown@oracle.com>, akpm@linux-foundation.org
Cc: jdike@addtoit.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>

Zach Brown <zach.brown@oracle.com> writes:

>> We could check ctx->reqs_active before scheduling to determine whether
>> or not we are waiting for I/O, but this would require taking the
>> context lock in order to be accurate.  Given that the test would be
>> only for the sake of book keeping, it might be okay to do it outside
>> of the lock.
>> 
>> Zach, what are your thoughts on this?
>
> I agree that it'd be OK to test it outside the lock, though we'll want
> some commentary:
>
> 	/* Try to only show up in io wait if there are ops in flight */
> 	if (ctx->reqs_active)
> 		io_schedule();
> 	else
> 		schedule();
>
> It's cheap, safe, and accurate the overwhelming majority of the time :).
>
> We only need it in read_events().  The other two io_schedule() calls are
> only reached to wait on pending reqs specifically.
>
> It still won't make sense for iocbs which aren't performing IO, but I
> guess that's one more bridge to cross when we come to it.
>
> Do you want to throw this tiny patch together and submit it?

Sure.  I tested this on a system that I used to reproduce the problem,
and it shows I/O Wait back at normal levels on an idle system with 1
uml guest running.

Andrew, do you need a separate email with a [patch] heading or will
this do?

Cheers,

Jeff

Only account I/O wait time in read_events if there are active
requests.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/fs/aio.c b/fs/aio.c
index f12db41..9dec7d2 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1161,7 +1161,12 @@ retry:
 			ret = 0;
 			if (to.timed_out)	/* Only check after read evt */
 				break;
-			io_schedule();
+			/* Try to only show up in io wait if there are ops
+			 *  in flight */
+			if (ctx->reqs_active)
+				io_schedule();
+			else
+				schedule();
 			if (signal_pending(tsk)) {
 				ret = -EINTR;
 				break;


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
