Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DslX6-0000xR-MU	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:32 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DslX4-0005lt-AU	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 11:00:32 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050713180216.01CA921E732@zion.home.lan>
Subject: [uml-devel] [patch 2/9] uml: workaround host bug in "TT mode vs. NPTL
	link fix"
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
Date: Wed, 13 Jul 2005 20:02:15 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


A big bug has been diagnosed on hosts running the SKAS patch and built with
CONFIG_REGPARM, due to some missing prevent_tail_call().

On these hosts, this workaround is needed to avoid triggering that bug,
because "to" is kept by GCC only in EBX, which is corrupted at the return of
mmap2().

Since to trigger this bug int 0x80 must be used when doing the call, it rarely
manifests itself, so I'd prefer to get this merged to workaround that host
bug, since it should cause no functional change. Still, you might prefer to
drop it, I'll leave this to you.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/sys-i386/unmap.c   |    2 +-
 linux-2.6.git-broken-paolo/arch/um/sys-x86_64/unmap.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/um/sys-i386/unmap.c~uml-fix-link-tt-mode-against-nptl arch/um/sys-i386/unmap.c
--- linux-2.6.git-broken/arch/um/sys-i386/unmap.c~uml-fix-link-tt-mode-against-nptl	2005-07-13 19:37:10.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-i386/unmap.c	2005-07-13 19:37:32.000000000 +0200
@@ -15,7 +15,7 @@ int switcheroo(int fd, int prot, void *f
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	if(mmap2(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1 ){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
diff -puN arch/um/sys-x86_64/unmap.c~uml-fix-link-tt-mode-against-nptl arch/um/sys-x86_64/unmap.c
--- linux-2.6.git-broken/arch/um/sys-x86_64/unmap.c~uml-fix-link-tt-mode-against-nptl	2005-07-13 19:37:10.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-x86_64/unmap.c	2005-07-13 19:37:32.000000000 +0200
@@ -15,7 +15,7 @@ int switcheroo(int fd, int prot, void *f
 	if(munmap(to, size) < 0){
 		return(-1);
 	}
-	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) != to){
+	if(mmap(to, size, prot, MAP_SHARED | MAP_FIXED, fd, 0) == (void*) -1){
 		return(-1);
 	}
 	if(munmap(from, size) < 0){
_


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
