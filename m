Return-Path: <linux-arm-kernel-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 27 Mar 2015 20:43:34 +0900
Message-Id: <1427456618-23830-1-git-send-email-yamada.masahiro@socionext.com>
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
Subject: [PATCH 0/4] kbuild: refactor Makefile inclusion
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>, linux-mips@linux-mips.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Fenghua Yu <fenghua.yu@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Ingo Molnar <mingo@redhat.com>, user-mode-linux-user@lists.sourceforge.net, "H. Peter Anvin" <hpa@zytor.com>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Masahiro Yamada (4):
  kbuild: use relative path to include Makefile
  kbuild: use relative path more to include Makefile
  kbuild: include $(src)/Makefile rather than $(obj)/Makefile
  kbuild: ia64: use $(src)/Makefile.gate rather than particular path

 Makefile                  | 22 ++++++++++------------
 arch/arm/boot/Makefile    |  2 +-
 arch/ia64/kernel/Makefile |  2 +-
 arch/mips/Makefile        |  2 +-
 arch/um/Makefile          |  6 +++---
 arch/x86/Makefile         |  2 +-
 arch/x86/Makefile.um      |  2 +-
 scripts/Makefile.dtbinst  |  2 +-
 scripts/Makefile.fwinst   |  2 +-
 9 files changed, 20 insertions(+), 22 deletions(-)

-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

