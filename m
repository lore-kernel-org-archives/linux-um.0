Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <viro@ftp.linux.org.uk>) id 1QnkAu-0001O9-N1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 04:32:20 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QnkAs-0001NM-Ej
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Aug 2011 04:32:20 +0000
Date: Mon, 1 Aug 2011 05:32:08 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20110801043207.GE2203@ZenIV.linux.org.uk>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
	<20110731225801.GD2203@ZenIV.linux.org.uk>
	<1312153988.18010.39.camel@i7.infradead.org>
	<CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
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
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, David Woodhouse <dwmw2@infradead.org>

On Mon, Aug 01, 2011 at 01:17:17AM +0200, richard -rw- weinberger wrote:
> On Mon, Aug 1, 2011 at 1:13 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> > On Sun, 2011-07-31 at 23:58 +0100, Al Viro wrote:
> >> FWIW, the next step (still not pushed there) is to move arch/um/sys-x86 to
> >> arch/x86/um, with arch/um/os-Linux/sys-x86 becoming arch/x86/um/os-Linux,
> >> Kconfig.x86 moving to arch/x86/um/Kconfig and Makefile-x86 - to
> >> arch/x86/um/Makefile.defs. ?Next after that - arch/powerpc/um (and yes,
> >> it means resurrected uml/ppc port; for now - only ppc32, since I have no
> >> ppc64 boxen to test on).
> >
> > I can give you an account on a ppc64 box if that would help...
> 
> Isn't UML on ppc broken since ages?

Yes.  Resurrected is not the right word here, sorry...

Anyway, could you take a look at the git tree at
git://git.kernel.org/pub/scm/linux/kernel/git/viro/um-header.git/,
branch x86_merge and comment?  It doesn't include stuff from this
thread (yet); what it does is
	* further headers cleanups
	* sys-{i386,x86_64} merged; all[1] x86-specific code taken first
to arch/um/sys-x86 and then (by final commit) to arch/x86/um.  IMO that's
the right place for it - target-dependent code is better off not hidden
from maintainers of the target arch.  When we get other ports to working
shape, their target-specific parts ought to go into arch/<target>/um.
	* hopefully saner treatment of sigcontext; should make life easier
for other ports.
	
[1] theoretically - in reality we still have more than a few x86-isms in
"generic" um headers in arch/um/include/asm.

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

