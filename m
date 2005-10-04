Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMk0R-0005lU-Hp	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:26:43 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMk0P-0008Um-PT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 Oct 2005 03:26:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
References: <200510021213.40191.blaisorblade@yahoo.it>
	<200510032030.23705.blaisorblade@yahoo.it>
	<20051003233837.GA7992@ftp.linux.org.uk>
In-Reply-To: <20051003233837.GA7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041226.39233.blaisorblade@yahoo.it>
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
Date: Tue, 4 Oct 2005 12:26:36 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@ftp.linux.org.uk>, Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Tuesday 04 October 2005 01:38, Al Viro wrote:
> On Mon, Oct 03, 2005 at 08:30:23PM +0200, Blaisorblade wrote:
> > The second is that, even if x86_64 uses things such as  (from
> > arch/x86_64/mm/Makefile):
> >

> Err...  Kbuild won't know what to do with your subarch-y.  The way it works
> is simple - we are saying that e.g. bitops.o is a multi-part object with
> only one part, namely ../../i386/lib/bitops.o.  Said part is built by the
> normal Kbuild logics and then we get (dummy) linking, creating bitops.o.

I know about kbuild, I just forgot to mention adding:

obj-y += subarch.o

(which you add below).

I've been cleaning up the UML Makefiles for almost a year, when I was even 
more of a kernel newbie than I am now ;-)...

> > for most things (see arch/x86_64/oprofile/Makefile), and for highmem and
> > module I'd just do that by hand:
> >
> > highmem-y := $(SUBARCH_DIR)/mm/highmem.o
> > module-y := $(SUBARCH_DIR)/kernel/module.o
> >
> > with SUBARCH_DIR defined in arch/um/Makefile.

> Hrm...   That just might be usable, _if_ we never run into modular suckers;
> in that case we can do the following:

> ifneq ($(subarch-objs-y),)
> obj-y += subarch.o
> subarch-y = $(addprefix ../../$(SUBARCH),$(subarch-objs-y))
> endif

> in arch/um/scripts/Makefile.rules with
>
> subarch-y = .....
> subarch-$(CONFIG_MODULE) += kernel/module.o
> etc. in arch/um/sys-.../Makefile
Hmm, yes, nice.
> The thing is, if we _ever_ need a potentially modular object pulled from
> the underlying architecture that trick will break.
We would just do them by hand, in this case. And say "don't use subarch-objs-y 
for modular things".

In the existing case, I've pulled in the whole directory, since it had only 
one module (aes-586.o).

Ah, I must add aes-x86_64 too, now it exists.
> So far we do not and 
> since $(eval...) *is* a vile mess straight from the GNU intestine...
I do not fully agree about eval being evil, but I'm not gonna flame on this 
issue...
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
