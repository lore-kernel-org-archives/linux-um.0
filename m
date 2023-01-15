Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE9AC3DA78
	for <linux-um@archiver.kernel.org>; Sun, 15 Jan 2023 10:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:References:
	In-Reply-To:Subject:CC:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/Ldj13qgUYjtjn/UM92CAABtS/9iUgtQ38j+ClPoS+Y=; b=rPNpMHv8j8uLTY
	b/MCNfSrxcWrMQnpA02zlHBXgrK1YSMWYm1o1pf4l7Etgqkm/7CRl5oEyQwZ1Swtbx2EadxT0NuaV
	wOqTDdg/8eKGkJV6nc4yao1Q8KWPd3VW3EDRVSPFA5OCHbEFAWnzR/Xj5ZNe4pTFWe5VAmE7WMSWr
	g73wbWFizh4JJsc5vbZEI11uXmDqRdD1AcE988G+uo60/Hu2MvsDfRvNiFIKfOAuVECuiXAn748vh
	VN7GW6ed/FdFk4g2GZsHLUrroletqRGUjkA97yF7/h0dEQeNYEPa8vwCKjvUsE7/3t87ZGldkG6oD
	mHs1333Y5Oe1V5JoQ6xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH0I7-007By8-Ii; Sun, 15 Jan 2023 10:31:07 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pH0I4-007BxX-Ig
	for linux-um@lists.infradead.org; Sun, 15 Jan 2023 10:31:05 +0000
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www17.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <thomas@m3y3r.de>)
	id 1pH0HM-0006mM-Hc; Sun, 15 Jan 2023 11:30:20 +0100
Received: from [77.185.92.28] (helo=[127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <thomas@m3y3r.de>)
	id 1pH0HL-000JFs-5T; Sun, 15 Jan 2023 11:30:19 +0100
Date: Sun, 15 Jan 2023 11:30:17 +0100
From: Thomas Meyer <thomas@m3y3r.de>
To: linux-um@lists.infradead.org, David Gow <davidgow@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 =?ISO-8859-1?Q?Bj=F6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>
CC: rust-for-linux@vger.kernel.org, llvm@lists.linux.dev,
 linux-doc@vger.kernel.org, kunit-dev@googlegroups.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>,
 Gary Guo <gary@garyguo.net>, Brendan Higgins <brendan.higgins@linux.dev>,
 Daniel Latypov <dlatypov@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] rust: arch/um: Use 'pie' relocation mode under UML
User-Agent: K-9 Mail for Android
In-Reply-To: <20221217044436.4138642-2-davidgow@google.com>
References: <20221217044436.4138642-1-davidgow@google.com> <20221217044436.4138642-2-davidgow@google.com>
Message-ID: <387962BE-A8FA-4D35-9905-30D3685E38AC@m3y3r.de>
MIME-Version: 1.0
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.103.7/26782/Sun Jan 15 09:20:34 2023)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_023104_641495_6C5248A1 
X-CRM114-Status: UNSURE (   7.58  )
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

SGksCgoKQW0gMTcuIERlemVtYmVyIDIwMjIgMDU6NDQ6MzQgTUVaIHNjaHJpZWIgRGF2aWQgR293
IDxkYXZpZGdvd0Bnb29nbGUuY29tPjoKPlVNTCBleHBlY3RzIGEgcG9zaXRpb24gaW5kZXBlbmRl
bnQgZXhlY3V0YWJsZSBmb3Igc29tZSByZWFzb24sIAoKSSB0aGluayBJIGRpZCBhZGQgdGhpcyB0
byBtYWtlIFVNTCBidWlsZCBvbiBEZWJpYW4uLi4KCj4gc28gdGVsbAo+cnVzdGMgdG8gZ2VuZXJh
dGUgcGllIG9iamVjdHMuIE90aGVyd2lzZSB3ZSBnZXQgYSBidW5jaCBvZiByZWxvY2F0aW9ucwo+
d2UgY2FuJ3QgZGVhbCB3aXRoIGluIGxpYmNvcmUuCj4KPlNpZ25lZC1vZmYtYnk6IERhdmlkIEdv
dyA8ZGF2aWRnb3dAZ29vZ2xlLmNvbT4KPi0tLQo+IGFyY2gvdW0vTWFrZWZpbGUgfCAyICsrCj4g
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+Cj5kaWZmIC0tZ2l0IGEvYXJjaC91bS9N
YWtlZmlsZSBiL2FyY2gvdW0vTWFrZWZpbGUKPmluZGV4IGYxZDRkNjcxNTdiZS4uYWUzMjEyODJk
YzZmIDEwMDY0NAo+LS0tIGEvYXJjaC91bS9NYWtlZmlsZQo+KysrIGIvYXJjaC91bS9NYWtlZmls
ZQo+QEAgLTY4LDYgKzY4LDggQEAgS0JVSUxEX0NGTEFHUyArPSAkKENGTEFHUykgJChDRkxBR1Mt
eSkgLURfX2FyY2hfdW1fXyBcCj4gCS1EaW42YWRkcl9sb29wYmFjaz1rZXJuZWxfaW42YWRkcl9s
b29wYmFjayBcCj4gCS1EaW42YWRkcl9hbnk9a2VybmVsX2luNmFkZHJfYW55IC1Ec3RycmNocj1r
ZXJuZWxfc3RycmNocgo+IAo+K0tCVUlMRF9SVVNURkxBR1MgKz0gLUNyZWxvY2F0aW9uLW1vZGVs
PXBpZQo+Kwo+IEtCVUlMRF9BRkxBR1MgKz0gJChBUkNIX0lOQ0xVREUpCj4gCj4gVVNFUl9DRkxB
R1MgPSAkKHBhdHN1YnN0ICQoS0VSTkVMX0RFRklORVMpLCwkKHBhdHN1YnN0IC1JJSwsJChLQlVJ
TERfQ0ZMQUdTKSkpIFwKCi0tIApEaWVzZSBOYWNocmljaHQgd3VyZGUgdm9uIG1laW5lbSBBbmRy
b2lkLUdlcsOkdCBtaXQgSy05IE1haWwgZ2VzZW5kZXQuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==
