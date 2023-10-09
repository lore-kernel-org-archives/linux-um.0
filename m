Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D2FE95A91
	for <linux-um@archiver.kernel.org>; Mon,  9 Oct 2023 13:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aSlOnCZcy2oejZSjjB6bddJ7vChXog1HNFtf/REPb/Q=; b=bI3FkB7+oen6BJ/9qDE9fy3vIT
	afYUKGnzz7aewenmwbQ2gpLV7Pf87f2s0wUWoYpkGoITnIlrt6eh+1VIZNsTjThikYjTSn2yX28hp
	Cgl2tXMVy81JpFKqWD2QNMpEMTEZdqh8YpVN3e7qA2ARXkm1LpNR6e7k65g45s5o2qtlMBtMox2e+
	ybdx2QdvNYK9IpfmSufJ6BbXxWO4Mand0615xGmiUOJvgab9zY7wb8df/MhzTN2qA74gtFv54rDj5
	/bqVmEzr6W0RBFaWWnC/PP8ThRzTo55A/HmAK55KxclQbp/M3qR1addu262l7kpwGygPfe2IiNo3I
	xWHxo+Ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qpq0v-00AlXF-2g;
	Mon, 09 Oct 2023 13:09:37 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qpq0q-00AlTD-30;
	Mon, 09 Oct 2023 13:09:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id ACBC36340DFB;
	Mon,  9 Oct 2023 15:09:20 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fAqWxJUbVZPL; Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 86D316234897;
	Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qGg_8h5ogqvU; Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2312E6340DFB;
	Mon,  9 Oct 2023 15:09:19 +0200 (CEST)
Date: Mon, 9 Oct 2023 15:09:18 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: masahiroy <masahiroy@kernel.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	linux-csky@vger.kernel.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-um <linux-um@lists.infradead.org>, 
	loongarch <loongarch@lists.linux.dev>, 
	sparclinux <sparclinux@vger.kernel.org>, x86 <x86@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, bp <bp@alien8.de>, 
	dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, 
	mingo <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	tglx <tglx@linutronix.de>
Message-ID: <687416388.7594.1696856958852.JavaMail.zimbra@nod.at>
In-Reply-To: <20231009124210.1064021-2-masahiroy@kernel.org>
References: <20231009124210.1064021-1-masahiroy@kernel.org> <20231009124210.1064021-2-masahiroy@kernel.org>
Subject: Re: [PATCH 2/5] UML: remove unused cmd_vdso_install
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: remove unused cmd_vdso_install
Thread-Index: 3hBejy77kYh6pqow8LgNKN8Tb77OsQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231009_060933_146512_86E47367 
X-CRM114-Status: UNSURE (   5.77  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIm1hc2FoaXJveSIgPG1hc2Fo
aXJveUBrZXJuZWwub3JnPgo+IEFuOiAibGludXgta2J1aWxkIiA8bGludXgta2J1aWxkQHZnZXIu
a2VybmVsLm9yZz4KPiBDQzogImxpbnV4LWtlcm5lbCIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+LCAibGludXgtYXJtLWtlcm5lbCIgPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZz4sCj4gbGludXgtY3NreUB2Z2VyLmtlcm5lbC5vcmcsICJsaW51eC1wYXJpc2MiIDxs
aW51eC1wYXJpc2NAdmdlci5rZXJuZWwub3JnPiwgbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFk
Lm9yZywKPiBsaW51eC1zMzkwQHZnZXIua2VybmVsLm9yZywgImxpbnV4LXVtIiA8bGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZz4sICJsb29uZ2FyY2giIDxsb29uZ2FyY2hAbGlzdHMubGludXgu
ZGV2PiwKPiAic3BhcmNsaW51eCIgPHNwYXJjbGludXhAdmdlci5rZXJuZWwub3JnPiwgIng4NiIg
PHg4NkBrZXJuZWwub3JnPiwgIm1hc2FoaXJveSIgPG1hc2FoaXJveUBrZXJuZWwub3JnPiwgImFu
dG9uIGl2YW5vdiIKPiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4sICJicCIgPGJw
QGFsaWVuOC5kZT4sICJkYXZlIGhhbnNlbiIgPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4s
ICJocGEiCj4gPGhwYUB6eXRvci5jb20+LCAibWluZ28iIDxtaW5nb0ByZWRoYXQuY29tPiwgIkpv
aGFubmVzIEJlcmciIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiwgInJpY2hhcmQiIDxyaWNo
YXJkQG5vZC5hdD4sCj4gInRnbHgiIDx0Z2x4QGxpbnV0cm9uaXguZGU+Cj4gR2VzZW5kZXQ6IE1v
bnRhZywgOS4gT2t0b2JlciAyMDIzIDE0OjQyOjA3Cj4gQmV0cmVmZjogW1BBVENIIDIvNV0gVU1M
OiByZW1vdmUgdW51c2VkIGNtZF92ZHNvX2luc3RhbGwKCj4gWW91IGNhbm5vdCBydW4gdGhpcyBj
b2RlIGJlY2F1c2UgYXJjaC91bS9NYWtlZmlsZSBkb2VzIG5vdCBkZWZpbmUgdGhlCj4gdmRzb19p
bnN0YWxsIHRhcmdldC4KPiAKPiBJdCBhcHBlYXJzIHRoYXQgdGhpcyBjb2RlIHdhcyBibGluZGx5
IGNvcGllZCBmcm9tIGFub3RoZXIgYXJjaGl0ZWN0dXJlLgo+IAo+IFJlbW92ZSB0aGUgZGVhZCBj
b2RlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFkYSA8bWFzYWhpcm95QGtlcm5l
bC5vcmc+CgpBY2tlZC1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KClRo
YW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
