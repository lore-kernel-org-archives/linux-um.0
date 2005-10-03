Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMVMc-0007ek-Qm	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:38 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMVMY-0004w3-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051002183758.GR7992@ftp.linux.org.uk>
	<20051002205451.GS7992@ftp.linux.org.uk>
In-Reply-To: <20051002205451.GS7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032030.23705.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 20:30:23 +0200
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Alexander Viro <viro@zeniv.linux.org.uk>, sam@ravnborg.org

On Sunday 02 October 2005 22:54, Al Viro wrote:
> BTW, speaking of Kbuild cleanups (and that one is definitely 2.6.15
> fodder): patch below
> 	* kills messing with lib vs. core for uml-amd64 (we don't need that
> anymore)
I'm even curious why we needed that in first place.

> 	* kills symlinks in arch/um/sys-*/
> 	* kills foo.c-dir - we simply give HOST_OBJS=<list of pathnames
> under arch/$(SUBARCH)> and that's it (no SYMLINKS either)

> Price: use of make feature I really, really hate - $(eval ...). 
I looked at make Changelog, time ago, and this feature was added in make 3.80, 
so you'd need to update Documentation/Changes.

Make 3.80 was released in 2002-10-03, so I hope it's not a problem (should 
check on Debian Woody though, maybe).

> I'm using 
> it to generate and process
>
> bar-y := ../../$(SUBARCH)/foo/bar.o
> ...

> for all HOST_OBJS elements.  If there are better suggestions, I'd be glad
> to hear them...

The first thing is that HOST_OBJS is totally confusing... SUBARCH_OBJS or 
something else is better.

The second is that, even if x86_64 uses things such as  (from 
arch/x86_64/mm/Makefile):

obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
hugetlbpage-y = ../../i386/mm/hugetlbpage.o
(because hugetlbpage.o is conditional)

we could as well do 

subarch-y := ../../$(SUBARCH)/name
(even with foreach)

for most things (see arch/x86_64/oprofile/Makefile), and for highmem and 
module I'd just do that by hand:

highmem-y := $(SUBARCH_DIR)/mm/highmem.o
module-y := $(SUBARCH_DIR)/kernel/module.o

with SUBARCH_DIR defined in arch/um/Makefile.
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
