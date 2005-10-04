Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMkpp-0000Dp-6r	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:19:49 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMkpn-00034A-Ed
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 04:19:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510041226.39233.blaisorblade@yahoo.it>
	<20051004110959.GC7992@ftp.linux.org.uk>
In-Reply-To: <20051004110959.GC7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041319.34431.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 13:19:33 +0200
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Tuesday 04 October 2005 13:09, Al Viro wrote:
> On Tue, Oct 04, 2005 at 12:26:36PM +0200, Blaisorblade wrote:
> > On Tuesday 04 October 2005 01:38, Al Viro wrote:
> > > On Mon, Oct 03, 2005 at 08:30:23PM +0200, Blaisorblade wrote:
> > > > The second is that, even if x86_64 uses things such as  (from
> > > > arch/x86_64/mm/Makefile):

> Speaking of cleaning these makefiles: in my tree Makefile.unmap is
> simply
>
> extra-$(CONFIG_MODE_TT) += unmap.o
> $(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
Where went objcopy -G switcheroo?

Possibly (it doesn't link into glibc) it's trivially ok, but please make sure 
as the original fixed bug was environment-dependant (it happened only on some 
Gentoo NPTL-only systems, and maybe the problem disappeared in later glibc 
versions), so you wouldn't see the breakage.

> now.  At which point it's about to disappear - no sense to bother with
> including two lines, especially since one of them folds into
>
> $(obj)/stub_segv.o $(obj)/unmap.o: _c_flags = $(call unprofile,$(CFLAGS))
>
> Post-2.6.14 fodder, obviously.
About folding it in, 

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
