Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655FDC4321E
	for <linux-um@archiver.kernel.org>; Mon,  7 Nov 2022 14:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CHlJR/NG4YVGnH5B+gjQTsFeYTceO67VQoPDlyTVfiY=; b=k3WVoJGDqbZLgo
	zNMKjinZJ6fLFbtEYSiPieP/05z9p7vtTRnSDa/cO1rtbW/MAJrycZLcshY7a9xeLacDt72COy+YL
	09V5SSPSJChqD2sOkRkyOl07f+CWgh1cy8yNKEq2svkRn3P/qm8XJahaBvACrF70JWAvgcIG7+peh
	uPBzybdne90O9ueBYGf+drjGw7iRzScAaXKA/jgeEBthq53/T8KUwZHFII2Hy90YT8t1c+uN0ZICa
	5JcgJTHvfeLrzG7Tt0ffWpg+ZZyia6HT+Hd8e6eEiFtkqmVcPw7kLUuCHaQr8mg2NBBN+/IoYREws
	vrqzBbZBCaUGJDZ3Ib5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vz-00F9m9-O9; Mon, 07 Nov 2022 14:17:07 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1os2vf-00F9aV-OT; Mon, 07 Nov 2022 14:16:50 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1667830600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zf2Nnq9aaBhq9OyJBdbPoPZazbYrZ5ZYcguoDhN8w38=;
	b=2DMdV6P5I8sPplJufSLuueHeVl4bvVMKaOCMLHG/8T/fwK7DAOABqqdX7aJ+59oIKbSeI/
	jxIUQ7vmqJIWBg5uBPUnLwho/ozyVcK4cifb7E8MZWqNAgvSZcTQkooqi2XOBJKmdFoPe0
	S/wZC7FHNIjNqHF8aKh2I4aJghp93sxvUy5SQTr2sLIW2gINDw/7UBtkXqGJH9YxH5hhOO
	0O67dTObUBp0/Va8bcvOAkYNduQYwv+rsV/BkAAXQ2emD/fAX8uWsiRgCCzSlHK71l+mxd
	DWhAO2yHDDwVwuy7tiy10mhyFAMcwaRZxpwSCRbmOIfW9QXr83hR7vV88Ebaiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1667830600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zf2Nnq9aaBhq9OyJBdbPoPZazbYrZ5ZYcguoDhN8w38=;
	b=jYEgYMmbvDXYj7DRG/zDjOcuyxgqHf6CJ4sMHlEhQTQPnAhOStcpCmHEsG9VmODdbETAmt
	FuRjrih+zd0krvCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Aaron Tomlin <atomlin@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Tony Lindgren <tony@atomide.com>,
	Lukas Wunner <lukas@wunner.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Michal Simek <michal.simek@xilinx.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Tom Rix <trix@redhat.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH printk v3 00/40] reduce console_lock scope
Date: Mon,  7 Nov 2022 15:21:58 +0106
Message-Id: <20221107141638.3790965-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_061648_122301_435E49BC 
X-CRM114-Status: GOOD (  21.37  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This is v3 of a series to prepare for threaded/atomic
printing. v2 is here [0]. This series focuses on reducing the
scope of the BKL console_lock. It achieves this by switching to
SRCU and a dedicated mutex for console list iteration and
modification, respectively. The console_lock will no longer
offer this protection and is completely removed from
(un)register_console() and console_stop/start() code.

Also, during the review of v2 it came to our attention that
many console drivers are checking CON_ENABLED to see if they
are registered. Because this flag can change without
unregistering and because this flag does not represent an
atomic point when an (un)registration process is complete,
a new console_is_registered() function is introduced. This
function uses the console_list_lock to synchronize with the
(un)registration process to provide a reliable status.

All users of the console_lock for list iteration have been
modified. For the call sites where the console_lock is still
needed (because of other reasons), comments are added to
explain exactly why the console_lock was needed.

All users of CON_ENABLED for registration status have been
modified to use console_is_registered(). Note that there are
still users of CON_ENABLED, but this is for legitimate purposes
about a registered console being able to print.

The base commit for this series is from Paul McKenney's RCU tree
and provides an NMI-safe SRCU implementation [1]. Without the
NMI-safe SRCU implementation, this series is not less safe than
mainline. But we will need the NMI-safe SRCU implementation for
atomic consoles anyway, so we might as well get it in
now. Especially since it _does_ increase the reliability for
mainline in the panic path.

Changes since v3:

general:

- introduce a synchronized console_is_registered() to query if
  a console is registered, meant to replace CON_ENABLED
  (mis)use for this purpose

- directly read console->flags for registered consoles if it is
  race-free (and document that it is so)

- replace uart_console_enabled() with a new
  uart_console_registered() based on console_is_registered()

- change comments about why console_lock is used to synchronize
  console->device() by providing an example

registration check fixups:

- the following drivers were modified to use the new
  console_is_registered() instead of CON_ENABLED checks

   - arch/m68k/emu/nfcon.c
   - drivers/firmware/efi/earlycon.c
   - drivers/net/netconsole.c
   - drivers/tty/hvc/hvc_console.c
   - drivers/tty/serial/8250/8250_core.c
   - drivers/tty/serial/earlycon.c
   - drivers/tty/serial/pic32_uart.c
   - drivers/tty/serial/samsung_tty.c
   - drivers/tty/serial/serial_core.c
   - drivers/tty/serial/xilinx_uartps.c
   - drivers/usb/early/xhci-dbc.c

um: kmsg_dumper:

- change stdout dump criteria to match original intention

kgdb/kdb:

- in configure_kgdboc(), take console_list_lock to synchronize
  tty_find_polling_driver() against register_console()

- add comments explaining why calling console->write() without
  locking might work

tty: sh-sci:

- use a setup() callback to setup the early console

fbdev: xen:

- implement a cleaner approach for
  console_force_preferred_locked()

rcu:

- implement debug_lockdep_rcu_enabled() for
  !CONFIG_DEBUG_LOCK_ALLOC

printk:

- check CONFIG_DEBUG_LOCK_ALLOC for srcu_read_lock_held()
  availability

- for console_lock/_trylock/_unlock, replace "lock the console
  system" language with "block the console subsystem from
  printing"

- use WRITE_ONCE() for updating console->flags of registered
  consoles

- expand comments of synchronize_srcu() calls to explain why
  they are needed, and also expand comments to explain when it
  is not needed

- change CON_BOOT consoles to always begin at earliest message

- for non-BOOT/non-PRINTBUFFER consoles, initialize @seq to the
  minimal @seq of any of the enabled boot consoles

- add comments and lockdep assertion to
  unregister_console_locked() because it is not clear from the
  name which lock is implied

- dropped patches that caused unnecessary churn in the series

John Ogness

[0] https://lore.kernel.org/lkml/20221019145600.1282823-1-john.ogness@linutronix.de
[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=srcunmisafe.2022.10.21a

John Ogness (38):
  rcu: implement lockdep_rcu_enabled for !CONFIG_DEBUG_LOCK_ALLOC
  printk: Prepare for SRCU console list protection
  printk: fix setting first seq for consoles
  um: kmsg_dump: only dump when no output console available
  console: introduce console_is_enabled() wrapper
  printk: use console_is_enabled()
  um: kmsg_dump: use console_is_enabled()
  kdb: kdb_io: use console_is_enabled()
  um: kmsg_dumper: use srcu console list iterator
  tty: serial: kgdboc: document console_lock usage
  tty: tty_io: document console_lock usage
  proc: consoles: document console_lock usage
  kdb: use srcu console list iterator
  printk: console_flush_all: use srcu console list iterator
  printk: console_unblank: use srcu console list iterator
  printk: console_flush_on_panic: use srcu console list iterator
  printk: console_device: use srcu console list iterator
  printk: __pr_flush: use srcu console list iterator
  printk: introduce console_list_lock
  console: introduce console_is_registered()
  serial_core: replace uart_console_enabled() with
    uart_console_registered()
  tty: nfcon: use console_is_registered()
  efi: earlycon: use console_is_registered()
  tty: hvc: use console_is_registered()
  tty: serial: earlycon: use console_is_registered()
  tty: serial: pic32_uart: use console_is_registered()
  tty: serial: samsung_tty: use console_is_registered()
  tty: serial: xilinx_uartps: use console_is_registered()
  usb: early: xhci-dbc: use console_is_registered()
  netconsole: avoid CON_ENABLED misuse to track registration
  printk, xen: fbfront: create/use safe function for forcing preferred
  tty: tty_io: use console_list_lock for list synchronization
  proc: consoles: use console_list_lock for list iteration
  tty: serial: kgdboc: use console_list_lock for list traversal
  tty: serial: kgdboc: synchronize tty_find_polling_driver() and
    register_console()
  tty: serial: kgdboc: use console_list_lock to trap exit
  printk: relieve console_lock of list synchronization duties
  tty: serial: sh-sci: use setup() callback for early console

Thomas Gleixner (2):
  serial: kgdboc: Lock console list in probe function
  printk: Convert console_drivers list to hlist

 .clang-format                       |   1 +
 arch/m68k/emu/nfcon.c               |  10 +-
 arch/um/kernel/kmsg_dump.c          |  24 +-
 drivers/firmware/efi/earlycon.c     |   8 +-
 drivers/net/netconsole.c            |  21 +-
 drivers/tty/hvc/hvc_console.c       |   4 +-
 drivers/tty/serial/8250/8250_core.c |   2 +-
 drivers/tty/serial/earlycon.c       |   4 +-
 drivers/tty/serial/kgdboc.c         |  46 ++-
 drivers/tty/serial/pic32_uart.c     |   4 +-
 drivers/tty/serial/samsung_tty.c    |   2 +-
 drivers/tty/serial/serial_core.c    |  14 +-
 drivers/tty/serial/sh-sci.c         |  17 +-
 drivers/tty/serial/xilinx_uartps.c  |   2 +-
 drivers/tty/tty_io.c                |  18 +-
 drivers/usb/early/xhci-dbc.c        |   2 +-
 drivers/video/fbdev/xen-fbfront.c   |  12 +-
 fs/proc/consoles.c                  |  21 +-
 include/linux/console.h             | 111 +++++++-
 include/linux/rcupdate.h            |   5 +
 include/linux/serial_core.h         |  15 +-
 kernel/debug/kdb/kdb_io.c           |  14 +-
 kernel/printk/printk.c              | 424 +++++++++++++++++++++-------
 23 files changed, 605 insertions(+), 176 deletions(-)


base-commit: e29a4915db1480f96e0bc2e928699d086a71f43c
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
