Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F336D4117A
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=; b=wwro6Dc8Fq+Kl0Au6Fcfh7QEpp
	6gNhx321XojxvJp8wRRbNUBNatRG3PaGq7fAjOsf0xB6DAaayGfeHynZjN3NKnVB0Mu8t0yQVSpuz
	7Bavu9OaorTIW3g6qk6F1tUi18ANVfTxJkUw4Kl4WH4x64A1ZAP6OsHXghBE9tLUv2081H9dkLN5k
	E2s6IvjfvTUr9HTa26eXwbLub5udKnuae/E0ghGLyGugTjlX6o4GxXhRrJDfpI9KgxRAFgMnMTXkE
	PWPMkNBZ7Fm8OyVFZyTG+zKNvHh4DQs6E6t/Tsx5jPPq9LfdOTuyyk+A2iuenJSfqxf6r+2BwrjKd
	EhKgUAQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMFS-0000000CJNQ-26IO;
	Thu, 15 Jan 2026 12:14:46 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMFP-0000000CJM6-1YgS
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 12:14:44 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-432d256c2a9so830072f8f.3
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 04:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479281; x=1769084081; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=D7OpQpZCobeJmp7R5mrq/jM7l3nx4NeYuLBH2osT1EgQPO85F+k+2NM0yt3nw6k9c2
         KFoy+fjOVLel7tJRsyzIRv8cVxjkkPXLTtrqFhFMZtF6YgSpjq6SkVDqqPdmSVAf9GFB
         cRCSjEvEQtie/FVGSNTyjnGmsjNRDukWnFY2XYvfqx7+Xm3uT3wYbVYg//RdnMoo9QDd
         DhG9ynGHPtHq6ZdwIxCheBsVTMonJekfbsd9s9aN7CpqMWVvEU0Wl/OWUrZ7FYM/hQMe
         mAqxiaEXx6kM6U2eektVy+jovqzgDqG2Vs5j6VVXyusDlzlsej2TfIG86OtdPDqvo1rE
         BL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479281; x=1769084081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zx4s5ogULMWiwAg3H50k8gmoVyZOh2DwfMGC+/dY5Co=;
        b=v3wErkwaBJ5X5qngQKuRC7Wu4nSzoVVQ5f+2Y7iIkNFVgfWFD4HEgepqD2Lj1+xc0k
         eC7sKxoG7M0HGE98XMK2Hq9astL/sVNv/wsBL9a7sp4MvjZyE3EJ4263mAo7eW5OdAU2
         l9TjkLyF4MBnLv3NzdL5h8dq6m+d/q7ZK9hLPBSsOZubLFwa70767DT+JrzR+Ws+8/Ja
         J8HOuPE2oW4VJVBh3hcK0V6gTTPcNzwamD7904HgZjrm6qwwOlxJ5zyN8y5yniXG8Nm2
         fibA3z7YjsAivKCaZ254DBDW9u9lcI0zsEvuKj0p2c999H2wb+UYaDbT6Oe2sbnEz65X
         /qfA==
X-Forwarded-Encrypted: i=1; AJvYcCXH4bejap6QOBFGZvsvz+Cbh2hBoI0N8Li1LRX7pSOpmAPsn1uTw+2H6ORgIuq0Mkik/4XDG5lHQA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyx1m5yZrn3iLfEv1qNGkkOIHf8RbkZEAXWZc4m3dJlS8AsTKyC
	VFZegVm4NEhwyDlVgQSWVL5kocEpJIgO+v5JD22LtEHCSN4KI4hnDebC6cp+YqHkCIQ=
X-Gm-Gg: AY/fxX7eiSg8wYg92djP2Bvq0uE1x3NC9+nwMUQXNKMvk8RPNlECSdZ9vvKfN4df/uy
	ukXUuV3OwB2Rrd07bJOq+56KS8cImdYw3TOm2ISGgLUt/O+EA3XN0aXf/fd46acS0BCHMS+KZYv
	VYOhS6abCG/vGLm6V5vG0FpNi+9OtXHtbSKV3tXjtdX/KaReqiQC0id/vv6IVuoAvMdOUzmIFLc
	SSaoke15rMPaNCWujey7UGYiq9SsDVtP9cVhNwuGPiurkfTVop3k/YtS5tf++mCpGP8nY5kvqco
	NvQWOufuLWxx+OfQukLi3+6taDp4mMxWQJdQVQ/mDvkuYokdpGdvGFg9d3/HNOMSZZ+eeTssaxE
	uV9qqaiy9vxfeHH4ZXZqlC6DJzn7ueUL4g8hCI9H7t05oYj0cUROEde/xTj6Dg+8djy2p0hNEdd
	40jr3GwXlUAejlGQ==
X-Received: by 2002:a05:6000:3101:b0:431:abb:942f with SMTP id ffacd0b85a97d-4342c557b93mr7715812f8f.54.1768479281353;
        Thu, 15 Jan 2026 04:14:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a778sm5591185f8f.3.2026.01.15.04.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:14:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:14:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/19] sparc: kernel: btext: Migrate to
 register_console_force helper
Message-ID: <aWjaLhzRoTLalIrM@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-12-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_041443_425493_543F8D21 
X-CRM114-Status: UNSURE (   8.37  )
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

On Sat 2025-12-27 09:16:19, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

