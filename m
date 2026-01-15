Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36640D4117C
	for <linux-um@archiver.kernel.org>; Thu, 15 Jan 2026 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=; b=b/z7oceQBcyUE7FvprdfW4w0LB
	7jZ0aecm7FckGHFMhoi2705uTpncvCJiKGSiXb68SrMuznErczNkYxDSfJB20WM7Y3fFiX1Ma6DUF
	dwFqekuye9H65EFD5FMpfdm8pMae1vDx+kCym+5i1Keaz8OlyzzQule6pIFvVBAu90r74wqp0nzoC
	7vwekCs2XXhPA8bqnDAxqHNCYgMn3pkhmMqupusvNq1oGB6dYzKX6/x1Gd8KTxKlYGqLujrYeuG72
	xCqxTOyAnfoCB1DrUvUzcq18+OXn+U8JytG3YesXeUPVSnI6s0q4ZH+w2EZ1M3iLRZCRC2ykfu2x4
	823Sutsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMP9-0000000CKN7-3O6x;
	Thu, 15 Jan 2026 12:24:47 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgMP6-0000000CKKr-3YC1
	for linux-um@lists.infradead.org;
	Thu, 15 Jan 2026 12:24:46 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so442269f8f.1
        for <linux-um@lists.infradead.org>; Thu, 15 Jan 2026 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=Zvqsm4brzFzKhacO4vDWySb+gsvNvag5XpVDQwSb4sz8G83F+68LvglYVqMPwRCIag
         rYvSN9FSsVJq0EY2eW9WqJ3bA06d5UfDpw5uy1qmnQqB/FBskGJYGFbRNLs3sV9EHSdB
         YFKAM4R8A5VPo3vRtrAa8rb9qP6yu+RJFSiW87hrJoCdTc0nbphWtWT0dXgwECGhAfVt
         zlK9hS2ghXiE2yhf/sxPGfX9HdcE7HPwptkOH9WOY2t60oo3R+EB7ztFMfD9xTUkV4bF
         i9H3S/ev0TC0ruF0r5OlKGgNapL7XGQ/553om6EZSHQvmxa4omNiLiZZDJP8mJU1wcAi
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=vbW3Ry2VW30venDE/bDFP+uo+VS6oWRC5QZPsuXYMsM/ScxhFp2Iv5+/ijCD7SbEde
         L4rFIBcX4deuFrtwIbOEbQODVQGtbUfVM2S8LkAwdu1S2nEoHFWG+REsksTJ+qI5ck41
         76CfITxL0sbsoGq9Y6bO8UKBhVCbayKSnVXAw18HKkp4aMFx4Og11rF17Jkhgq4sUwPE
         mse73cfbdap4jN79HA21uI8zGfh4QGk62fV7gr5QVFChdhOBZXgyJ0z9/s1JJiRcFPzQ
         RwylNKREuo/Z/7x1gdTRjg7QELdpUt12l3UDcYMQbbTCvVOcFrm4fQJVDzTGi6yJxUcA
         tziw==
X-Forwarded-Encrypted: i=1; AJvYcCUkgTCIjJ8lhoQSkR1RzHDCfupXmPiprmRzWus7VK7P2Y1kKkmmaYD+yKPaxj/fnwlrC+ks6CSbRQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwSUF/LtHSpwAIRyrhNaXdwc8boxpLWewVHr9XteeSHN3vmTb1H
	LjmPW5MDYYly6mbl9+OVAGviJCStHOxWH0Y3MgY8FAH+7XKMw/8bqzGxBI1kYNOYMqM=
X-Gm-Gg: AY/fxX79AYu7qSH+cH1rtVuxgA2qdIjdyVA4h3u4lSvt45gLkRKQ5/3VFRBDpMdduiF
	ffHRdX6nzrT2XimX6uUWqmp5VPncXBeg938LUOXHPP4j66EO5+frao8ITrgm1YI7TN4db1lgb99
	47mS8yTKLf6guowgweybiAvdwT27m9MFpw8oSg9qmG9IAsdkxKxMQYRY0OXqdlH+TxQpyPxwZIR
	H18Zz/+AzY4MGkKhSWRbmNH1FFzolCIbXHpuBJPwXuhrqb//E/trDRIxlNvno+jyZei5mfG6jjk
	XW94gq9pOkhY7Lvc0iZV9e17Q6J7KtDnlucyWWVWYyoowPoUrre3jEMdWcRB7yVC/L+0Uqpk/6o
	g0BeBr5y3EX1jzRiw0IzpfB9CjmwHdMMK6Mz3FW1F7So4ewqWMKfNCFvGY0QhmrNYjrtt9RITb6
	N9P3xT2UlUWcp5KQ==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_042444_897945_00781D80 
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

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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

