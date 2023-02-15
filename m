Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9634FC636D4
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 08:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Gl2Tub2U6sRiztee9+uPZaIdxUmS8+6y5/KC4vBi+f8=; b=cM2TcTKdHujABd
	ENDyjqE/V8M3xN4Lb4YaWiNX4KcTG4e462u+fya9WJS7XwXky5v91KO53FHr+dDwwuSrChxcVE7/x
	VGLIfgQZar6AX2zdVSHfOPmD0oXL0KnAQJkUov3IXubS+4xETsrm7UyarpMJYEfsbohLgLc1ZNHv2
	lGLzQCsI3P/fTda6/fCSWk4XNsYa5vlutabwLBjK/C8PMeWHetg8wAAFUjOzkwIC6eCQhTqo/a+Dz
	u4bNZcLBV3vNW+pk2JRSWjWcg+/zFCrMbAF/PS6eTfzriSAlA1vuOcNNJnB4ZMBrFWUGxgMqhQ7Cw
	CcTiB6AT6YnwAVgzuhWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCw9-0059Vl-T3; Wed, 15 Feb 2023 08:14:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCw7-0059Uw-11
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 08:14:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HupHpkbzSPZDhis2vo8RKGLvZx4naguscrasKfve9PQ=;
	t=1676448882; x=1677658482; b=vILCjuC0Af8kny1YOJnNZscPTK+VGqcskDO44/KSWIvJtbx
	ICr5rzIzpcZpG8MFZioBxbfHznxMhTnsYIsDd0Cyx1YK8B8wLvD95rnqgSIqlDiVNkszALXrXyYd5
	D9ZPPdORv5R8lW68BrMbwdB9gsP9Ic+u5fyXHfrDy5Q1l8RfSe3JUqOaj9AZEZQk5zZ3OitBhD/uG
	u7zVeI1uSkjvJWdr5BpJd4v0oS21jxnLK6oiLRzY1izUy80rP0xrzSoAeu17AQFTcfhbd0oUCCFnk
	nZJXn/Lx+1lHUSY3+c2q9US1TbjHNYDoLepYwZLXZEICDvOOcarm/Q64aSQMJz3Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pSCw4-00CyrC-14;
	Wed, 15 Feb 2023 09:14:40 +0100
Message-ID: <d42dc4ea6f1d473ef4c721cbe67907538bb681a6.camel@sipsolutions.net>
Subject: Re: [PATCH V1] um: Fix compilation warnings
From: Johannes Berg <johannes@sipsolutions.net>
To: Richard Weinberger <richard@nod.at>, Srinivasarao Pathipati
	 <quic_c_spathi@quicinc.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, linux-um
 <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Wed, 15 Feb 2023 09:14:39 +0100
In-Reply-To: <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
References: <1676410243-10566-1-git-send-email-quic_c_spathi@quicinc.com>
	 <1950127775.130646.1676411821807.JavaMail.zimbra@nod.at>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_001443_084603_FF5597CA 
X-CRM114-Status: UNSURE (   8.96  )
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

T24gVHVlLCAyMDIzLTAyLTE0IGF0IDIyOjU3ICswMTAwLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3Jv
dGU6Cj4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+ID4gVm9uOiAiU3Jpbml2YXNh
cmFvIFBhdGhpcGF0aSIgPHF1aWNfY19zcGF0aGlAcXVpY2luYy5jb20+Cj4gPiBzdGF0aWMgdm9p
ZCBzaWdfaGFuZGxlcl9jb21tb24oaW50IHNpZywgc3RydWN0IHNpZ2luZm8gKnNpLCBtY29udGV4
dF90ICptYykKPiA+IHsKPiA+IC0Jc3RydWN0IHVtbF9wdF9yZWdzIHI7Cj4gPiArCXN0cnVjdCB1
bWxfcHRfcmVncyAqcjsKPiA+IAlpbnQgc2F2ZV9lcnJubyA9IGVycm5vOwo+ID4gCj4gPiAtCXIu
aXNfdXNlciA9IDA7Cj4gPiArCXIgPSBtYWxsb2Moc2l6ZW9mKHN0cnVjdCB1bWxfcHRfcmVncykp
Owo+IAo+IEkgZmVhciB0aGlzIGlzIG5vdCBjb3JyZWN0IHNpbmNlIG1hbGxvYygpIGlzIG5vdCBh
c3luYy1zaWduYWwgc2FmZS4KCkl0IHdvdWxkIHByb2JhYmx5IGFsc28gYmUgYSBub24tdHJpdmlh
bCBwZXJmb3JtYW5jZSByZWdyZXNzaW9uIGZvcgonaW50ZXJydXB0JyBoYW5kbGluZy4KCldlIF9j
b3VsZF8gdXNlIGEgc3RhdGljIGlmIHRoaXMgcmVhbGx5IHdhcyBhIHByb2JsZW0sIGJ1dCB0aGF0
J2QgYmUganVzdApvbmUgbW9yZSB0aGluZyB0byB1bmRvIGZvciBTTVAsIGFuZCBzZWUgbXkgb3Ro
ZXIgbWFpbCwgaXQncyByZWFsbHkgbm90Cm5lZWRlZCB0byB3b3JyeSBhYm91dCBodGlzLgoKam9o
YW5uZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
