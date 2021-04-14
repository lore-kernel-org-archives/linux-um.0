Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 0/3] um: headers: fix various W=1 warnings
Date: Tue, 13 Apr 2021 23:43:47 -0700
Message-Id: <20210414064350.3923-1-rdunlap@infradead.org>
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
Cc: Randy Dunlap <rdunlap@infradead.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

Fix a few W=1 warnings in arch/um/.
Prompted by the "kernel test robot".

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org

 [PATCH 1/3] um: pgtable.h: fix W=1 warning for empty body in 'do' statement
 [PATCH 2/3] um: elf.h: fix W=1 warning for empty body in 'do' statement
 [PATCH 3/3] um: stub_32.h: move 'inline' before 'void' to fix W=1 warning

 arch/um/include/asm/pgtable.h       |    2 +-
 arch/x86/um/asm/elf.h               |    2 +-
 arch/x86/um/shared/sysdep/stub_32.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

