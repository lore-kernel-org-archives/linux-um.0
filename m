Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ACEC001DE
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 05:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HyeUx8hrC6DL89E3mv0EL1aLkeLcMf1wL0OFoFrqFwg=; b=bWnLqKocwV6raL2kpL7DLpDJJP
	xAu1lKSpyaHCAeo4+z1LaoP2HQQKUyXR0PQKmMSY/VDdA7XmgXnbV08D6u11xMir5xaBOTT17+i7E
	S4QgXrIJlpG15VRD5pEnOTJm7lXtj/ySsIhbgBgd1Ma6prA+GSVh9kBLVffsz/CYy1zKIW9wDmRxb
	TbCeG9SKQ4699MWmyjT5sC1HwlrBD2xKMreDxWmw9/l3Hab0IacJse0pLpPdMJW7SMtq1kxCFBf1T
	3oMfkNg1tsUcOD3BH5RzTbbifb88bEo8skHcd7P2w96Qh/0+EiUuGqLJoh36xy1l8Tsh/b1drfU86
	H2pNCsOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLRv-00DyTJ-2H;
	Mon, 31 Jul 2023 05:28:07 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQLRs-00DyRu-1d
	for linux-um@lists.infradead.org;
	Mon, 31 Jul 2023 05:28:06 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 83FD563577C9;
	Mon, 31 Jul 2023 07:27:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id G9JFjYMLxIRN; Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 550AC63577D4;
	Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nipuTvMz7oy1; Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2B97763577C9;
	Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
Date: Mon, 31 Jul 2023 07:27:54 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: masahiroy <masahiroy@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, tj <tj@kernel.org>, 
	Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, 
	Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, 
	linux-kbuild <linux-kbuild@vger.kernel.org>, 
	alsa-devel <alsa-devel@alsa-project.org>
Message-ID: <1063472755.889096.1690781274039.JavaMail.zimbra@nod.at>
In-Reply-To: <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
References: <20230728043013.27776-1-rdunlap@infradead.org> <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com> <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: um/drivers: fix hostaudio build errors
Thread-Index: NkqIAPWFcMLKoL0J2Cdhb+WpEEOx+g==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230730_222804_715643_AD716A83 
X-CRM114-Status: UNSURE (   5.08  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIlJhbmR5IER1bmxhcCIgPHJk
dW5sYXBAaW5mcmFkZWFkLm9yZz4KPiBPaCwgZ29vZCBwb2ludCwgYW5kIG9uZSB0aGF0IEkgYWdy
ZWUgd2l0aC4KPiAKPiBJJ2xsIHNlbmQgYSB2NC4KCk9rIQogCj4+IAo+PiBSZXZpZXdlZC1ieTog
TWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4KPiAKPiBUYWthc2hpLCBJIGRv
bid0IGtub3cgd2hvIHdpbGwgbWVyZ2UgdGhlIHBhdGNoLCBidXQgSSB3b3VsZCBleHBlY3QKPiB0
aGF0IG9uZSBvZiB0aGUgVU1MIG1haW50YWluZXJzIHRvIG1lcmdlIGl0Li4uLiBGV0lXLgoKWWVw
LiBJJ2xsIGNhcnJ5IHRoaXMgZml4ICh2NCkgdGhyb3VnaCB0aGUgdW1sIHRyZWUuCgpUaGFua3Ms
Ci8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
