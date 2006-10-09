Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GX73o-0003lb-Im for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:36 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GX73n-0000GW-Lp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 19:09:36 -0700
Date: Mon, 9 Oct 2006 12:32:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061009163208.GA4931@ccure.user-mode-linux.org>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213836.17268.96038.stgit@memento.home.lan>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061005213836.17268.96038.stgit@memento.home.lan>
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for
	USER_OBJS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Oct 05, 2006 at 11:38:36PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Again, move inclusion of arch's Makefile after CFLAGS setting - I remember
> merging the same patch eons ago in 2.6, so I added a comment.
> 
> I discovered this because debug info weren't enabled for USER_OBJS - they're
> compiled with USER_CFLAGS which is calculated from CFLAGS (the whole thing is a
> bit of an hack but fixing it is not easy, so we're leaving it as-is).

What's the matter with this:

Index: linux-2.6.18-mm/arch/um/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Makefile       2006-10-03 17:44:32.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Makefile    2006-10-09 12:29:32.000000000 -0400
@@ -64,9 +64,8 @@ CFLAGS += $(CFLAGS-y) -D__arch_um__ -DSU
 
 AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
-USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-       $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
+USER_CFLAGS = $(patsubst -D__KERNEL__,,$(patsubst -I%,,$(CFLAGS))) \
+       $(ARCH_INCLUDE) $(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common

The real problem is the use of := which assigns USER_CFLAGS from the
current value of CFLAGS, which is incomplete, as you noted.

Moving the include around seems slightly bogus, since its precise
location shouldn't matter.

If we switch to plain =, then it will be lazy-evaluated with the full
CFLAGS.

And we should check other uses of := to make sure they don't have
similar problems.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
