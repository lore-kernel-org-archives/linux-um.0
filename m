Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0E0EE49A5
	for <linux-um@archiver.kernel.org>; Sat, 19 Aug 2023 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rvKCSJ92LZ4i5mpJdRNVnm7eNwA6iI7R2uLl6g6FrJk=; b=2iXW9oqmHiljJbxaUhkPd+x9sz
	FE982XDTwl1GknL0C4L3hsET+tAvplECLSN2vGl+/FBjbEUXls4M4X/on+92vi41hq9Iyg2bJjSFY
	rvVM9DTTQH2UdfRdYOgj8vlerNaN76G6EGlapLHDGiVY48JGAwUrxeKKQgTjJwGEdCxv3/ryiBuTo
	8vIc0iMz32rEj93mvChJogcrmQcS/46S2y2gv6UYZ47pfGxtbm7w1yEdyAiSxvxRdbRtKNAegKUxI
	7If06wqZI927a0hE6F56KafZItTXJUKz/qeUWtLmhV/9ZFmCtOLOQiOkYjS8KnqWIQNy+sxwQqFwU
	Bw6lB1vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXTKT-00BBiZ-2I;
	Sat, 19 Aug 2023 21:17:53 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXTKP-00BBiG-30
	for linux-um@lists.infradead.org;
	Sat, 19 Aug 2023 21:17:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6015C63DB7E5;
	Sat, 19 Aug 2023 23:17:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 4g8WFByNW1hB; Sat, 19 Aug 2023 23:17:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id DB93163DB801;
	Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id V-A1eIJKOCYu; Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ABF7E63DB7E5;
	Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
Date: Sat, 19 Aug 2023 23:17:47 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: davidgow <davidgow@google.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, tglx <tglx@linutronix.de>, 
	mingo <mingo@redhat.com>, bp <bp@alien8.de>, 
	dave hansen <dave.hansen@linux.intel.com>, hpa <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, 
	Noah Goldstein <goldstein.w.n@gmail.com>, 
	linux-um <linux-um@lists.infradead.org>, x86 <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-kselftest <linux-kselftest@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1999963356.6490608.1692479867613.JavaMail.zimbra@nod.at>
In-Reply-To: <20230704083022.692368-1-davidgow@google.com>
References: <20230704083022.692368-1-davidgow@google.com>
Subject: Re: [PATCH 1/2] asm-generic: current: Don't include thread-info.h
 if building asm
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: asm-generic: current: Don't include thread-info.h if building asm
Thread-Index: nVjiU4WyfVH2A7QVxS/nlClMU8OkNw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230819_141750_128415_F205F4E7 
X-CRM114-Status: GOOD (  14.12  )
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
b3dAZ29vZ2xlLmNvbT4KPiBhc20vY3VycmVudC5oIGlzIGluY2x1ZGVkIGJ5IHNvbWUgYXNzZW1i
bHkgZmlsZXMgKGVpdGhlciBkaXJlY3RseSwgb3IKPiBpbmRpcmVjdGx5KS4gVGhpcyB3b3JrcyBv
biBzb21lIGFyY2hpdGVjdHVyZXMgKHN1Y2ggYXMgeDg2KSwgYXMgdGhlaXIKPiBpbXBsZW1lbnRh
dGlvbiBvZiBjdXJyZW50LmggaXMgY2FyZWZ1bCB0byBub3QgaW5jbHVkZSBhbnkgQywgYnV0IHRo
ZQo+IGFzbS1nZW5lcmljIHZlcnNpb24gaW5jbHVkZXMgbGludXgvdGhyZWFkLWluZm8uaCB1bmNv
bmRpdGlvbmFsbHksIHdoaWNoCj4gbGVhZHMgdG8gZXJyb3JzIHdoZW4gZWl0aGVyIEMgY29kZSBv
ciBub24tYXNtLWNvbXBhdGlibGUgcHJlcHJvY2Vzc29yCj4gZGlyZWN0aXZlcyBhcmUgaW5jbHVk
ZWQuCj4gCj4gSnVzdCB3cmFwIHRoZSBjb250ZW50cyBiZWhpbmQgYW4gI2lmbmRlZiBfX0FTU0VN
QkxZX18gdG8gYXZvaWQgYW55IEMKPiBjb2RlIG1ha2luZyBpdHMgd2F5IGluLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IERhdmlkIEdvdyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT4KPiAtLS0KPiAKPiBUaGlz
IGlzIHJlcXVyaXJlZCBmb3IgcGF0Y2ggIzIgaGVyZSwgYXMgVU1MIHVzZXMgdGhpcyBhc20tZ2Vu
ZXJpYwo+IGhlYWRlciwgYnV0IHdvcmtzIHdpdGggeDg2IGFzc2VtYmx5IGZpbGVzIHdoaWNoIGFy
ZSBleHBlY3RpbmcgdGhlIHg4Ngo+IGN1cnJlbnQuaCwgd2hpY2ggaXMgYXNzZW1ibHktZnJpZW5k
bHkuCj4gCj4gLS0tCj4gaW5jbHVkZS9hc20tZ2VuZXJpYy9jdXJyZW50LmggfCAyICsrCj4gMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Fz
bS1nZW5lcmljL2N1cnJlbnQuaCBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvY3VycmVudC5oCj4gaW5k
ZXggM2EyZTIyNGI5ZmEwLi45YzJhZWVjYmQwNWEgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9hc20t
Z2VuZXJpYy9jdXJyZW50LmgKPiArKysgYi9pbmNsdWRlL2FzbS1nZW5lcmljL2N1cnJlbnQuaAo+
IEBAIC0yLDkgKzIsMTEgQEAKPiAjaWZuZGVmIF9fQVNNX0dFTkVSSUNfQ1VSUkVOVF9ICj4gI2Rl
ZmluZSBfX0FTTV9HRU5FUklDX0NVUlJFTlRfSAo+IAo+ICsjaWZuZGVmIF9fQVNTRU1CTFlfXwo+
ICNpbmNsdWRlIDxsaW51eC90aHJlYWRfaW5mby5oPgo+IAo+ICNkZWZpbmUgZ2V0X2N1cnJlbnQo
KSAoY3VycmVudF90aHJlYWRfaW5mbygpLT50YXNrKQo+ICNkZWZpbmUgY3VycmVudCBnZXRfY3Vy
cmVudCgpCj4gKyNlbmRpZgo+IAo+ICNlbmRpZiAvKiBfX0FTTV9HRU5FUklDX0NVUlJFTlRfSCAq
LwoKSSdtIGZpbmUgd2l0aCB0aGUgVU1MIHNpZGUgb2YgdGhpcyBjaGFuZ2UgYnV0IHRoZSBnZW5l
cmljIHBhcnQgbmVlZHMgQXJuZCdzIEFDSy4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
