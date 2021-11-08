Return-Path: <bp@alien8.de>
Date: Mon, 8 Nov 2021 15:35:50 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v0 00/42] notifiers: Return an error when callback is
 already registered
Message-ID: <YYk1xi3eJdMJdjHC@zn.tnic>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101924.15759-1-bp@alien8.de>
 <20211108141703.GB1666297@rowland.harvard.edu>
 <YYkzJ3+faVga2Tl3@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYkzJ3+faVga2Tl3@zn.tnic>
To: Alan Stern <stern@rowland.harvard.edu>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ayush Sawal <ayush.sawal@chelsio.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rohit Maheshwari <rohitm@chelsio.com>, Steven Rostedt <rostedt@goodmis.org>, Vinay Kumar Yadav <vinay.yadav@chelsio.com>, alsa-devel@alsa-project.org, bcm-kernel-feedback-list@broadcom.com, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-iio@vger.kernel.org, linux-leds@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-remoteproc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org, linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-xtensa@linux-xtensa.org, netdev@vger.kernel.org, openipmi-developer@lists.sourceforge.net, rcu@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org
List-ID: <linux-um.lists.infradead.org>

On Mon, Nov 08, 2021 at 03:24:39PM +0100, Borislav Petkov wrote:
> I guess I can add another indirection to notifier_chain_register() and
> avoid touching all the call sites.

IOW, something like this below.

This way I won't have to touch all the callsites and the registration
routines would still return a proper value instead of returning 0
unconditionally.

---
diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc0bc0f..04f08b2ef17f 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -19,14 +19,12 @@ BLOCKING_NOTIFIER_HEAD(reboot_notifier_list);
  *	are layered on top of these, with appropriate locking added.
  */
 
-static int notifier_chain_register(struct notifier_block **nl,
-		struct notifier_block *n)
+static int __notifier_chain_register(struct notifier_block **nl,
+				     struct notifier_block *n)
 {
 	while ((*nl) != NULL) {
-		if (unlikely((*nl) == n)) {
-			WARN(1, "double register detected");
-			return 0;
-		}
+		if (unlikely((*nl) == n))
+			return -EEXIST;
 		if (n->priority > (*nl)->priority)
 			break;
 		nl = &((*nl)->next);
@@ -36,6 +34,18 @@ static int notifier_chain_register(struct notifier_block **nl,
 	return 0;
 }
 
+static int notifier_chain_register(struct notifier_block **nl,
+				   struct notifier_block *n)
+{
+	int ret = __notifier_chain_register(nl, n);
+
+	if (ret == -EEXIST)
+		WARN(1, "double register of notifier callback %ps detected",
+			n->notifier_call);
+
+	return ret;
+}
+
 static int notifier_chain_unregister(struct notifier_block **nl,
 		struct notifier_block *n)
 {


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

