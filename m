Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3112C7618D
	for <linux-um@archiver.kernel.org>; Tue,  4 Apr 2023 08:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=4lGqBmqSlU8XgY/KZf9ncyP8T/CWBDefekEiKzR9xwk=; b=sDlpBM45TkZ2jXppE0Nt1rTDSP
	SAAN1uUAOeVQLpns6a2PQnZQhQdnmkvFd9NjWfMAM22dqiQNGwQCLRwaQ+4AjHhH2VERTRlp4SMvw
	ExWFirq3SBES87AhxazZhgi+yyAspbiibzilMlQYi7B5XM3OaLLiwKRmeUSzn+Hyb/C6bEvomVyRT
	58R6R8UskqMNppB2TvoGfdryO0Y93FaKnW6dBA2LBqDwO1cBpYbLspjmIYrsjsHBd4M9nJHC8/i+f
	GqbBORt1snJXzdkVI56L7rKh1ZsmTFY8eMOp4UKHV69kJ084/YZzWO6V+8ekoA/Chc9aef4TPJSCB
	xhSo44xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pjbav-000Nub-2e;
	Tue, 04 Apr 2023 08:00:45 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pjbZc-000NiD-0k
	for linux-um@lists.infradead.org;
	Tue, 04 Apr 2023 07:59:30 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 237E364551A4;
	Tue,  4 Apr 2023 09:59:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id Hz8yMQEoa-uq; Tue,  4 Apr 2023 09:59:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id AAA4164551A5;
	Tue,  4 Apr 2023 09:59:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F9UrfvwtSDma; Tue,  4 Apr 2023 09:59:15 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7D4B564551A4;
	Tue,  4 Apr 2023 09:59:15 +0200 (CEST)
Date: Tue, 4 Apr 2023 09:59:15 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: davidgow <davidgow@google.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>, 
	llvm <llvm@lists.linux.dev>, 
	Rust for Linux Kernel <rust-for-linux@vger.kernel.org>, 
	kunit-dev <kunit-dev@googlegroups.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	SeongJae Park <sj@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, mingo <mingo@redhat.com>, 
	tglx <tglx@linutronix.de>, 
	Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <892003004.13106.1680595155348.JavaMail.zimbra@nod.at>
In-Reply-To: <2128345299.463203.1680251851757.JavaMail.zimbra@nod.at>
References: <20230318041555.4192172-1-davidgow@google.com> <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com> <2128345299.463203.1680251851757.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old
 GCC bugs
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch:um: Only disable SSE on clang to work around old GCC bugs
Thread-Index: KRbe3B8OBuNHdw1xcXwa3ZqHhmy+S+VRZu+O
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230404_005924_478432_AE2C3A2E 
X-CRM114-Status: UNSURE (   3.37  )
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

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+PiBWb246ICJkYXZpZGdvdyIgPGRhdmlk
Z293QGdvb2dsZS5jb20+Cj4+IEFuOiAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwgImFudG9u
IGl2YW5vdiIKPj4gPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+LCAiSm9oYW5uZXMg
QmVyZyIKPj4gQW55IGNoYW5jZSB3ZSBjb3VsZCBnZXQgdGhpcyBwaWNrZWQgdXAgYXMgYSBmaXgg
Zm9yIDYuMz8gVGhlIFVNTCBidWlsZAo+PiBpcyBzdGlsbCBicm9rZW4gd2l0aCBvbGRlciBnY2Mg
dmVyc2lvbnMuCj4gCj4gU3VyZS4gSnVzdCBnb3QgZmxvb2RlZCB3aXRoIG90aGVyIHN0dWZmLiA6
LVMKClBhdGNoIGFwcGxpZWQgdG8gZml4ZXMgYnJhbmNoLiBQUiB3aWxsIGhhcHBlbiBzb29uLgoK
VGhhbmtzIGV2ZXJ5b25lIGFuZCBzb3JyeSBmb3IgdGhlIGRlbGF5IG9uIG15IHNpZGUhCgotLQpU
aGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
