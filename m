Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwAAy-0003r5-0L
 for linux-um@lists.infradead.org; Mon, 27 Jan 2020 19:36:01 +0000
Received: by mail-pj1-x1049.google.com with SMTP id x16so5442722pjq.7
 for <linux-um@lists.infradead.org>; Mon, 27 Jan 2020 11:35:58 -0800 (PST)
Date: Mon, 27 Jan 2020 11:35:47 -0800
Message-Id: <20200127193549.187419-1-brendanhiggins@google.com>
Mime-Version: 1.0
Subject: [RFC v1 0/2] arch: um: turn BTF_TYPEINFO support off
From: Brendan Higgins <brendanhiggins@google.com>
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
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org, changbin.du@intel.com, yamada.masahiro@socionext.com, rdunlap@infradead.org, keescook@chromium.org, andriy.shevchenko@linux.intel.com
Cc: Brendan Higgins <brendanhiggins@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, heidifahim@google.com

As a part of my quest to get allyesconfig working on UML, I found a new
build error, with CONFIG_DEBUG_INFO_BTF=y:

scripts/link-vmlinux.sh: line 106: 17463 Segmentation fault      LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
objcopy: --change-section-vma .BTF=0x0000000000000000 never used
objcopy: --change-section-lma .BTF=0x0000000000000000 never used
objcopy: error: the input file '.btf.vmlinux.bin' is empty
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
make: *** [Makefile:1078: vmlinux] Error 1

The most interesting bit seems to be the:

objcopy: error: the input file '.btf.vmlinux.bin' is empty

Thinking about it, I am not sure if it makes sense for UML to produce
BTF type information, so I proposed a fix here that:

 1. Adds the ability for architectures to turn BTF support off.
 2. Turns BTF support off for UML.

I am also totally fine with just saying that DEBUG_INFO_BTF
depends on !UML, but I figured people would prefer this approach more.

Brendan Higgins (2):
  kbuild: add arch specific dependency for BTF support
  arch: um: turn BTF_TYPEINFO support off

 arch/um/Kconfig   | 1 +
 lib/Kconfig.debug | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.25.0.341.g760bfbb309-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

