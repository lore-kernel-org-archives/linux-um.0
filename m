Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3DAC369C2
	for <linux-um@archiver.kernel.org>; Sat,  3 May 2025 17:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KbziGNtfftB9OXRbFz9eW2DLtJiSLq1EL37Tz41iIJg=; b=bM/FpJvMA1uK2dolKUjZIq1L70
	nplrmw8cbrDYmCcKM70norkNFVYxSwgx+qCnkI9Nr4FRUdzi0rPBK8Zl+80m0rsm3afDYZbslOjNR
	XWygVjafusZ9KnqBWZ+Z2ArXNn1xomU+NdjwIu/xJ6/1DeCzApXnRuZV4GdQwXJqKT0RnkatXvbQM
	WSCC0TmfXZi+/9KBm8NRn6gYMXEbiGM1JgxXiyqodhvQXDMCkrWGX3J/ZGRO14zWJtrrNHlDe2Glx
	obg7Q9StyAlw/HLmeNUe/k1zMr0ogQ3ibcEJQUbSLZv+lKnO03feQ2Tq69lAlwpM38aOld2z6/6rt
	IQYAxTQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGcm-00000004J4c-3ehu;
	Sat, 03 May 2025 17:26:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBGck-00000004J4B-29Ku
	for linux-um@lists.infradead.org;
	Sat, 03 May 2025 17:26:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3BFD04A050;
	Sat,  3 May 2025 17:25:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E39C4CEE3;
	Sat,  3 May 2025 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746293159;
	bh=1aNojnjh6f9aU4lE8/vPeP3Xp57U1BRGOjwQrSWxDeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdNJhVm6jdIKAVlpABA8UMGIS8+VUrbTFo5CUu7dgwPhmWSYSYKfXJKKXj4K1S2g7
	 Uqs08o5DPnzAMA6R1xzjtUyDfs1gcOUs3kv6HcIjJAdxMxc8dcCY0hw29/r1F5V7mG
	 rDbTnKkslrFMEGYI8UeS5XgghGCc6pBWGbU5fmuz0Z1XUXDlxKLX6UqEC3p69eDtGg
	 QW7dcHB1Rs6aCsi9DHe8nImjWWi0OjTYSzTLxXRyERcHCshNiCU/b/zFaFQQ6hHXrt
	 5xgtnE6RDWzSaroCCZIUkb0w+na1w4fZhxnVxN1n5cnlTx/cwi1qLQuG/5t14gupN5
	 tGHSIclpEysNw==
Date: Sat, 3 May 2025 10:25:57 -0700
From: Kees Cook <kees@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v2 1/3] gcc-plugins: Force full rebuild when plugins
 change
Message-ID: <202505031023.BC44DC842@keescook>
References: <20250502224512.it.706-kees@kernel.org>
 <20250502225416.708936-1-kees@kernel.org>
 <CAK7LNATs4uHnNHgESXcUEjpONZra=GvkuHMaDwsx0hbyUGY99w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATs4uHnNHgESXcUEjpONZra=GvkuHMaDwsx0hbyUGY99w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250503_102602_580615_99444803 
X-CRM114-Status: GOOD (  13.67  )
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

On Sat, May 03, 2025 at 03:12:23PM +0900, Masahiro Yamada wrote:
> On Sat, May 3, 2025 at 7:54 AM Kees Cook <kees@kernel.org> wrote:
> > +quiet_cmd_gcc_plugins_updated = UPDATE  $@
> > +      cmd_gcc_plugins_updated = echo '/* $^ */' > $(obj)/gcc-plugins-deps.h
> 
> I think 'touch' should be enough.
> 
> If some plugins are disabled, it is detected by the normal if_changed rule.

I kind of likely having the active plugins show up in there, but yes,
"touch" is enough (it's what I started with originally).

> > +$(obj)/gcc-plugins-deps.h: $(plugin-single) $(plugin-multi) FORCE
> > +       $(call if_changed,gcc_plugins_updated)
> > +
> > +always-y += gcc-plugins-deps.h
> > --
> > 2.34.1
> >
> 
> 
> I think it is simpler to place the header
> in include/generated/.

I couldn't figure out how to do this, but thankfully you did! :)

> I attached my suggestion below:
> [...]
> -quiet_cmd_gcc_plugins_updated = UPDATE  $@
> -      cmd_gcc_plugins_updated = echo '/* $^ */' > $(obj)/gcc-plugins-deps.h
> +quiet_cmd_gcc_plugins_updated = TOUCH   $@
> +      cmd_gcc_plugins_updated = touch $@
> 
> -$(obj)/gcc-plugins-deps.h: $(plugin-single) $(plugin-multi) FORCE
> +$(obj)/../../include/generated/gcc-plugins-deps.h: $(plugin-single)
> $(plugin-multi) FORCE
>         $(call if_changed,gcc_plugins_updated)
> 
> -always-y += gcc-plugins-deps.h
> +always-y += ../../include/generated/gcc-plugins-deps.h

Aaagh, thank you! I didn't even consider trying ".." for targets!

Yes, this is SO much better! I will read your other replies and work on
v3...

-- 
Kees Cook

