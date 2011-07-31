Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QnexZ-0000Xz-Ik
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 22:58:13 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QnexY-0005bE-4O
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 22:58:13 +0000
Date: Sun, 31 Jul 2011 23:58:01 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110731225801.GD2203@ZenIV.linux.org.uk>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110731224834.GC2203@ZenIV.linux.org.uk>
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
To: David Woodhouse <dwmw2@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>

On Sun, Jul 31, 2011 at 11:48:35PM +0100, Al Viro wrote:
> On Sun, Jul 31, 2011 at 11:24:21PM +0100, David Woodhouse wrote:
> > On Mon, 2011-08-01 at 00:11 +0200, richard -rw- weinberger wrote:
> > > 
> > > Why do we need this? 
> > 
> > The arch/x86_64 and arch/i386 directories were removed from the kernel
> > four years ago, and replaced by the 'x86' arch. UML is still dependent
> > on the legacy SUBARCH=i386 and SUBARCH=x86_64 settings, and the patch
> > sequence I just posted makes it cope with SUBARCH=x86.
> 
> Hell, no.  If you want to do it, do it the right way.  See #x86_merge in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/um-header.git/

FWIW, the next step (still not pushed there) is to move arch/um/sys-x86 to
arch/x86/um, with arch/um/os-Linux/sys-x86 becoming arch/x86/um/os-Linux,
Kconfig.x86 moving to arch/x86/um/Kconfig and Makefile-x86 - to
arch/x86/um/Makefile.defs.  Next after that - arch/powerpc/um (and yes,
it means resurrected uml/ppc port; for now - only ppc32, since I have no
ppc64 boxen to test on).

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

