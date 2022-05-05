Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 05/15] kbuild: generate a list of objects in vmlinux
Date: Thu,  5 May 2022 16:22:34 +0900
Message-Id: <20220505072244.1155033-6-masahiroy@kernel.org>
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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
To: linux-kbuild@vger.kernel.org
Cc: clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>, Ard Biesheuvel <ardb@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org, linux-s390@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Kees Cook <keescook@chromium.org>, Masahiro Yamada <masahiroy@kernel.org>

A *.mod file lists the member objects of a module, but vmlinux does
not have such a file to list out all the member objects.

Generate this list to allow modpost to know all the member objects.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

(no changes since v2)

Changes in v2:
  - Move '> .vmlinux.objs' to the outside of the loop (Nicolas)
  - Clean up .vmlinux.objs explicitly

 scripts/link-vmlinux.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 20f44504a644..eceb3ee7ec06 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -311,6 +311,7 @@ cleanup()
 	rm -f vmlinux.map
 	rm -f vmlinux.o
 	rm -f .vmlinux.d
+	rm -f .vmlinux.objs
 }
 
 # Use "make V=1" to debug this script
@@ -342,6 +343,16 @@ ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 modpost_link vmlinux.o
 objtool_link vmlinux.o
 
+# Generate the list of objects in vmlinux
+for f in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
+	case ${f} in
+	*.a)
+		${AR} t ${f} ;;
+	*)
+		echo ${f} ;;
+	esac
+done > .vmlinux.objs
+
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" MODPOST_VMLINUX=1
 
-- 
2.32.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

