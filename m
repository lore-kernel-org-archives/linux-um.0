Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6426CEB64D9
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 09:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QDQzU7YEeqSNaY7me3hyiLcvvCX9dzyWqnJwVioIOXA=; b=pcIbRhxVEiGhaK
	fv+f+sDSGB3Ks9qWyB2WtyImYAtXS/m0PrxI9xNOBA6Us/s9QHEoYzzgCg83dexzidQR/6lt8jHZP
	kT5Al+C+7UxJQsX0RZhz1ybRCWJrQBB8/4YSUujxr33vs2ftpXoAkNb5s/hkffWBWA1ZiyuToaYgU
	XUYMuRH6L2m/bSyJKTMziB/4/cNp4NqIidp/d0RHpwHXvblDUXNgi3vQQ628yR8XpKpKVb6iXzrNL
	96hJdzNDCwMRMTWLJe+3V1FrR4c6cVY434NnQh+0dBXj1U4i05XOBc7xLb55iWtSgINpaGwpJ+0Al
	t9tQ+eUziqVlQNLjQyLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9MiN-00B2pe-1c;
	Wed, 14 Jun 2023 09:22:55 +0000
Received: from mail-yw1-f169.google.com ([209.85.128.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9MiK-00B2nz-1Q;
	Wed, 14 Jun 2023 09:22:53 +0000
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-56ffd7d7fedso5239877b3.2;
        Wed, 14 Jun 2023 02:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734568; x=1689326568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0yjIX0KRuOC7G0fcJ6d1AuThz30GREhJw6MsawVV4o=;
        b=ZTXc4gk/c/8sS5NoltkKL8fQy5eJp9/cP63Cpfxe8jW8hWe6uHnqfk35nKbMEVBpKW
         00092qi4grYWEGorf6AlHRKD6/hTz+kt/2q2xxwgX1MIsslAvfDZWWn0xeVqMK2Z6JnD
         YpgWt6YbGBnnRdbSY/Jaf+zWGKnJdZOEACg9ScZNB1i7RQjJL1dOCdrcMZDdTx+GQOZb
         Ih/ZlKgOrjrv27FUvn0R/k9XqVxjnk+IDuEacz8FvqEnTDeLYxWGHtfmlas6NrGn9Yjn
         2VHFGZdgFfy2bjTzPJiwOOS42FJ31p2ZtTBuqt82DsVgzcdgEYsLOGZ0RJ/33j6ZCcpt
         djCQ==
X-Gm-Message-State: AC+VfDzXral0DncdkYJEjiaHdR2VfLPlvrSvoEKyl/fPKrYo7koZduXu
	JTQDwPmmjbgZQvDmQOxOBiU2k/moJCmmdw==
X-Google-Smtp-Source: ACHHUZ5p+yMdG8nKvw5NosImwPx5dNc8GhSEGxltKWwG25ycju3js6i4xEg3xVayhqq/MbiLFUQDcA==
X-Received: by 2002:a81:9251:0:b0:56f:ff88:2e43 with SMTP id j78-20020a819251000000b0056fff882e43mr1244251ywg.27.1686734567937;
        Wed, 14 Jun 2023 02:22:47 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id o128-20020a817386000000b0055aaccfa2c7sm1093929ywc.91.2023.06.14.02.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 02:22:46 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-bcde2b13fe2so414449276.3;
        Wed, 14 Jun 2023 02:22:46 -0700 (PDT)
X-Received: by 2002:a25:3249:0:b0:ba8:199b:9ec2 with SMTP id
 y70-20020a253249000000b00ba8199b9ec2mr1412111yby.31.1686734566067; Wed, 14
 Jun 2023 02:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230613223827.532680283@linutronix.de> <20230613224545.254342916@linutronix.de>
In-Reply-To: <20230613224545.254342916@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Jun 2023 11:22:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbBs5dE_Yi+gX8MNCqduP87S+w+T4B_JjVynbDyE=Waw@mail.gmail.com>
Message-ID: <CAMuHMdUbBs5dE_Yi+gX8MNCqduP87S+w+T4B_JjVynbDyE=Waw@mail.gmail.com>
Subject: Re: [patch 06/17] m68k/cpu: Switch to arch_cpu_finalize_init()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Nikolay Borisov <nik.borisov@suse.com>, 
	"Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>, 
	Tom Lendacky <thomas.lendacky@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_022252_482957_6671C8B7 
X-CRM114-Status: GOOD (  15.25  )
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

T24gV2VkLCBKdW4gMTQsIDIwMjMgYXQgMTozOeKAr0FNIFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPiB3cm90ZToKPiBjaGVja19idWdzKCkgaXMgYWJvdXQgdG8gYmUgcGhhc2Vk
IG91dC4gU3dpdGNoIG92ZXIgdG8gdGhlIG5ldwo+IGFyY2hfY3B1X2ZpbmFsaXplX2luaXQoKSBp
bXBsZW1lbnRhdGlvbi4KPgo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLgo+Cj4gU2lnbmVkLW9mZi1i
eTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+CgpBY2tlZC1ieTogR2VlcnQg
VXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4KCkdye29ldGplLGVldGluZ31zLAoK
ICAgICAgICAgICAgICAgICAgICAgICAgR2VlcnQKCi0tIApHZWVydCBVeXR0ZXJob2V2ZW4gLS0g
VGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02OGsub3Jn
CgpJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBlb3BsZSwgSSBjYWxs
IG15c2VsZiBhIGhhY2tlci4gQnV0CndoZW4gSSdtIHRhbGtpbmcgdG8gam91cm5hbGlzdHMgSSBq
dXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhhdC4KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=
