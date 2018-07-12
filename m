Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 5/6] kbuild: change ld_flags to contain LDFLAGS_$(@F)
Date: Thu, 12 Jul 2018 17:01:35 +0900
Message-Id: <1531382496-3719-6-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
References: <1531382496-3719-1-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-kbuild@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, x86@kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Russell King <rmk+kernel@armlinux.org.uk>, openrisc@lists.librecores.org, "Kirill A . Shutemov" <kirill@shutemov.name>, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

Put $(LDFLAGS_$(@F)) into ld_flags so that $(LDFLAGS_pcap.o) and
$(LDFLAGS_vde.o) in arch/um/drivers/Makefile are absorbed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/um/drivers/Makefile | 4 ++--
 scripts/Makefile.lib     | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 16b3ceb..69331983 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -25,10 +25,10 @@ LDFLAGS_vde.o := -r $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 targets := pcap_kern.o pcap_user.o vde_kern.o vde_user.o
 
 $(obj)/pcap.o: $(obj)/pcap_kern.o $(obj)/pcap_user.o
-	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_pcap.o)
+	$(LD) -r -dp -o $@ $^ $(ld_flags)
 
 $(obj)/vde.o: $(obj)/vde_kern.o $(obj)/vde_user.o
-	$(LD) -r -dp -o $@ $^ $(LDFLAGS) $(LDFLAGS_vde.o)
+	$(LD) -r -dp -o $@ $^ $(ld_flags)
 
 #XXX: The call below does not work because the flags are added before the
 # object name, so nothing from the library gets linked.
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 1915574..f56bb4b 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -162,7 +162,7 @@ a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(LINUXINCLUDE)     \
 		 $(__cpp_flags)
 
-ld_flags       = $(LDFLAGS) $(ldflags-y)
+ld_flags       = $(LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
 
 DTC_INCLUDE    := $(srctree)/scripts/dtc/include-prefixes
 
@@ -225,7 +225,7 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------
 
 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(ld_flags) $(LDFLAGS_$(@F)) $(filter-out FORCE,$^) -o $@
+cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
 
 # Objcopy
 # ---------------------------------------------------------------------------
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

