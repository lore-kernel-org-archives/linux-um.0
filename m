Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] um: Add missing "FORCE" target when using if_changed
Date: Fri,  8 Oct 2021 14:51:33 -0700
Message-Id: <20211008215133.9371-1-rdunlap@infradead.org>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, x86@kernel.org

'make ARCH=um' says:

../arch/x86/um/Makefile:44: FORCE prerequisite is missing

and adding "FORCE" there makes it be quiet, so do it.  :)

Fixes: e1f86d7b4b2a ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kbuild@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: x86@kernel.org
---
 arch/x86/um/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20211007.orig/arch/x86/um/Makefile
+++ linux-next-20211007/arch/x86/um/Makefile
@@ -40,7 +40,7 @@ $(obj)/user-offsets.s: c_flags = -Wp,-MD
 	-Iarch/x86/include/generated
 targets += user-offsets.s
 
-include/generated/user_constants.h: $(obj)/user-offsets.s
+include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
 	$(call filechk,offsets,__USER_CONSTANT_H__)
 
 UNPROFILE_OBJS := stub_segv.o

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

