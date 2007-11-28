Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxOzy-0000G6-RU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 07:38:51 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxOzw-0008So-6e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 07:38:50 -0800
In-reply-to: <20071128150840.GB5518@c2.user-mode-linux.org> (message from Jeff
	Dike on Wed, 28 Nov 2007 10:08:40 -0500)
References: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
	<20071128125030.GB21791@elte.hu>
	<E1IxMfh-0006fN-HQ@dorka.pomaz.szeredi.hu>
	<20071128150840.GB5518@c2.user-mode-linux.org>
Message-Id: <E1IxOzn-00075w-Gq@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 16:38:39 +0100
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

> On Wed, Nov 28, 2007 at 02:09:45PM +0100, Miklos Szeredi wrote:
> > kernel/latency_trace.c:28:21: error: asm/rtc.h: No such file or directory
> 
> For things like this, look at the host's asm/foo.h and see if it's
> usable in UML (and contains things that you need).  If it is, just
> make a asm-um/foo.h which just includes "asm/arch/foo.h".

Yeah, I know that trick :)

It doesn't help in this case.  I've gotten as far as realizing that
the latency tracer needs the irqflags tracing
(Documentation/irqflags-tracing.tx) and that UML doesn't yet support
that.

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
