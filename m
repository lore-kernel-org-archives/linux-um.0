Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IBKlw-0002k3-Ca for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:25:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IBKlu-0003pj-TL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jul 2007 18:25:40 -0700
Date: Wed, 18 Jul 2007 21:25:25 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070719012525.GA12468@c2.user-mode-linux.org>
References: <46975CD0.5020709@nagafix.co.uk> <46976A09.9070906@nagafix.co.uk>
	<20070713155723.GA7468@c2.user-mode-linux.org>
	<4697B944.6030203@nagafix.co.uk>
	<20070713184441.GB9472@c2.user-mode-linux.org>
	<4698960D.8070100@nagafix.co.uk>
	<20070714120029.GA4421@c2.user-mode-linux.org>
	<469A54A5.2010102@nagafix.co.uk>
	<1184807588.7782.1.camel@athena.fprintf.net>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1184807588.7782.1.camel@athena.fprintf.net>
Subject: Re: [uml-devel] ARCH=um SUBARCH=i386 breakage?
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
To: Daniel Gryniewicz <dang@gentoo.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 18, 2007 at 09:13:08PM -0400, Daniel Gryniewicz wrote:
> Actually, the Gentoo headers are not particularly close to the kernel
> headers.  They are heavily "sanitized", meaning that all kinds of things
> that userspace is "not supposed to use" are removed.  This makes it very
> hard for things like UML, that are heavily tied to the kernel, to build.

UML isn't heavily tied to the kernel in the way that you mean, I think.

However, it does explore some obscure parts of the API.  For example,
the elimination of user.h makes it impossible to use
PTRACE_SETFP[X]REGS, as there is no way to tell what size buffer
should be passed in.

I'm all for minimizing the headers exported to userspace (and have
made a small contribution in that direction - ptrace-abi.h).  I'm
happy to make UML stop using things it shouldn't.  At the same time,
it should be possible to use the full userspace API.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
