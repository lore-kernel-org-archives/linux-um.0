Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMkgO-00080y-85	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:10:04 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMkgM-0003RB-Kn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:10:04 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
Message-ID: <20051004110959.GC7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051003233837.GA7992@ftp.linux.org.uk>
	<200510041226.39233.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510041226.39233.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 12:09:59 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Tue, Oct 04, 2005 at 12:26:36PM +0200, Blaisorblade wrote:
> On Tuesday 04 October 2005 01:38, Al Viro wrote:
> > On Mon, Oct 03, 2005 at 08:30:23PM +0200, Blaisorblade wrote:
> > > The second is that, even if x86_64 uses things such as  (from
> > > arch/x86_64/mm/Makefile):
> > >
> 
> > Err...  Kbuild won't know what to do with your subarch-y.  The way it works
> > is simple - we are saying that e.g. bitops.o is a multi-part object with
> > only one part, namely ../../i386/lib/bitops.o.  Said part is built by the
> > normal Kbuild logics and then we get (dummy) linking, creating bitops.o.
> 
> I know about kbuild, I just forgot to mention adding:
> 
> obj-y += subarch.o
> 
> (which you add below).
> 
> I've been cleaning up the UML Makefiles for almost a year, when I was even 
> more of a kernel newbie than I am now ;-)...

Speaking of cleaning these makefiles: in my tree Makefile.unmap is
simply 

extra-$(CONFIG_MODE_TT) += unmap.o
$(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))

now.  At which point it's about to disappear - no sense to bother with
including two lines, especially since one of them folds into

$(obj)/stub_segv.o $(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))

Post-2.6.14 fodder, obviously.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
