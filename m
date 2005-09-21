Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EI7kO-0001EF-RO	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:04 -0700
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EI7kO-0003wm-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Sep 2005 09:47:05 -0700
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20050921163800.30500.3342.stgit@zion.home.lan>
In-Reply-To: <200509211822.17590.blaisorblade@yahoo.it>
References: <200509211822.17590.blaisorblade@yahoo.it>
Subject: [uml-devel] [PATCH 02/10] [ALL ARCHES] Remove unused var from
	asm/futex.h
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
Date: Wed, 21 Sep 2005 18:38:09 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

As recently done by Russell King for ARM, commit
4732efbeb997189d9f9b04708dc26bf8613ed721 introduces a generic asm/futex.h copied
along most arches, which includes a "-ENOSYS support" to be changed if needed.
However, it includes an unused var (taken from the "real" version) which GCC
warns about.

Remove it from all arches having that file version (i.e. same GIT id).
$ git-diff-tree -r HEAD
and
$ git-ls-tree  -r HEAD include/|grep 9feff4ce1424bc390608326240be369eb13aa648

may be more interesting than looking at the patch itself, to make sure I've
just copied the arm header to all other archs having the original dummy version
of this file.

Cc: Jakub Jelinek <jakub@redhat.com>
Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-alpha/futex.h     |    2 +-
 include/asm-arm26/futex.h     |    2 +-
 include/asm-cris/futex.h      |    2 +-
 include/asm-frv/futex.h       |    2 +-
 include/asm-h8300/futex.h     |    2 +-
 include/asm-ia64/futex.h      |    2 +-
 include/asm-m32r/futex.h      |    2 +-
 include/asm-m68k/futex.h      |    2 +-
 include/asm-m68knommu/futex.h |    2 +-
 include/asm-parisc/futex.h    |    2 +-
 include/asm-ppc/futex.h       |    2 +-
 include/asm-s390/futex.h      |    2 +-
 include/asm-sh/futex.h        |    2 +-
 include/asm-sh64/futex.h      |    2 +-
 include/asm-sparc/futex.h     |    2 +-
 include/asm-sparc64/futex.h   |    2 +-
 include/asm-v850/futex.h      |    2 +-
 17 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/asm-alpha/futex.h b/include/asm-alpha/futex.h
--- a/include/asm-alpha/futex.h
+++ b/include/asm-alpha/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-arm26/futex.h b/include/asm-arm26/futex.h
--- a/include/asm-arm26/futex.h
+++ b/include/asm-arm26/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-cris/futex.h b/include/asm-cris/futex.h
--- a/include/asm-cris/futex.h
+++ b/include/asm-cris/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-frv/futex.h b/include/asm-frv/futex.h
--- a/include/asm-frv/futex.h
+++ b/include/asm-frv/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-h8300/futex.h b/include/asm-h8300/futex.h
--- a/include/asm-h8300/futex.h
+++ b/include/asm-h8300/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-ia64/futex.h b/include/asm-ia64/futex.h
--- a/include/asm-ia64/futex.h
+++ b/include/asm-ia64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m32r/futex.h b/include/asm-m32r/futex.h
--- a/include/asm-m32r/futex.h
+++ b/include/asm-m32r/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m68k/futex.h b/include/asm-m68k/futex.h
--- a/include/asm-m68k/futex.h
+++ b/include/asm-m68k/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-m68knommu/futex.h b/include/asm-m68knommu/futex.h
--- a/include/asm-m68knommu/futex.h
+++ b/include/asm-m68knommu/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-parisc/futex.h b/include/asm-parisc/futex.h
--- a/include/asm-parisc/futex.h
+++ b/include/asm-parisc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-ppc/futex.h b/include/asm-ppc/futex.h
--- a/include/asm-ppc/futex.h
+++ b/include/asm-ppc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-s390/futex.h b/include/asm-s390/futex.h
--- a/include/asm-s390/futex.h
+++ b/include/asm-s390/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sh/futex.h b/include/asm-sh/futex.h
--- a/include/asm-sh/futex.h
+++ b/include/asm-sh/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sh64/futex.h b/include/asm-sh64/futex.h
--- a/include/asm-sh64/futex.h
+++ b/include/asm-sh64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sparc/futex.h b/include/asm-sparc/futex.h
--- a/include/asm-sparc/futex.h
+++ b/include/asm-sparc/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
--- a/include/asm-sparc64/futex.h
+++ b/include/asm-sparc64/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 
diff --git a/include/asm-v850/futex.h b/include/asm-v850/futex.h
--- a/include/asm-v850/futex.h
+++ b/include/asm-v850/futex.h
@@ -14,7 +14,7 @@ futex_atomic_op_inuser (int encoded_op, 
 	int cmp = (encoded_op >> 24) & 15;
 	int oparg = (encoded_op << 8) >> 20;
 	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tem;
+	int oldval = 0, ret;
 	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
 		oparg = 1 << oparg;
 



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
