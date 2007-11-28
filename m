Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxQeb-0007Eb-8B for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:24:53 -0800
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxQeY-0004ZO-RB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:24:53 -0800
Date: Wed, 28 Nov 2007 18:24:33 +0100
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20071128172433.GA10840@elte.hu>
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
	<20071128150840.GB5518@c2.user-mode-linux.org>
	<E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
	<20071128154152.GA742@elte.hu>
	<E1IxPKU-00079S-UH@dorka.pomaz.szeredi.hu>
	<20071128160501.GA7986@elte.hu>
	<E1IxQEX-0007Ji-TV@dorka.pomaz.szeredi.hu>
	<E1IxQJM-0007LZ-1w@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1IxQJM-0007LZ-1w@dorka.pomaz.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


* Miklos Szeredi <miklos@szeredi.hu> wrote:

> > OK, managed to make it compile, but then something goes wrong in
> > tracer_alloc_bootmem().
> 
> It needs 32M, and uml has that much by default.  Doh.

reduce MAX_TRACE to something like 1024 to make sure allocation is not 
an issue. Do you still see problems?

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
