Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACD0D4A5E8
	for <linux-um@archiver.kernel.org>; Fri, 16 Jan 2026 13:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CbAFMWQxaWN4gPfzGHNuSzDAtPQQxKBaf65k7R7yp5g=; b=AiwQtVMVCJeGH1iPEI6L1hS3VI
	6g/NrFs3blFHhiAclqSDv9gxwv7ikK5rFLR0Z4riwr0XOKAjRlQl8BskhYm/GbkOADizHx//tZwT9
	GK05NiNaOGoFEkjKtRhM8QCT0lKJIQK4rPSBu3PI2INa8aCVS/T3oeFlhwJnUFddB9LPGsxL0Xmry
	Zw+AHcLP+M5p8KBA36bYvPo2KYt+EVWxyNjW5gLZqdeZjYpoQKibF6Qr6fOUKHtYOqnMBU0HKIxl+
	Y8H4QDMija2RrqMcbb7+BufLKSiLcvs0ir5fNiNoho4XTAF07nGq33khUqttVVH1voYqTe5ZvZinV
	X9A82/BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgjVd-0000000E8tI-2QlY;
	Fri, 16 Jan 2026 13:05:01 +0000
Received: from mgamail.intel.com ([192.198.163.19])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgjVb-0000000E8qc-1QNI;
	Fri, 16 Jan 2026 13:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568699; x=1800104699;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=CbAFMWQxaWN4gPfzGHNuSzDAtPQQxKBaf65k7R7yp5g=;
  b=TUGY01l8PczQQC4L9vH9wH8JOC1G6FeKfbwOgJIwKu+qkbge6B0uhELw
   5IFhoX40OfYGmigKtz404EIeF8AeDUgn1xRVAk/t54Vl8skhd1hRaViv3
   cnOdxtOzCol7kW8BXGyIAmOzD192i79k9UdJcv6h8ue8Q1OkGEUNZdRXv
   2t8dQFAsy7KHYoHzhHPt7s+TFXTZDaUg2laQKWJsb5z/iASL7CQqEzEMy
   8nAtx3DyXEPrR7DN0NujfN7qzajXjFqKqIf6Bz9T9IqjJG2pgk8SSdu+S
   SZC3sNdhh60AUb9jm3upTI0COp8xc2nVvMDMVCJDdDrSiGU+aXynY3VuM
   w==;
X-CSE-ConnectionGUID: rq/PNJd6TzOvKlXAOAfdAg==
X-CSE-MsgGUID: HuUP3uc8SjKFqr+3JyABFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="68892458"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="68892458"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:04:56 -0800
X-CSE-ConnectionGUID: KQRblK2aQjW0DOA9Jboafg==
X-CSE-MsgGUID: pX6S6faKQwuORaUhAmfo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209733228"
Received: from black.igk.intel.com (HELO black) ([10.91.253.5])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 05:04:48 -0800
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Marcos Paulo de Souza <mpdesouza@suse.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Date: Fri, 16 Jan 2026 14:04:45 +0100
Message-ID: <83zf6daetu.fsf@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260116_050459_392930_CB40C1F1 
X-CRM114-Status: UNSURE (   7.17  )
X-CRM114-Notice: Please train this message.
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

Marcos Paulo de Souza <mpdesouza@suse.com> writes:

> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
>
> No functional changes.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Should I pick this up or will you send this with the rest of the series?

Cheers,
--
Alex

