Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E8C6FD18
	for <linux-um@archiver.kernel.org>; Fri, 31 Mar 2023 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rU8ivMrCUhOhBV7KcjK4I15sxGeZ+k/DgbFCSHzeJ7M=; b=YzfG8nFrxiBgW5LxhGCT33BPnh
	QLYNdXd5gnmCdrXP1j5X2O/gosYZDdytBqFsp440hwff5UkSvqwFpR9WvoJdnGna3yQwQ4pEtnu0a
	r06pepcPSvSTbWoNJp6/F4OF2OG3X6WWsPBxCVo6sq9IYbP/Y9vOLAkieLhk6kjkjsE1uROE4/E7L
	KnH+6ZnPCT4cVoTTwnLZKx4GbyKO7JvlzbvqbHqD63aN5BdxBpVJGZaWuUhAsHInlY8zK1LUQjB0e
	wMAfbJB5GLpINQvnGQfqv2t+Gi0BvdzXgHl2ozBwcdFLfY598ve09s4wDLUPi1MX6W8h6FSbVLlZ5
	N+Fz7CRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piBLE-006khO-0F;
	Fri, 31 Mar 2023 09:46:40 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piAGY-006SG8-1l
	for linux-um@lists.infradead.org;
	Fri, 31 Mar 2023 08:38:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BB2B061989EA;
	Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JxIpvu6PJe5z; Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 27F0961989E6;
	Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GaVCXV-EezY9; Fri, 31 Mar 2023 10:37:32 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E485264548AA;
	Fri, 31 Mar 2023 10:37:31 +0200 (CEST)
Date: Fri, 31 Mar 2023 10:37:31 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: davidgow <davidgow@google.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>, 
	llvm@lists.linux.dev, 
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>, 
	kunit-dev <kunit-dev@googlegroups.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	SeongJae Park <sj@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, mingo <mingo@redhat.com>, 
	tglx <tglx@linutronix.de>, 
	Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <2128345299.463203.1680251851757.JavaMail.zimbra@nod.at>
In-Reply-To: <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com>
References: <20230318041555.4192172-1-davidgow@google.com> <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old
 GCC bugs
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch:um: Only disable SSE on clang to work around old GCC bugs
Thread-Index: KRbe3B8OBuNHdw1xcXwa3ZqHhmy+Sw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_013746_911893_EC4AA5E7 
X-CRM114-Status: UNSURE (   2.79  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImRhdmlkZ293IiA8ZGF2aWRn
b3dAZ29vZ2xlLmNvbT4KPiBBbjogInJpY2hhcmQiIDxyaWNoYXJkQG5vZC5hdD4sICJhbnRvbiBp
dmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPiwgIkpvaGFubmVzIEJlcmci
Cj4gQW55IGNoYW5jZSB3ZSBjb3VsZCBnZXQgdGhpcyBwaWNrZWQgdXAgYXMgYSBmaXggZm9yIDYu
Mz8gVGhlIFVNTCBidWlsZAo+IGlzIHN0aWxsIGJyb2tlbiB3aXRoIG9sZGVyIGdjYyB2ZXJzaW9u
cy4KClN1cmUuIEp1c3QgZ290IGZsb29kZWQgd2l0aCBvdGhlciBzdHVmZi4gOi1TCgpUaGFua3Ms
Ci8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
