Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxRmf-0006sU-Of for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 10:37:18 -0800
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxRme-0006hy-6v
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 10:37:17 -0800
Date: Wed, 28 Nov 2007 19:37:06 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071128183706.GA3826@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128150637.GA5518@c2.user-mode-linux.org>
	<E1IxOwS-000752-HF@dorka.pomaz.szeredi.hu>
	<20071128182935.GA8048@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071128182935.GA8048@c2.user-mode-linux.org>
Subject: Re: [uml-devel] -rt doesn't compile for UML
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

> On Wed, Nov 28, 2007 at 04:35:12PM +0100, Miklos Szeredi wrote:
> > Something like:
> > 
> >   dd if=/host/tmp/bigfile of=/tmp/bigfile bs=1048576 count=100
> > 
> > and run 'top' or 'watch something' in another terminal, which
> > sometimes completely stops updating during the write.
> 
> Are you talking about missing updates for a few seconds, or for 
> longer?  With the common above, with top -delay 1, and with 600M of 
> data, I'm seeing occasional 2-3 pauses, with one missing 5 seconds.

even sub-second delays are a huge issue if the system is otherwise idle 
- it signals some sort of missed event condition. scheduling must be 
instantenous.

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
