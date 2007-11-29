Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixn0Y-0001lf-Jz for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 09:17:02 -0800
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ixn0W-0006AG-UO
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 09:17:01 -0800
Date: Thu, 29 Nov 2007 18:16:47 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071129171647.GA1326@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
	<20071129170205.GA7415@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071129170205.GA7415@c2.user-mode-linux.org>
Subject: Re: [uml-devel] scheduling anomaly on uml (was: -rt doesn't compile
	for UML)
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
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Miklos Szeredi <miklos@szeredi.hu>


* Jeff Dike <jdike@addtoit.com> wrote:

> On Thu, Nov 29, 2007 at 11:19:40AM +0100, Miklos Szeredi wrote:
> >     date-7119  0.... 15636591us!: schedule <bash-502> (0 0)
> >     bash-502   0.... 15643908us!: schedule <date-7119> (0 0)
> >     bash-502   0.... 15646250us!: schedule <date-7120> (0 0)
> 
> How exactly did you end up getting this data?
> 
> And is there something I can read to tell what it means?

the header of /proc/latency_trace explains the format:

                 _------=> CPU#
                / _-----=> irqs-off
               | / _----=> need-resched
               || / _---=> hardirq/softirq
               ||| / _--=> preempt-depth
               |||| /
               |||||     delay
   cmd     pid ||||| time  |   caller
      \   /    |||||   \   |   /
 privoxy-12926 1.Ns1    0us : ktime_get_ts (ktime_get)

'time' is timestamp in microseconds. Then come the caller (and parent, 
or other, special parameters like the task-pid of the scheduled task). 
It's supposed to be easy to read to kernel hackers - let me know if any 
of the details is non-obvious.

for example:

> >     date-7119  0.... 15636591us!: schedule <bash-502> (0 0)

the task 'date' (pid 7119) scheduled at timestamp 15636591us, and 
switched to another task 'bash' (pid 502). Both had a default nice level 
of 0 [the (0 0) arguments].

	Ingo

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
