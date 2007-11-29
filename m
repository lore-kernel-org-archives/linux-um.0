Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixhua-00060Y-GF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 03:50:33 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxhuV-0001IN-W6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 03:50:32 -0800
Date: Thu, 29 Nov 2007 12:50:11 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071129115011.GA30208@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
	<E1IxRv7-0007e8-Dq@dorka.pomaz.szeredi.hu>
	<E1IxgUe-00011b-Sl@dorka.pomaz.szeredi.hu>
	<20071129105744.GI10577@elte.hu>
	<E1Ixhgf-0001CF-MC@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1Ixhgf-0001CF-MC@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> > how come UML idled for 30 msecs here, while the workload was 
> > supposed to be CPU-bound? It's not IO bound anywhere, right? No SMP 
> > artifacts either, right?
> 
> Yes.  The UML kernel is UP, and I don't think 'date' or 'bash' want to 
> do any disk I/O.
> 
> Could disk I/O be blocking the tty?  I think UML uses separate threads 
> for these, but I don't know the details.

even if the workload is fully CPU bound externally - internally a 
request to the external (CPU-bound) thread will look like an asynchonous 
request - so small amounts of idle time can be within UML, legitimately. 
(for the amount of time it takes for the external thread to service the 
request)

30 msecs already sounds a bit excessive (this is on your T60 with 
Core2Duo, right?), and 1-2 seconds noticeable latency is definitely 
excessive.

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
