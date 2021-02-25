Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v3 00/15] printk: remove logbuf_lock
Date: Thu, 25 Feb 2021 21:24:23 +0100
Message-Id: <20210225202438.28985-1-john.ogness@linutronix.de>
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
To: Petr Mladek <pmladek@suse.com>
Cc: linux-hyperv@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Douglas Anderson <dianders@chromium.org>, linux-mtd@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, Miquel Raynal <miquel.raynal@bootlin.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Thomas Meyer <thomas@m3y3r.de>, Kees Cook <keescook@chromium.org>, Daniel Thompson <daniel.thompson@linaro.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Stephen Hemminger <sthemmin@microsoft.com>, Richard Weinberger <richard@nod.at>, Anton Vorontsov <anton@enomsg.org>, Joel Stanley <joel@jms.id.au>, Jordan Niethe <jniethe5@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Wei Li <liwei391@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Alistair Popple <alistair@popple.id.au>, Jeff Dike <jdike@addtoit.com>, Colin Cross <ccross@android.com>, linux-um@lists.infradead.org, Wei Liu <wei.liu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Davidlohr Bueso <dave@stgolabs.net>, Nicholas Piggin <npiggin@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Michael Kelley <mikelley@microsoft.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Sumit Garg <sumit.garg@linaro.org>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Mike Rapoport <rppt@kernel.org>

Hello,

Here is v3 of a series to remove @logbuf_lock, exposing the
ringbuffer locklessly to both readers and writers. v2 is here [0].

Since @logbuf_lock was protecting much more than just the
ringbuffer, this series clarifies and cleans up the various
protections using comments, lockless accessors, atomic types, and a
new finer-grained @syslog_lock.

Removing @logbuf_lock required changing the semantics of the
kmsg_dumper callback in order to work locklessly. Since this
involved touching all the kmsg_dump users, we also decided [1] to
use this opportunity to clean up and clarify the kmsg_dump semantics
in general.

This series is based on next-20210225.

Changes since v2:

- use get_maintainer.pl to get the full list of developers that
  should at least see the changes in their respective areas

- do not disable interrupts in arch/um kmsg_dumper (because there is
  no need to)

- protect the mtd/mtdoops kmsg_dumper buffer against concurrent
  dumps

- update kerneldoc for kmsg_dump_get_line() (@len_out)

- remove ksmg_dump's @active flag

- change kmsg_dumper callback to:
  void (*dump)(enum kmsg_dump_reason reason);

- rename kmsg_dumper_iter to kmsg_dump_iter

- update kmsg_dumpers to use their own kmsg_dump_iter (and
  initialize it with kmsg_dump_rewind() if necessary)

John Ogness

[0] https://lkml.kernel.org/r/20210218081817.28849-1-john.ogness@linutronix.de
[1] https://lkml.kernel.org/r/YDeZAA08NKCHa4s%2F@alley

John Ogness (15):
  um: synchronize kmsg_dumper
  mtd: mtdoops: synchronize kmsg_dumper
  printk: limit second loop of syslog_print_all
  printk: kmsg_dump: remove unused fields
  printk: refactor kmsg_dump_get_buffer()
  printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
  printk: introduce CONSOLE_LOG_MAX for improved multi-line support
  printk: use seqcount_latch for clear_seq
  printk: use atomic64_t for devkmsg_user.seq
  printk: add syslog_lock
  printk: kmsg_dumper: remove @active field
  printk: introduce a kmsg_dump iterator
  printk: remove logbuf_lock
  printk: kmsg_dump: remove _nolock() variants
  printk: console: remove unnecessary safe buffer usage

 arch/powerpc/kernel/nvram_64.c             |  14 +-
 arch/powerpc/platforms/powernv/opal-kmsg.c |   3 +-
 arch/powerpc/xmon/xmon.c                   |   6 +-
 arch/um/kernel/kmsg_dump.c                 |  15 +-
 drivers/hv/vmbus_drv.c                     |   7 +-
 drivers/mtd/mtdoops.c                      |  20 +-
 fs/pstore/platform.c                       |   8 +-
 include/linux/kmsg_dump.h                  |  49 +--
 kernel/debug/kdb/kdb_main.c                |  10 +-
 kernel/printk/internal.h                   |   4 +-
 kernel/printk/printk.c                     | 456 ++++++++++-----------
 kernel/printk/printk_safe.c                |  27 +-
 12 files changed, 309 insertions(+), 310 deletions(-)

-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

