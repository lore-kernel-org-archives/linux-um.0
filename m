Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03500C43217
	for <linux-um@archiver.kernel.org>; Wed, 16 Nov 2022 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tNOR+gqGQTAcU2YMtCd1eczEtVmUBNY2BBd/lFeMjBo=; b=ucFgByAqoH6wsR
	YT/lnXIf8qG0cXICn60JmkPgFxOp4rOJshXSONhiwE47q6dCyytcGcxdyR0nXyrjGSWByhluRkeVZ
	Ue+pjYzEc5C7CfYRdwZgx8ratxt9Ecos5B2oPNDH+6/a1ysvQjT4IllkzJxEMTdBXv7XHqHaT7hvX
	g+FJtJWUbKSYXcv5A5aHsQnwpXGAT/xVf6edy766SuU8QlHHbZt4HSzgOdSAX8iTBVXw1bdqmZasv
	V/YCJfuV+Hw9Tym8olmKu1pWb7o8jRCOoYOl9AeXVhUcRQJnQgMkwQEDG87uGGPKFx97vdqGAH1u5
	WUUcY7yxEZlERRyl6xOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovMFc-006RGA-Pk; Wed, 16 Nov 2022 17:31:04 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovLAr-005oND-10; Wed, 16 Nov 2022 16:22:07 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1668615717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtCslIGlEzy614T2a8IHyZzYUS3h+qQy0DKVc9BzNdg=;
	b=GzY5cgNDoWBa/lbOwfd9mX/PwG123YTrjFa/2RWy/MxTGTTbo5ThPzbyy9v6dG3zYsF1pZ
	N+iegswchbcXUAHRtbTykseR0L6W+HQIgfgiX9SSYYN5RgrOfoZwE1DQPFiaVifugRbmwD
	AyBCdUHkwK+OSb4pBPykW240H0ST1UqF503Aq8rnG+/8xoyKFITxQ5Wo6+vQYoyof/YpGg
	mwgQRVb20rIizIFIJqJNAksD+xCwoZHyDaiU+3Ezmava1OwpI8+ReSgzmSupdlYX72TX7m
	HSxs3KVDXxdWRzVgOd+h/0zRrlR+P8zbX1vczS2jWcXMvKgDHE79PmhU5YDATQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1668615717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VtCslIGlEzy614T2a8IHyZzYUS3h+qQy0DKVc9BzNdg=;
	b=vFkQ9WmGMftRn2ZYMrgPBYAnAbFOKcqTla1ih+Fi5GvDPVQBXzB/7++jTAHdNGmTFP2e82
	KdXuR59uIU7zsfBw==
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
	Aaron Tomlin <atomlin@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Tom Rix <trix@redhat.com>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH printk v5 00/40] reduce console_lock scope
Date: Wed, 16 Nov 2022 17:27:12 +0106
Message-Id: <20221116162152.193147-1-john.ogness@linutronix.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_082205_391998_AD1C11B2 
X-CRM114-Status: GOOD (  15.56  )
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

This is v5 of a series to prepare for threaded/atomic
printing. v4 is here [0]. This series focuses on reducing the
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
exactly why the console_lock is needed.

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

Changes since v4:

printk:

- Introduce console_init_seq() to handle the now rather complex
  procedure to find an appropriate start sequence number for a
  new console upon registration.

- When registering a non-boot console and boot consoles are
  registered, try to flush all the consoles to get the next @seq
  value before falling back to use the @seq of the enabled boot
  console that is furthest behind.

- For console_force_preferred_locked(), make the console the
  head of the console list.

John Ogness

[0] https://lore.kernel.org/lkml/20221114162932.141883-1-john.ogness@linutronix.de
[1] https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=srcunmisafe.2022.11.09a

John Ogness (38):
  printk: Prepare for SRCU console list protection
  printk: register_console: use "registered" for variable names
  printk: move @seq initialization to helper
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
 kernel/printk/printk.c              | 493 +++++++++++++++++++++-------
 22 files changed, 680 insertions(+), 184 deletions(-)


base-commit: f733615e39aa2d6ddeef33b7b2c9aa6a5a2c2785
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
