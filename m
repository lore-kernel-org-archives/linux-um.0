Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMZtL-0006q1-3V	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 16:38:43 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EMZtK-0003BG-PB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 16:38:43 -0700
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20051003233837.GA7992@ftp.linux.org.uk>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
	<200510032030.23705.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510032030.23705.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
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
Date: Tue, 4 Oct 2005 00:38:37 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Mon, Oct 03, 2005 at 08:30:23PM +0200, Blaisorblade wrote:
> The second is that, even if x86_64 uses things such as  (from 
> arch/x86_64/mm/Makefile):
> 
> obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
> hugetlbpage-y = ../../i386/mm/hugetlbpage.o
> (because hugetlbpage.o is conditional)
> 
> we could as well do 
> 
> subarch-y := ../../$(SUBARCH)/name
> (even with foreach)

Err...  Kbuild won't know what to do with your subarch-y.  The way it works
is simple - we are saying that e.g. bitops.o is a multi-part object with
only one part, namely ../../i386/lib/bitops.o.  Said part is built by the
normal Kbuild logics and then we get (dummy) linking, creating bitops.o.

> for most things (see arch/x86_64/oprofile/Makefile), and for highmem and 
> module I'd just do that by hand:
> 
> highmem-y := $(SUBARCH_DIR)/mm/highmem.o
> module-y := $(SUBARCH_DIR)/kernel/module.o
> 
> with SUBARCH_DIR defined in arch/um/Makefile.

Hrm...   That just might be usable, _if_ we never run into modular suckers;
in that case we can do the following:

ifneq ($(subarch-objs-y),)
obj-y += subarch.o
subarch-y = $(addprefix ../../$(SUBARCH),$(subarch-objs-y))
endif

in arch/um/scripts/Makefile.rules with

subarch-y = .....
subarch-$(CONFIG_MODULE) += kernel/module.o
etc. in arch/um/sys-.../Makefile

The thing is, if we _ever_ need a potentially modular object pulled from
the underlying architecture that trick will break.  So far we do not and
since $(eval...) *is* a vile mess straight from the GNU intestine...


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
