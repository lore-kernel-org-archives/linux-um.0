Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Message-Id: <20110601081134.410110023@blue.kroah.org>
Date: Wed, 01 Jun 2011 17:10:45 +0900
From: Greg KH <gregkh@suse.de>
In-Reply-To: <20110601081349.GA10017@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [075/165] um: Use RWSEM_GENERIC_SPINLOCK on x86
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@suse.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

2.6.39-stable review patch.  If anyone has any objections, please let u=
s know.

------------------
Content-Length: 1218
Lines: 40

=46rom: Richard Weinberger <richard@nod.at>

commit 3a3679078aed2c451ebc32836bbd3b8219a65e01 upstream.

Commit d12337 (rwsem: Remove redundant asmregparm annotation)
broke rwsem on UML.

As we cannot compile UML with -mregparm=3D3 and keeping asmregparm only
for UML is inadequate the easiest solution is using RWSEM_GENERIC_SPINL=
OCK.

Thanks to Thomas Gleixner for the idea.

Reported-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Tested-by: Toralf F=C3=B6rster <toralf.foerster@gmx.de>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Link: http://lkml.kernel.org/r/%3C1306183893-26655-1-git-send-email-ric=
hard%40nod.at%3E
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/Kconfig.x86 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/um/Kconfig.x86
+++ b/arch/um/Kconfig.x86
@@ -29,10 +29,10 @@ config X86_64
 	def_bool 64BIT
=20
 config RWSEM_XCHGADD_ALGORITHM
-	def_bool X86_XADD
+	def_bool X86_XADD && 64BIT
=20
 config RWSEM_GENERIC_SPINLOCK
-	def_bool !X86_XADD
+	def_bool !RWSEM_XCHGADD_ALGORITHM
=20
 config 3_LEVEL_PGTABLES
 	bool "Three-level pagetables (EXPERIMENTAL)" if !64BIT


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

