Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxQf4-0007Kj-EF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:25:22 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxQf2-0005bY-MP
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 09:25:22 -0800
In-reply-to: <E1IxQJM-0007LZ-1w@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Wed, 28 Nov 2007 18:02:56 +0100)
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
Message-Id: <E1IxQem-0007P3-69@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 18:25:04 +0100
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> > OK, managed to make it compile, but then something goes wrong in
> > tracer_alloc_bootmem().
> 
> It needs 32M, and uml has that much by default.  Doh.
> 
> But something is still wrong:
> 
> > /store/quilt/linux/linux mem=64

I'm an idiot, sorry.  It should have been mem=64M.  No wonder it
didn't manage to start with 64 bytes of memory ;)

So now with s/trace_alloc_bootmem/alloc_bootmem and MAX_TRACE set to
4096UL*16UL it boots fine.

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
