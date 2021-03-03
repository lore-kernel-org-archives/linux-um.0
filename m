Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH next v4 00/15] printk: remove logbuf_lock
Date: Wed,  3 Mar 2021 11:15:13 +0100
Message-Id: <20210303101528.29901-1-john.ogness@linutronix.de>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, Kees Cook <keescook@chromium.org>, Pavel Tatashin <pasha.tatashin@soleen.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <daniel.thompson@linaro.org>, Douglas Anderson <dianders@chromium.org>, Jordan Niethe <jniethe5@gmail.com>, Alistair Popple <alistair@popple.id.au>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Wei Li <liwei391@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>, linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Michael Kelley <mikelley@microsoft.com>, linux-hyperv@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
List-ID: <linux-um.lists.infradead.org>

Hello,

Here is v4 of a series to remove @logbuf_lock, exposing the
ringbuffer locklessly to both readers and writers. v3 is
here [0].

Since @logbuf_lock was protecting much more than just the
ringbuffer, this series clarifies and cleans up the various
protections using comments, lockless accessors, atomic types,
and a new finer-grained @syslog_lock.

Removing @logbuf_lock required changing the semantics of the
kmsg_dumper callback in order to work locklessly. This series
adjusts all kmsg_dumpers and users of the kmsg_dump_get_*()
functions for the new semantics.

This series is based on next-20210303.

Changes since v3:

- disable interrupts in the arch/um kmsg_dumper

- reduce CONSOLE_LOG_MAX value from 4096 back to 1024 to revert
  the increasd 3KiB static memory footprint

- change the kmsg_dumper() callback prototype back to how it
  was because some dumpers need the registered object for
  container_of() usage

- for kmsg_dump_get_line()/kmsg_dump_get_buffer() restrict the
  minimal allowed sequence number to the cleared sequence number

John Ogness

[0] https://lore.kernel.org/lkml/20210225202438.28985-1-john.ogness@linutronix.de/

John Ogness (15):
  um: synchronize kmsg_dumper
  mtd: mtdoops: synchronize kmsg_dumper
  printk: limit second loop of syslog_print_all
  printk: kmsg_dump: remove unused fields
  printk: refactor kmsg_dump_get_buffer()
  printk: consolidate kmsg_dump_get_buffer/syslog_print_all code
  printk: introduce CONSOLE_LOG_MAX
  printk: use seqcount_latch for clear_seq
  printk: use atomic64_t for devkmsg_user.seq
  printk: add syslog_lock
  printk: kmsg_dumper: remove @active field
  printk: introduce a kmsg_dump iterator
  printk: remove logbuf_lock
  printk: kmsg_dump: remove _nolock() variants
  printk: console: remove unnecessary safe buffer usage

 arch/powerpc/kernel/nvram_64.c |   8 +-
 arch/powerpc/xmon/xmon.c       |   6 +-
 arch/um/kernel/kmsg_dump.c     |  13 +-
 drivers/hv/vmbus_drv.c         |   4 +-
 drivers/mtd/mtdoops.c          |  17 +-
 fs/pstore/platform.c           |   5 +-
 include/linux/kmsg_dump.h      |  47 ++--
 kernel/debug/kdb/kdb_main.c    |  10 +-
 kernel/printk/internal.h       |   4 +-
 kernel/printk/printk.c         | 464 +++++++++++++++++----------------
 kernel/printk/printk_safe.c    |  27 +-
 11 files changed, 310 insertions(+), 295 deletions(-)

-- 
2.20.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

