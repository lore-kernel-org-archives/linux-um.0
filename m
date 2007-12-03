Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IzEZu-0004GU-Bm for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 08:55:30 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IzEZu-0005WV-0S
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Dec 2007 08:55:30 -0800
References: <E1IzDHv-0003xj-Af@dorka.pomaz.szeredi.hu>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Mon, 03 Dec 2007 11:55:16 -0500
In-Reply-To: <E1IzDHv-0003xj-Af@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
	message of "Mon\, 03 Dec 2007 16\:32\:51 +0100")
Message-ID: <x49ir3fhg5n.fsf@segfault.boston.devel.redhat.com>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, zach.brown@oracle.com, torvalds@linux-foundation.org, akpm@linux-foundation.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On 2.6.24, top started showing 100% iowait on one CPU when a UML
> instance was running (but completely idle).  I've traced it to this
> commit [1].  Reverting it cures the problem.

Hi,

The UML code sits in io_getevents waiting for an event to be submitted
and completed.  This is a case I completely overlooked when putting
together the referenced patch.

We could check ctx->reqs_active before scheduling to determine whether
or not we are waiting for I/O, but this would require taking the
context lock in order to be accurate.  Given that the test would be
only for the sake of book keeping, it might be okay to do it outside
of the lock.

Zach, what are your thoughts on this?

-Jeff


[1] commit 41d10da3717409de33d5441f2f6d8f072ab3fbb6

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
