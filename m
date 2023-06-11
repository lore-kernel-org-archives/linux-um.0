Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D1C77B7A
	for <linux-um@archiver.kernel.org>; Sun, 11 Jun 2023 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o3qkhzAPkWNJ+3oOb0h2MvoNGWgeJutfy7xQYkp2yw0=; b=aPERcMspmdHMxW
	sqIXtMJLYUc7UbeGzSRsLnGCbzy5cnw8sx1vXGYCJLtqbXVGLwXt/txaIs60Sfodg2NaL6MHIoMkd
	U5p4xcdWVK3xR2NSfkXz2FwuEtRAUHrtRZarE87OuxN78sTka9XxrzGg15fZE5DnIjXWoHcgx05mn
	LxNJGHT7mLRTOENl2LCI4UI0MMyoswL0YGrm7NOnfFr94wIvp3RXaTaMCcYSEHuAgnftACXCYPP0q
	5D6LKM6bOGIWfg71lEdHSiZDXSYQJ27cZzC3bnW3Jjmc8u0RscT5+hmCMglbB2WoqfJWAOTWxfghG
	pd0PH8UkpmB+qJUCQS2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8N5J-001ENz-1I;
	Sun, 11 Jun 2023 15:34:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8N5G-001ENJ-0W
	for linux-um@lists.infradead.org;
	Sun, 11 Jun 2023 15:34:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B54B660F35
	for <linux-um@lists.infradead.org>; Sun, 11 Jun 2023 15:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123BC4339B
	for <linux-um@lists.infradead.org>; Sun, 11 Jun 2023 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686497663;
	bh=ULeZJLU/GmS4WRNfZNRP8NWRGEEQQ/Vq8F7kRZzoTqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LqU8c0izwphg14GwQgarPpG5rZvPDbEmZ+lT8aIev8kiD7a1PCWsKhd7j+peBH7is
	 EPx0s5tw0tGb1rGfwumBZxU8GWE0Dkb1LsTfSSiTiAHrH6zyNIuKb86/PBDHjWw9QJ
	 La3+uoM5j2/OCxbiU6Gf4WTCH/qsfLJ3jHHgCsh7omFDtTEtEo0JWVO/ynzIAZ1R7n
	 Z3FMKybudGOWAgfOOZ1NzFJPoTCuVXuvYk3vIVBOfqol9vnxM7jVAY/elYzt+Y8XGz
	 QEIuA+dvQhUMjFIBJpuQN7OURwUUBE7j2hvSUanocFecD/lN4UWr/Bxy6R245fTf/U
	 ZmPxs1rboxsJQ==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-392116b8f31so1353528b6e.2
        for <linux-um@lists.infradead.org>; Sun, 11 Jun 2023 08:34:23 -0700 (PDT)
X-Gm-Message-State: AC+VfDw/aHcW4+PS4DJuvS+VO7iDB50OMyyeRdkBPDzk3DeNTTKtR8rW
	G532PHGaPHR/B4igKqz+tApvrMZLOcc/hgBW04Y=
X-Google-Smtp-Source: ACHHUZ53qqeXZwwksu5kVuEQj8L61X5M9M2wpkBjXB6IrtTiV3Y2mbUh+j/IjJVc3CvPNx7bWb0abmPc986K40goUKg=
X-Received: by 2002:a05:6808:59:b0:38e:eaf:cf16 with SMTP id
 v25-20020a056808005900b0038e0eafcf16mr2020632oic.54.1686497662298; Sun, 11
 Jun 2023 08:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230610091320.1054554-1-masahiroy@kernel.org>
In-Reply-To: <20230610091320.1054554-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 12 Jun 2023 00:33:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARBVqdWgsPOwGJu87AKNVZvnWjL-bBJ3xJ-2w+fpidZZA@mail.gmail.com>
Message-ID: <CAK7LNARBVqdWgsPOwGJu87AKNVZvnWjL-bBJ3xJ-2w+fpidZZA@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] Unify <linux/export.h> and <asm/export.h>,
 remove EXPORT_DATA_SYMBOL(), faster TRIM_UNUSED_KSYMS
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	linux-um@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230611_083426_264142_E3BD706A 
X-CRM114-Status: UNSURE (   9.91  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gU2F0LCBKdW4gMTAsIDIwMjMgYXQgNjoxM+KAr1BNIE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhp
cm95QGtlcm5lbC5vcmc+IHdyb3RlOgo+Cj4KPiBUaGlzIHBhdGNoIHNldCByZWZhY3RvcnMgbW9k
cG9zdCBmaXJzdCB0byBtYWtlIGl0IGVhc2llciB0bwo+IGFkZCBuZXcgY29kZS4KCgoKT25seSB0
aGUgZmlyc3QgcGF0Y2ggd2FzIGFwcGxpZWQuCihodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3Byb2plY3QvbGludXgta2J1aWxkL3BhdGNoLzIwMjMwNjEwMDkxMzIwLjEwNTQ1NTQtMi1tYXNh
aGlyb3lAa2VybmVsLm9yZy8pCgoKSSB3aWxsIHNlbmQgdjkgZm9yIHRoZSByZXN0IGJlY2F1c2UK
dGhlIDBkYXkgYm90IHJlcG9ydGVkIGEgY291cGxlIG9mIGlzc3Vlcy4KCgoKCgoKCgoKLS0gCkJl
c3QgUmVnYXJkcwpNYXNhaGlybyBZYW1hZGEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K
