Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BB8EB64D8
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 06:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2pC8DFn/z6MUK5+1VpEm3EivZvcfGkRgTds953D4FOM=; b=DwWWp+0jvtWJfNJxPZURIiiUr2
	mqxh6LgsXMFiTIFaoLq1LoguyZysWTwI/vGhVG2i1QnrG74BTN3WCPQLMwTyNic7u3+4ULJeYjc8K
	5dpVAuf1w+qCAuleE9RVN6xIBFqeEGEBbmed5Xbn+QBBiKlEI0s5XC/ONbiwQ1LK+XMT+iVokC9Qn
	BHXpSKhbX8wDwD5a/9bljdvyxoQZASp0nrn+42ZYR2brLg44yTN7Bqzi5BS4YhqiQtyuWl1ii/Q0J
	406JDQGkwXMHL1zxBKBjykstFLRmGgAryGGXEwYbb9Db4N9BTo/s/eWqPa4aNbH6ailvDxUGPQhkV
	cSBcE1NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9KMR-00AWpu-2K;
	Wed, 14 Jun 2023 06:52:07 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9KMM-00AWgC-1m;
	Wed, 14 Jun 2023 06:52:05 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id F1F3E63CC111;
	Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NhsAn0pqGJjc; Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 756B4608F44F;
	Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tYnTmxn9hAwM; Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3D44C63CC111;
	Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
Date: Wed, 14 Jun 2023 08:51:50 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: tglx <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>, 
	torvalds <torvalds@linux-foundation.org>, 
	Nikolay Borisov <nik.borisov@suse.com>, 
	"Ahmed S. Darwish" <darwi@linutronix.de>, 
	Arnd Bergmann <arnd@arndb.de>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-m68k <linux-m68k@lists.linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-mips <linux-mips@vger.kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-sh@vger.kernel.org, davem <davem@davemloft.net>, 
	sparclinux <sparclinux@vger.kernel.org>, 
	Richard Henderson <richard.henderson@linaro.org>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Chris Zankel <chris@zankel.net>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <308775127.5298661.1686725510008.JavaMail.zimbra@nod.at>
In-Reply-To: <20230613224545.493148694@linutronix.de>
References: <20230613223827.532680283@linutronix.de> <20230613224545.493148694@linutronix.de>
Subject: Re: [patch 10/17] um/cpu: Switch to arch_cpu_finalize_init()
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/cpu: Switch to arch_cpu_finalize_init()
Thread-Index: iSTlBjUa5Wmo5DQJGeG0TUMeIHydTg==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_235202_756365_F5CAA832 
X-CRM114-Status: UNSURE (   5.50  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogInRnbHgiIDx0Z2x4QGxpbnV0
cm9uaXguZGU+Cj4gY2hlY2tfYnVncygpIGlzIGFib3V0IHRvIGJlIHBoYXNlZCBvdXQuIFN3aXRj
aCBvdmVyIHRvIHRoZSBuZXcKPiBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KCkgaW1wbGVtZW50YXRp
b24uCj4gCj4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpDb25maXJtZWQuIDotKQogCj4gU2lnbmVk
LW9mZi1ieTogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4gQ2M6IFJpY2hh
cmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+Cj4gQ2M6IEFudG9uIEl2YW5vdiA8YW50b24u
aXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNA
c2lwc29sdXRpb25zLm5ldD4KPiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwoKQWNr
ZWQtYnk6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CgpUaGFua3MsCi8vcmlj
aGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
