Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] um: add 2 missing libs to fix various build errors
Date: Sun,  4 Apr 2021 11:20:44 -0700
Message-Id: <20210404182044.9918-1-rdunlap@infradead.org>
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
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Brendan Jackman <jackmanb@google.com>, Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Johannes Berg <johannes@sipsolutions.net>, Johannes Berg <johannes.berg@intel.com>

Fix many build errors (at least 18 build error reports) for uml on i386
by adding 2 more library object files. All missing symbols are
either cmpxchg8b_emu or atomic*386.

Here are a few examples of the build errors that are eliminated:

   /usr/bin/ld: core.c:(.text+0xd83): undefined reference to `cmpxchg8b_emu'
   /usr/bin/ld: core.c:(.text+0x2bb2): undefined reference to `atomic64_add_386'
   /usr/bin/ld: core.c:(.text+0x2c5d): undefined reference to `atomic64_xchg_386'
   syscall.c:(.text+0x2f49): undefined reference to `atomic64_set_386'
   /usr/bin/ld: syscall.c:(.text+0x2f54): undefined reference to `atomic64_set_386'
   syscall.c:(.text+0x33a4): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: syscall.c:(.text+0x33ac): undefined reference to `atomic64_inc_386'
   /usr/bin/ld: net/ipv4/inet_timewait_sock.o: in function `inet_twsk_alloc':
   inet_timewait_sock.c:(.text+0x3d1): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_timewait_sock.c:(.text+0x3dd): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/inet_connection_sock.o: in function `inet_csk_clone_lock':
   inet_connection_sock.c:(.text+0x1d74): undefined reference to `atomic64_read_386'
   /usr/bin/ld: inet_connection_sock.c:(.text+0x1d80): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/ipv4/tcp_input.o: in function `inet_reqsk_alloc':
   tcp_input.c:(.text+0xa345): undefined reference to `atomic64_set_386'
   /usr/bin/ld: net/mac80211/wpa.o: in function `ieee80211_crypto_tkip_encrypt':
   wpa.c:(.text+0x739): undefined reference to `atomic64_inc_return_386'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Brendan Jackman <jackmanb@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: kbuild-all@lists.01.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>
---
My UML on i386 build environment is br0ken so this is not tested other
than to see that the .o files are built as expected.
If someone can test/verify it, please respond. Thanks.

 arch/x86/um/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- lnx-512-rc5.orig/arch/x86/um/Makefile
+++ lnx-512-rc5/arch/x86/um/Makefile
@@ -21,6 +21,7 @@ obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
+subarch-y += ../lib/cmpxchg8b_emu.o ../lib/atomic64_386_32.o
 subarch-y += ../kernel/sys_ia32.o
 
 else

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

