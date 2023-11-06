Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D51DC4332F
	for <linux-um@archiver.kernel.org>; Mon,  6 Nov 2023 20:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7bIJsYGOe+lEMI5Z/VpTX0oAALs7Z5/UV5t9KsImPow=; b=uSjgyTTJyo7NMw
	rzgaW0m9uZLX1qLyeNgdRwEwMRPsmesAANnDgBHm7VbRLtAO4vAthG2V6NwBC+gvM8xD9E20Zm4Ed
	2lX7oGC8P95HCyLGpdXrlP2K+ZQtctq0d4OcFdREHt2s4nZ8hNw93LMNCYTsw5xHXEvdXNcpONNQk
	/KpwOqBnNntbBYcBxMEVmgMCHeLGfStdhzaQm2eh3DFqip9FJoHejuVL/sy/wBJHunyGYE76z32Xm
	rxqJfme9duTJlxtCxCHwSerkfDsdC/V6xf/ipei3LS1uvGeowh7eHd/VYq9L+8cj5zBhHGWMPOGLW
	tEVXNSL2r7xb6d3ZrkyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r06HR-00HVVs-1d;
	Mon, 06 Nov 2023 20:33:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06HQ-00HVVa-0I
	for linux-um@bombadil.infradead.org;
	Mon, 06 Nov 2023 20:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=sOx98/VJBQNN8Xynm6bBAiZxOCqGtQoIz482kQw9TkY=; b=bHHlgEJt+4YbZRw/1rBGJHdrxj
	+FDm0EBl1M6ORC688ldTwM8KtQAkP1n0hp6GkXy7YoTX+5r/gy34zdk+uvtg/4KXzH9BzVVVtJSX0
	MW8FBqq+UjMjSlismVHmENDy7x/JjENV2Wllp/x8WyGX+4pM5HdDvDsLNDDAMGFT9XkZwHan3XdlW
	iER2YXCCOfMc7LSg8Uf8vuTyGgUckxxJaThhJTrTYRBAWzo1zOVXdZUSxKANGQV4mK5IE7HJKN5QP
	fZtsnHWXXVCsZqvVkXyRZiJmz1bDasuwaFhfxOMFxQvbLCGWDAEXeLdtRObBDU/Wf4CYR4A10VPrh
	y/OMOh1w==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r06HE-00AmSs-2V
	for linux-um@lists.infradead.org;
	Mon, 06 Nov 2023 20:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sOx98/VJBQNN8Xynm6bBAiZxOCqGtQoIz482kQw9TkY=;
	t=1699302772; x=1700512372; b=v756iBU7BkDCYLobOZw1lsMk5fE1PKaKl02W7PvXd23YMjd
	wK9Xcyayf4GKi4cGLWmXSczVqcYKoWVD19SB9RxQDAezppMscR/rI9343MwNfmle3IfdkzkWnwHrE
	2C3B+4deHWS1ihEuTS69nAlnKfx5aNawHuuD9IKwOVEGo0oMm/z8qag3o45Szh3k3LujZHLnFnf2I
	kRXfCerR4Tgai1P/9+0O+J330ZW0jTypLUY2ROINEe99Hl3xkkqUJ6SZA/Udtjp9v5XY1reUSK6po
	zxmTurCxOaUVwZEyRApDFdiArOypaRaNXxQoMdvml0bW4olh+/DizTlcpYEfH2JQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r06HD-0000000FsxW-0QbK;
	Mon, 06 Nov 2023 21:32:51 +0100
Message-ID: <c42b1a738da2b335f84266978bb3bf0aa6ccb78e.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 06/11] um: always send UM_TIMETRAVEL_REQUEST from
 ISRs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <benjamin.beichler@uni-rostock.de>, Richard Weinberger
	 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Mon, 06 Nov 2023 21:32:50 +0100
In-Reply-To: <20231103-bb-timetravel-patches-v1-6-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-6-e2c68efcf664@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231106_203254_934385_B344F9D0 
X-CRM114-Status: GOOD (  17.52  )
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

T24gRnJpLCAyMDIzLTExLTAzIGF0IDE2OjQxICswMDAwLCBCZW5qYW1pbiBCZWljaGxlciB3cm90
ZToKPiBUaGUgbnVtYmVyIG9mIFVNX1RJTUVUUkFWRUxfUkVRVUVTVCBtc2dzIGlzIHRyaWVkIHRv
IHJlZHVjZWQsIGlmIHRoZXkKPiBhcmUgcmVkdW5kYW50IHZpYSB0aGUgdGltZV90cmF2ZWxfZXh0
X3ByZXZfcmVxdWVzdF92YWxpZCBmbGFnLsKgCj4gCgpUaGlzIC4uLiBkb2Vzbid0IHBhcnNlIHNv
IHdlbGwuIEkgdGhpbmsgSSBnZXQgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIHNheSwKYnV0IGl0J3Mg
YSBiaXQgYXdrd2FyZD8KCk1heWJlIHNheSAiVGhlIGNvZGUgYXR0ZW1wdHMgdG8gcmVkdWNlIHRo
ZSBudW1iZXIgb2YgLi4uIG1lc3NhZ2VzIGlmCnRoZXkgYXJlIHJlZHVuZGFudC4gVGhpcyBpcyBh
Y2hpZXZlZCB3aXRoIHRoZSAuLi4gZmxhZy4iIG9yIHNvbWV0aGluZwpsaWtlIHRoYXQ/CgpBdCBs
ZWFzdCB0aGF0J3Mgd2hhdCBJIHRoaW5rIHdoYXQgeW91J3JlIHRyeWluZyB0byBzYXkgOikKCj4g
VGhpcyBjYW4KPiBjcmVhdGUgYSByYWNlIGNvbmRpdGlvbiwgd2hlbiBhbiBpbnRlcnJ1cHQgaGFw
cGVucyBhbmQgdGhlIGlkbGUgbG9vcAo+IHdhbnRzIHRvIHdhaXQuCj4gCj4gVGhpcyBtZWFucywg
c29tZXRpbWVzIHRoZSBVTV9USU1FVFJBVkVMX1JFUVVFU1QgYXJlIHNlbnQod2hlbiB0aGUgaWRs
ZQo+IGxvb3AgYWxyZWFkeSBzdGFydGVkIHdhaXRpbmcpIGFuZCBzb21ldGltZXMgbm90LCB3aGlj
aCBtYWtlcyBpdCBoYXJkZXIKPiB0byBpbXBsZW1lbnQgdGhlIG90aGVyIGVuZCBvZiB0aGUgc2No
ZWR1bGVyLsKgCgpOb3Qgc3VyZSBJIGdldCB0aGF0IHRob3VnaCwgd2h5IGRvZXMgaXQgbWF0dGVy
PyBKdXN0IGtlZXAgdHJhY2sgb2YgdGhlCmxhc3QgcmVxdWVzdD8KCkRvIHlvdSBoYXZlIHNvbWUg
a2luZCBvZiAoY2FsZW5kYXIpIGxvZ3MgdGhhdCB3b3VsZCBzaG93IHRoZSBkaWZmZXJlbnQKbWVz
c2FnZSBiZWhhdmlvdXI/CgpGV0lXLCB3ZSd2ZSBhbHNvIGdvdCB3b3JrIHBlbmRpbmcgZm9yIGEg
d2hpbGUgbm93IHRoYXQgd2Ugc2hvdWxkIHN1Ym1pdAp0aGF0IGltcGxlbWVudHMgc2NoZWR1bGlu
ZyB2aWEgc2hhcmVkIG1lbW9yeSBmb3IgdGhlIG1vc3QgcGFydCwgc28gdGhhdAphbGwgdGhlc2Ug
UkVRVUVTVCBhbmQgdGltZSB1cGRhdGUgbWVzc2FnZXMganVzdCBnbyBhd2F5IF9lbnRpcmVseV8s
CndoaWNoIGhlbHBzIGEgbG90IGZvciBwZXJmb3JtYW5jZSB0b28uCgo+ICsrKyBiL2FyY2gvdW0v
a2VybmVsL3RpbWUuYwo+IEBAIC00NDYsNiArNDQ2LDcgQEAgdm9pZCB0aW1lX3RyYXZlbF9hZGRf
aXJxX2V2ZW50KHN0cnVjdCB0aW1lX3RyYXZlbF9ldmVudCAqZSkKPiAgCUJVR19PTih0aW1lX3Ry
YXZlbF9tb2RlICE9IFRUX01PREVfRVhURVJOQUwpOwo+ICAKPiAgCXRpbWVfdHJhdmVsX2V4dF9n
ZXRfdGltZSgpOwo+ICsJdGltZV90cmF2ZWxfZXh0X3ByZXZfcmVxdWVzdF92YWxpZCA9IGZhbHNl
Owo+IAoKQXQgdGhlIHZlcnkgbGVhc3QgSSB0aGluayB0aGVyZSBzaG91bGQgYmUgYSBjb21tZW50
IGhlcmUsIGJ1dCBJJ20gbm90CnJlYWxseSBjb252aW5jZWQgeWV0IHdoeSB0aGlzIG1ha2VzIHNl
bnNlIDopCgpqb2hhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
