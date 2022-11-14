Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4B3C4332F
	for <linux-um@archiver.kernel.org>; Mon, 14 Nov 2022 16:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Da8hW+5gG+pq9m+ZmfbJ/1HX7iY+zg3r9A1ZKkn8OZE=; b=T8lpcFtW2G6oby
	qkBDA/ihLv/rTN3GTqlMwtS4hYjh6uDy/TjFmV6+QJO3omnHCh5dMhUkThQRs00lG3rUZiwg20vu5
	yYVGJjnPb7QxYIgItO6XTha1HVbE0h97AGeZeqbpqat4A0Qxei0ZdJvLAK4MLwgpLLWDWOtaIb5+5
	c8d51+Q6CkcEDtpfKdcDXGFGYM978zoN+wIYhR+oLelgWiJEs/GibBEF5tHe2O9M3k3K7+dt+lB5L
	t44BOrTgaVlznczI9Lwe3IcbYHTm2uL17qpR0fRnkvd/I3eQj92CAmWTrfvjsEHm/LZiTvxdt3wJK
	1SkvdkPHnlZ6f1L0O3MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucLQ-002iiz-8r; Mon, 14 Nov 2022 16:30:00 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oucLC-002iaT-M2; Mon, 14 Nov 2022 16:29:50 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668443374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ia89HZSRLXOgXaOdEDVfM/lt8urljrOhJdnHfXmKjU=;
	b=YiZgYIzbGCS66YXIbnxE6HJSvuTozQJVm58tUWdD2n4y28gjtW1uZFFKiE4stX4GyLd79p
	+YNdGDP8PJqfheCbYANqK1Acwttrp3+h1Arxlm6dnx/imsSfHBTsvWINJO1FTQWjJLFhec
	x9r0v+8OmvuighJO6BPLWW3526LiM9UaibGBRmcynkQdxf8FtKRpskdXdCeaQDDIl9q+DS
	/iw1SO/WUFNDXJkVPXBCXepuK+u5fcd7eB1JJwMSHpqzBybgcxVOcAekyMdJIDu6B57+G0
	3iJH018PYhIpqraxqEXvulW/RG3bmOcweaxcG4nokqF6cr2lDsbBuWvm+JkA9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668443374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2ia89HZSRLXOgXaOdEDVfM/lt8urljrOhJdnHfXmKjU=;
	b=yWQ3DUdGxE8HiQ+BCoA7MfdIFiUkgVb02pKvTJXiNVqXlQM6ZDYyW+UBcx0rL+UguDA25s
	z9obC1MVjJfJPMCg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
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
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
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
Subject: [PATCH printk v4 00/39] reduce console_lock scope
Date: Mon, 14 Nov 2022 17:34:53 +0106
Message-Id: <20221114162932.141883-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_082947_065045_BB5F8DF1 
X-CRM114-Status: GOOD (  18.73  )
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

This is v4 of a series to prepare for threaded/atomic
printing. v3 is here [0]. This series focuses on reducing the
scope of the BKL console_lock. It achieves this by switching to
SRCU and a dedicated mutex for console list iteration and
modification, respectively. The console_lock will no longer
offer this protection.

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
needed (for other reasons), comments are added to explain
exactly why the console_lock was needed.

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

- Implement console_srcu_read_flags() and console_srcu_write_flags()
  to be used for console->flags access under the srcu_read_lock or
  console_list_lock, respectively. The functions document their
  relationship to one another and use data_race(), READ_ONCE(), and
  WRITE_ONCE() macros to annotate their relationship. They also make
  use of lockdep to warn if used in improper contexts.

- Replace all console_is_enabled() usage with
  console_srcu_read_flags() (all were under the srcu_read_lock).

serial_core:

- For uart_console_registered(), check uart_console() before taking
  the console_list_lock to avoid unnecessary lock contention for
  non-console ports.

m68k/emu/nfcon:

- Only explicitly enable the console if registering via debug=nfcon.

tty/serial/sh-sci:

- Add comments about why @options will always be NULL for the
  earlyprintk console.

kdb:

- Add comments explaining the expectations for console drivers to
  work correctly.

printk:

- Some code sites under SRCU were checking flags directly. Use
  console_srcu_read_flags() instead.

- In register_console() rename bootcon_enabled/realcon_enabled to
  bootcon_registered/realcon_registered to avoid confusion.

- In register_console() only check for boot console sequences if a
  boot console is registered and !keep_bootcon. In this case, also
  take the console_lock to guarantee safe access to console->seq.

- In console_force_preferred_locked() use hlist_del_rcu() instead of
  hlist_del_init_rcu() so that there is never a window where the
  console can be viewed as unregistered.

John Ogness

[0] https://lore.kernel.org/lkml/20221107141638.3790965-1-john.ogness@linutronix.de
[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=srcunmisafe.2022.11.09a

John Ogness (37):
  printk: Prepare for SRCU console list protection
  printk: register_console: use "registered" for variable names
  printk: fix setting first seq for consoles
  um: kmsg_dump: only dump when no output console available
  tty: serial: kgdboc: document console_lock usage
  tty: tty_io: document console_lock usage
  proc: consoles: document console_lock usage
  printk: introduce console_list_lock
  console: introduce wrappers to read/write console flags
  um: kmsg_dumper: use srcu console list iterator
  kdb: use srcu console list iterator
  printk: console_flush_all: use srcu console list iterator
  printk: __pr_flush: use srcu console list iterator
  printk: console_is_usable: use console_srcu_read_flags
  printk: console_unblank: use srcu console list iterator
  printk: console_flush_on_panic: use srcu console list iterator
  printk: console_device: use srcu console list iterator
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
  tty: serial: kgdboc: use srcu console list iterator
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
 arch/m68k/emu/nfcon.c               |   9 +-
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
 drivers/tty/serial/sh-sci.c         |  20 +-
 drivers/tty/serial/xilinx_uartps.c  |   2 +-
 drivers/tty/tty_io.c                |  18 +-
 drivers/usb/early/xhci-dbc.c        |   2 +-
 drivers/video/fbdev/xen-fbfront.c   |  12 +-
 fs/proc/consoles.c                  |  21 +-
 include/linux/console.h             | 129 +++++++-
 include/linux/serial_core.h         |  10 +-
 kernel/debug/kdb/kdb_io.c           |  18 +-
 kernel/printk/printk.c              | 459 +++++++++++++++++++++-------
 22 files changed, 648 insertions(+), 182 deletions(-)


base-commit: f733615e39aa2d6ddeef33b7b2c9aa6a5a2c2785
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
