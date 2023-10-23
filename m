Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA9FCDB474
	for <linux-um@archiver.kernel.org>; Mon, 23 Oct 2023 07:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F88FZ1twWJoPRPt4rnj2O1bn7Rq9pULPcKkGgWd8o9Y=; b=d+MrETOh55YsmW
	nUzMDaIKZNqMtINlPojg/wmKHThRpWr3g5HNDTCsolXT9OXVl9h7N7xjYTRqFcNGV8tJ/vFSura0k
	7h4RYWZN6xLV3BAw7DGCAvCBxdRLNj9B3qyhwoYtLxKesiCoOZll4qp7Um+vZnPQS8qyV0MyiQnZq
	rcpwEXfds9zsAbSD62BHvtPdrPVEghPxUoiE1KEAjqqvRcBSgxSmCHwOK6ekriFeFcZdx4HN469Zy
	GfwEXi84s39emhEfMPKj9qL0+P6QDms/Kfm8RstylD8Ia49UBzjw8XtDKmDOJJmFYldeoRLzY62ow
	/TDdbulC23NMh0FUK8Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qupR9-006ewd-2n;
	Mon, 23 Oct 2023 07:33:19 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qupR7-006evB-00
	for linux-um@lists.infradead.org;
	Mon, 23 Oct 2023 07:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=y2Sefgom75pAT7bOhfXGdVuxbfN9tmcYHupcK2cb/Ic=;
	t=1698046394; x=1699255994; b=tuYlQ5JLUzay+7her0ssNbIgbDh8pOu1H3Mhou8koO0LwxV
	Ag12L/0/0o2uj5ZO6PMcrfcgsITFJXscJtqtb+H6GH7atX1BQWTBwj2v9gQE4164QtCtt6IPsNLNV
	/gjE1tuGV85+RWKB2AND3eWA4tPDqgKq7zKWj6h+f9/2qcuu0O7vV49BPbPjsnROlvuhl+z73ByPj
	MXm5osorcjD7Bh6IliUB37Ex7ltBVVvEu/Wf+xYbg2y7+W7uv3kPyeJrppGBOtH5W1Ll8OSmz5JMN
	V21xqSB1x4LAq3EJlt4BvF/2/wYXMpQooPnV5iYM9i8sjM2dscVAAPN5xnZLsvOA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qupR0-000000009Al-0CE2;
	Mon, 23 Oct 2023 09:33:10 +0200
Message-ID: <4dbed8896c94a347dcb58b3a83792c52fdc1c04a.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: fix time going backwards
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"anton.ivanov@cambridgegreys.com"
	 <anton.ivanov@cambridgegreys.com>, "richard@nod.at" <richard@nod.at>
Cc: "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, kernel <kernel@axis.com>
Date: Mon, 23 Oct 2023 09:33:09 +0200
In-Reply-To: <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
References: <20231020-uml-time-backwards-v1-1-90b776fc6dfd@axis.com>
	 <4a75c40636be267163dc30b5a6a2442089628e57.camel@axis.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_003317_171835_C023E94B 
X-CRM114-Status: GOOD (  15.16  )
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

T24gTW9uLCAyMDIzLTEwLTIzIGF0IDA3OjA4ICswMDAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6Cj4gT24gRnJpLCAyMDIzLTEwLTIwIGF0IDE2OjQ3ICswMjAwLCBWaW5jZW50IFdoaXRjaHVy
Y2ggd3JvdGU6Cj4gPiBJbiBiYXNpYyB0aW1lIHRyYXZlbCBtb2RlLCBJIHNvbWV0aW1lcyBzZWUg
InRpbWUgZ29lcyBiYWNrd2FyZHMiIHBhbmljcwo+ID4gbGlrZSB0aGUgb25lIGJlbG93Ogo+ID4g
Cj4gPiDCoEtlcm5lbCBwYW5pYzogdGltZS10cmF2ZWw6IHRpbWUgZ29lcyBiYWNrd2FyZHMgMTYx
Njg5MzQwMDAwNDkyIC0+IDE2MTY4OTMzOTg2OTgxNAoKT3VjaC4KCj4gPiDCoENhbGwgVHJhY2U6
Cj4gPiDCoMKgcGFuaWMrMHgxYTEvMHgzZDcKPiA+IMKgwqB0aW1lX3RyYXZlbF91cGRhdGVfdGlt
ZS5jb2xkKzB4ZTkvMHgxMzMKPiA+IMKgwqB0aW1lcl9yZWFkKzB4YzEvMHgxMDAKPiA+IMKgwqBr
dGltZV9nZXQrMHgxMGMvMHgyMDAKPiA+IMKgwqBjb3B5X3Byb2Nlc3MrMHgxODk5LzB4MjIzMAo+
ID4gwqDCoGtlcm5lbF9jbG9uZSsweDU3LzB4N2EwCj4gPiDCoMKga2VybmVsX3RocmVhZCsweDRh
LzB4NTAKPiA+IMKgwqBrdGhyZWFkZCsweDExNi8weDE5MAo+ID4gCj4gPiBUaGUgcHJvYmxlbSBp
cyBhIHJhY2UgYmV0d2VlbiB0aW1lX3RyYXZlbF9oYW5kbGVfcmVhbF9hbGFybSgpIGFuZAo+ID4g
dGltZXJfcmVhZCgpLiAgdGltZV90cmF2ZWxfaGFuZGxlX3JlYWxfYWxhcm0oKSBjaGFuZ2VzIHRo
ZSB0aW1lIGFmdGVyCj4gPiB0aW1lX3JlYWQoKSByZWFkcyB0aGUgY3VycmVudCB0aW1lIGJ1dCBi
ZWZvcmUgdGltZV90cmF2ZWxfdXBkYXRlX3RpbWUoKQo+ID4gaGFzIGhhZCBhIGNoYW5jZSB0byBh
ZGQgdGhlIGVuZCBldmVudC4KPiA+IAo+ID4gRml4IHRoaXMgYnkgZG9pbmcgdGhlIHRpbWUgcmVh
ZCBhbmQgZXZlbnQgYWRkIGF0b21pY2FsbHkgd2l0aCByZXNwZWN0IHRvCj4gPiB0aW1lX3RyYXZl
bF9oYW5kbGVfcmVhbF9hbGFybSgpLgo+IAo+IEZ1cnRoZXIgdGVzdGluZyByZXN1bHRlZCBpbiBo
aXR0aW5nIHRoZSBCVUdfT04odGltZV90cmF2ZWxfdGltZSAhPQo+IGUtPnRpbWUpIHNvIGxvb2tz
IGxpa2UgdGhpcyBuZWVkcyBzb21lIG1vcmUgd29yay4gIAo+IAoKWWVhaCB0aGlzIGlzIGEgdHJp
Y2t5IGFyZWEsIEkgZm91Z2h0IHdpdGggaXQgZm9yIHF1aXRlIGEgd2hpbGUgdG9vLApzZWVtcyB3
ZSdyZSBub3QgZG9uZSB5ZXQgOy0pCgpXZSBtb3N0bHkgdXNlIHRpbWUtdHJhdmVsPWV4dCBtb2Rl
IHRoZXNlIGRheXMsIHNvIG91ciBzeXN0ZW0gbWF5IG5vdCBiZQphcyBzdXNjZXB0aWJsZSB0byBp
dD8gQnV0IG5vdCBzdXJlLCBpbiBzb21lIGNhc2VzIGl0IHJ1bnMgd2l0aCBqdXN0IGEKc2luZ2xl
IGluc3RhbmNlLCBhbmQgdGhhdCBzaG91bGQgYmUgcHJldHR5IG11Y2ggdGhlIHNhbWUgZHVlIHRv
IHRoZQpmcmVlLXVudGlsIGluZm9ybWF0aW9uLgoKRG8geW91IGhhdmUgYSBzcGVjaWZpYyB3b3Jr
bG9hZCB0aGF0IHRlbmRzIHRvIHJlcHJvZHVjZSB0aGlzPwoKam9oYW5uZXMKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
