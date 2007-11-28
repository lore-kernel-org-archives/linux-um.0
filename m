Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxJN6-0005cs-VG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 01:38:21 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxJN5-0005P0-BL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 01:38:20 -0800
In-reply-to: <20071127213801.4def3c23.akpm@linux-foundation.org> (message from
	Andrew Morton on Tue, 27 Nov 2007 21:38:01 -0800)
References: <E1Ix3Du-0002aL-Ac@dorka.pomaz.szeredi.hu>
	<E1Ix58o-0004J5-Mz@dorka.pomaz.szeredi.hu>
	<20071127201105.GA9332@c2.user-mode-linux.org>
	<E1Ix73b-0004aI-Px@dorka.pomaz.szeredi.hu>
	<20071127222020.GA10096@c2.user-mode-linux.org>
	<20071127213801.4def3c23.akpm@linux-foundation.org>
Message-Id: <E1IxJMf-00067v-2r@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 10:37:53 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@linux-foundation.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> On Tue, 27 Nov 2007 17:20:20 -0500 Jeff Dike <jdike@addtoit.com> wrote:
> 
> > On Tue, Nov 27, 2007 at 09:29:23PM +0100, Miklos Szeredi wrote:
> > > Sure.  The patch works for me, but please check that it also makes
> > > sense.
> > 
> > I did - it's a straight-forward leak and fix.
> > 
> 
> Do we have any idea which patch this patch fixes?

I seems like a mainline bug, and has been present for some time
(forever?).

I have no idea why this wasn't noticed earlier.

Miklos

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
