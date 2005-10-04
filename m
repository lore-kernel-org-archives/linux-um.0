Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMlOQ-0002QD-Fu	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:55:34 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMlOQ-0006Ry-6e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:55:34 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
Message-ID: <20051004115529.GD7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510041226.39233.blaisorblade@yahoo.it>
	<20051004110959.GC7992@ftp.linux.org.uk>
	<200510041319.34431.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041319.34431.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 4 Oct 2005 12:55:29 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Tue, Oct 04, 2005 at 01:19:33PM +0200, Blaisorblade wrote:
> > extra-$(CONFIG_MODE_TT) += unmap.o
> > $(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
> Where went objcopy -G switcheroo?
> 
> Possibly (it doesn't link into glibc) it's trivially ok, but please make sure 
> as the original fixed bug was environment-dependant (it happened only on some 
> Gentoo NPTL-only systems, and maybe the problem disappeared in later glibc 
> versions), so you wouldn't see the breakage.

For one thing, it doesn't link into anything; for another, NPTL or not, it
won't generate any non-trivial sections - it's one static variable (*not*
per-thread, etc.) and one function with a bunch of inline assembler in
it.  Built as kernel object.

IOW, this sucker is as self-contained as it get - .text, .bss, the only
relocation being reference to static variable from code (i.e. offset relative
to wherever .bss ends up) and the only non-local symbol being switcheroo.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
