Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79005E6BF32
	for <linux-um@archiver.kernel.org>; Fri, 30 Jan 2026 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o3M3i7fOsBJJ8QZ7iZoiOC82WHRYdzsj5QwfB37tvhM=; b=AyalFQmtIlNQ+X9CDUlbMMFc37
	S2n3jiKprB8si9treTFJNkBZEJmlYRg0bu0weuXvp0H+mxaDC7oSWq/ZkZBzPDlJvgpbWByIRwPSc
	nru1gbm7M2g6GBkBs90qZGzypc8EYEskhzJ2D8S1D4BVxL09m45tUcOLWMjlYckCiplthNgBIiSKL
	gdFWzVuLIbVsgL5Gly90YkAEbFlOdrwxwy5rVxxVkjj05hYstiTeDh40wDZt7JgLmyGOppGDa87sy
	lrPniHMN4TLXFCgLcZxqugzSs4Lt2EGlV6yCM544yTz5mhs8CvRuO3BOqQP2xbKtUQ0fvFnmX5lbT
	RqkAw75A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlsHP-00000001lRG-0Byh;
	Fri, 30 Jan 2026 17:27:35 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlsHL-00000001lQ3-3q2C;
	Fri, 30 Jan 2026 17:27:33 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769794048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3M3i7fOsBJJ8QZ7iZoiOC82WHRYdzsj5QwfB37tvhM=;
	b=4vjFnCIdprQ4bapgrR0W30E28e5XqGnWTzlLJRIchP5KT0mQiU7C2HocIuX1Kdz8pUDo0Y
	qc+5Orpl1l1vZoFNRQKL24RKcgRr4rbqO02DrPCVc+5aUzHom7b8+oniEw+b53sZSdrxJg
	+9kDxpq15AQ1xIFUPYwfQgdiBumRwsh+faRgD4dNJMyLkXr/A+P3jXB+CHRA0Hld9eIR+Y
	7xvqnLxeTCF6EQZwTVn1wPEr2oy9Q/+88+eiC8F7PD8kB/n3dpKOZdgpjEsqUgdQZXqqI6
	yQRXOGphajl9ppYkFrEud4nWZdOCa3/Ob9kGErESIR3cRVjE/LChlCPSJd3YTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769794048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3M3i7fOsBJJ8QZ7iZoiOC82WHRYdzsj5QwfB37tvhM=;
	b=520kqiApVkDPFPboRTL5PTkP4fVPei7/H7ecnPwf1SVFxrBJQEXzDTADXeZGZGuaQ0gr4c
	ZZ61wAzhpOPpFsDw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jiri
 Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume functions
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Date: Fri, 30 Jan 2026 18:33:27 +0106
Message-ID: <87343n3ta8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_092732_098177_F881F456 
X-CRM114-Status: GOOD (  16.24  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 2025-12-27, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/printk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 173c14e08afe..85a8b6521d9e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2734,7 +2734,8 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
>  /**
>   * console_suspend_all - suspend the console subsystem
>   *
> - * This disables printk() while we go into suspend states
> + * This disables printk() while we go into suspend states. Called by the power
> + * management subsystem.

Since you are touching this comment, I would prefer to make it
technically accurate. It is not printk() that is disabled, it is console
printing that is disabled. Perhaps something like:

 * Block all console printing while the system goes into suspend state.
 * Called by the power management subsystem.
   
>   */
>  void console_suspend_all(void)
>  {
> @@ -2766,6 +2767,12 @@ void console_suspend_all(void)
>  	synchronize_srcu(&console_srcu);
>  }
>  
> +/**
> + * console_resume_all - resume the console subsystem
> + *
> + * This resumes printk() when the system is being restored. Called by the power
> + * management subsystem.

And something similar here:

 * Allow all console printing when the system resumes from suspend. Called by
 * the power management system.
 
> + */
>  void console_resume_all(void)
>  {
>  	struct console_flush_type ft;

John Ogness

