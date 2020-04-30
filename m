Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 48/57] um: ensure `make ARCH=um mrproper` removes arch/$(SUBARCH)/include/generated/
Date: Thu, 30 Apr 2020 09:52:09 -0400
Message-Id: <20200430135218.20372-48-sashal@kernel.org>
In-Reply-To: <20200430135218.20372-1-sashal@kernel.org>
References: <20200430135218.20372-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Vitor Massaru Iha <vitor@massaru.org>, Theodore Ts'o <tytso@mit.edu>, Masahiro Yamada <masahiroy@kernel.org>, Brendan Higgins <brendanhiggins@google.com>, Sasha Levin <sashal@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Vitor Massaru Iha <vitor@massaru.org>

[ Upstream commit 63ec90f18204f2fe072df108de8a021b28b1b173 ]

In this workflow:

$ make ARCH=um defconfig && make ARCH=um -j8
  [snip]
$ make ARCH=um mrproper
  [snip]
$ make ARCH=um defconfig O=./build_um && make ARCH=um -j8 O=./build_um
  [snip]
  CC      scripts/mod/empty.o
In file included from ../include/linux/types.h:6,
                 from ../include/linux/mod_devicetable.h:12,
                 from ../scripts/mod/devicetable-offsets.c:3:
../include/uapi/linux/types.h:5:10: fatal error: asm/types.h: No such file or directory
    5 | #include <asm/types.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [../scripts/Makefile.build:100: scripts/mod/devicetable-offsets.s] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/iha/sdb/opensource/lkmp/linux-kselftest.git/Makefile:1140: prepare0] Error 2
make[1]: Leaving directory '/home/iha/sdb/opensource/lkmp/linux-kselftest.git/build_um'
make: *** [Makefile:180: sub-make] Error 2

The cause of the error was because arch/$(SUBARCH)/include/generated files
weren't properly cleaned by `make ARCH=um mrproper`.

Fixes: a788b2ed81ab ("kbuild: check arch/$(SRCARCH)/include/generated before out-of-tree build")
Reported-by: Theodore Ts'o <tytso@mit.edu>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
Link: https://groups.google.com/forum/#!msg/kunit-dev/QmA27YEgEgI/hvS1kiz2CwAJ
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index d2daa206872da..275f5ffdf6f0a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -140,6 +140,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
+MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.20.1


