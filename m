Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+5a26c1d377b2d96a6988+2898+infradead.org+dwmw2@casper.srs.infradead.org>)
	id 1QnfCA-0001J1-OU for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:13:18 +0000
Received: from casper.infradead.org ([85.118.1.10])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QnfCA-0005yx-0U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:13:18 +0000
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 01 Aug 2011 00:13:07 +0100
In-Reply-To: <20110731225801.GD2203@ZenIV.linux.org.uk>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
	<20110731225801.GD2203@ZenIV.linux.org.uk>
Message-ID: <1312153988.18010.39.camel@i7.infradead.org>
Mime-Version: 1.0
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall
 exports, not SUBARCH_i386
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, 2011-07-31 at 23:58 +0100, Al Viro wrote:
> FWIW, the next step (still not pushed there) is to move arch/um/sys-x86 to
> arch/x86/um, with arch/um/os-Linux/sys-x86 becoming arch/x86/um/os-Linux,
> Kconfig.x86 moving to arch/x86/um/Kconfig and Makefile-x86 - to
> arch/x86/um/Makefile.defs.  Next after that - arch/powerpc/um (and yes,
> it means resurrected uml/ppc port; for now - only ppc32, since I have no
> ppc64 boxen to test on). 

I can give you an account on a ppc64 box if that would help...

What you've done so far, with the one extra patch I just sent, seems
perfectly sufficient to make it cope with SUBARCH defaulting to x86
instead of to i386 or x86_64. Are you happy to push it before you do the
rest of the refactoring/moving?

-- 
dwmw2


------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

