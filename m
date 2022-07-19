Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH v2 00/13] The panic notifiers refactor strikes back - fixes/clean-ups
Date: Tue, 19 Jul 2022 16:53:13 -0300
Message-Id: <20220719195325.402745-1-gpiccoli@igalia.com>
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
To: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, bcm-kernel-feedback-list@broadcom.com, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, linux-efi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org

Hi folks, this the second iteration of the panic notifiers refactor work,
but limited to the fixes/clean-ups in the first moment. The (full) V1 is
available at:
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/

The idea of splitting the series is that, originally we had a bunch of fixes
followed by the notifiers refactor, but this second part (the effective
refactor) is a bit "polemic", with reviews having antagonistic goals and some
complexities  - it might be hard to achieve consensus.
For the curious, here is a good summary of the conflicting views and some
strategies we might take in the refactor V2:
https://lore.kernel.org/lkml/0d084eed-4781-c815-29c7-ac62c498e216@igalia.com/

So splitting and sending only the simple fixes/clean-ups in a first moment
makes sense, this way we don't prevent them to be discussed/merged/reworked
while the more complex part is subject to scrutiny in a different (future)
email thread.


I've tried to test this series building for all affected architecture/drivers
and also through some boot/runtime tests; below the test "matrix" used:

Build tests (using cross-compilers): alpha, arm, arm64, parisc, um, x86_64.
Boot/Runtime tests: x86_64 (Hyper-V and QEMU guests).

Here is the link with the .config files used:
https://people.igalia.com/gpiccoli/panic_notifiers_configs/5.19-rc7/
(tried my best to build all the affected code).


The series is based on 5.19-rc7; I'd like to ask that, if possible, maintainers
take the patches here in their trees, since there is no need to merge the series
as whole, patches are independent from each other.

Regarding the CC strategy, I've tried to reduce a bit the list of CCed emails,
given that it was huge in the first iteration. Hopefully I didn't forget
anybody interested in the topic (my apologies if so).

As usual, reviews / comments are always welcome, thanks in advance for them!
Cheers,


Guilherme




Guilherme G. Piccoli (13):
  ARM: Disable FIQs (but not IRQs) on CPUs shutdown paths
  notifier: Add panic notifiers info and purge trailing whitespaces
  firmware: google: Test spinlock on panic path to avoid lockups
  soc: bcm: brcmstb: Document panic notifier action and remove useless header
  alpha: Clean-up the panic notifier code
  um: Improve panic notifiers consistency and ordering
  parisc: Replace regular spinlock with spin_trylock on panic path
  tracing: Improve panic/die notifiers
  notifier: Show function names on notifier routines if DEBUG_NOTIFIERS is set
  EDAC/altera: Skip the panic notifier if kdump is loaded
  video/hyperv_fb: Avoid taking busy spinlock on panic path
  drivers/hv/vmbus, video/hyperv_fb: Untangle and refactor Hyper-V panic notifiers
  panic: Fixes the panic_print NMI backtrace setting

 arch/alpha/kernel/setup.c           |  36 ++++-----
 arch/arm/kernel/machine_kexec.c     |   2 +
 arch/arm/kernel/smp.c               |   5 +-
 arch/parisc/include/asm/pdc.h       |   1 +
 arch/parisc/kernel/firmware.c       |  27 ++++++-
 arch/um/drivers/mconsole_kern.c     |   7 +-
 arch/um/kernel/um_arch.c            |   8 +-
 drivers/edac/altera_edac.c          |  16 +++-
 drivers/firmware/google/gsmi.c      |   8 ++
 drivers/hv/ring_buffer.c            |  16 ++++
 drivers/hv/vmbus_drv.c              | 109 +++++++++++++++++-----------
 drivers/parisc/power.c              |  17 +++--
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  16 +++-
 drivers/video/fbdev/hyperv_fb.c     |  16 +++-
 include/linux/hyperv.h              |   2 +
 include/linux/notifier.h            |   8 +-
 kernel/notifier.c                   |  22 ++++--
 kernel/panic.c                      |  47 +++++++-----
 kernel/trace/trace.c                |  55 +++++++-------
 19 files changed, 268 insertions(+), 150 deletions(-)

-- 
2.37.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

