Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7451DC77B7F
	for <linux-um@archiver.kernel.org>; Tue, 16 May 2023 09:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xvykMFvSJW8O4BRKLunRftRSlW6NzpNTzUVijEOndDs=; b=L3eKu+9RIIhkYg
	NnnadAHxQt9KIwiFUQ8hvko7BAmwfmla+duS579YQPz5AHFjVwseMdhzsl9ZzFl9giai5eIkOHEFJ
	bRDM1dAOAc7sMFumj4k72w0lZ6Sfr/I0+a5/k6NPF0NpB9dAgPEsQViXGUIQh6uqMOBmEkLMySlXj
	Xe/xSlskzkWNV/SM98Mja8QHdmTm91u/aIJeWBEM2oFpP8+mr3LAcVUEX3KAoUrIfE4o1G+q8Df9U
	yCguFf2qGpRol/OQFUxlGJUGaqifJXcW06b3wn/c+DjLSPoqRz53gbCuci9YPKB42JHlxmE9grRDQ
	8tN01lA+qh4Z/ApMWWkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyqpD-0051u3-2L;
	Tue, 16 May 2023 09:18:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyqpA-0051sz-2I
	for linux-um@lists.infradead.org;
	Tue, 16 May 2023 09:18:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 11C6861985;
	Tue, 16 May 2023 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A0C433D2;
	Tue, 16 May 2023 09:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1684228707;
	bh=8BJ+s5vIHAO4GubJlcqW6iAuHjFow3RHcI4fHoEz8l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YX1tZTc7H7B3YOGuXOCgpLm7vNWJMxLIbZPUKGYrFXKTcFYbTyi9C2rJmqBXMlcQt
	 7HGlKtVUthFlmYH40oHlJsjXDPeZCW3DDINYZLb7ly3rQfCVN77rKTd8Y9R3xo4U/k
	 Yquru0Lbfv6sQD9NSOjVjQoCThSwSxSKHigVjJAA=
Date: Tue, 16 May 2023 11:18:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Fabio Estevam <festevam@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: Re: [PATCH 4.19 007/191] IMA: allow/fix UML builds
Message-ID: <2023051655-dinghy-uncolored-6480@gregkh>
References: <20230515161707.203549282@linuxfoundation.org>
 <20230515161707.460071056@linuxfoundation.org>
 <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWjkZ-FAKrwQkoyZRHLpyvaVYT0NvAUwaCs+30qC2VZmA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230516_021828_792826_5DFAE2C2 
X-CRM114-Status: GOOD (  14.21  )
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

T24gVHVlLCBNYXkgMTYsIDIwMjMgYXQgMTA6NDc6MTNBTSArMDIwMCwgR2VlcnQgVXl0dGVyaG9l
dmVuIHdyb3RlOgo+IEhpIEdyZWcsCj4gCj4gT24gTW9uLCBNYXkgMTUsIDIwMjMgYXQgNjozOeKA
r1BNIEdyZWcgS3JvYWgtSGFydG1hbgo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3Jv
dGU6Cj4gPiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPiA+Cj4g
PiBjb21taXQgNjQ0ZjE3NDEyZjVhY2YwMWExOWFmOWQwNGE5MjE5MzdhMmJjODZjNiB1cHN0cmVh
bS4KPiA+Cj4gPiBVTUwgc3VwcG9ydHMgSEFTX0lPTUVNIHNpbmNlIDBiYmFkYWZkYzQ5ZCAodW06
IGFsbG93IGRpc2FibGluZwo+ID4gTk9fSU9NRU0pLgo+IAo+IDBiYmFkYWZkYzQ5ZCBpcyBpbiB2
NS4xNC4KPiBXYXMgaXQgYmFja3BvcnRlZCB0byBvbGRlciB2ZXJzaW9ucz8KCk5vcGUuCgo+ID4g
Q3VycmVudCBJTUEgYnVpbGQgb24gVU1MIGZhaWxzIG9uIGFsbG1vZGNvbmZpZyAod2l0aCBUQ0df
VFBNPW0pOgo+ID4KPiA+IGxkOiBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9xdWV1ZS5vOiBp
biBmdW5jdGlvbiBgaW1hX2FkZF90ZW1wbGF0ZV9lbnRyeSc6Cj4gPiBpbWFfcXVldWUuYzooLnRl
eHQrMHgyZDkpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB0cG1fcGNyX2V4dGVuZCcKPiA+IGxk
OiBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2ltYV9pbml0Lm86IGluIGZ1bmN0aW9uIGBpbWFfaW5p
dCc6Cj4gPiBpbWFfaW5pdC5jOiguaW5pdC50ZXh0KzB4NDNmKTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgdHBtX2RlZmF1bHRfY2hpcCcKPiA+IGxkOiBzZWN1cml0eS9pbnRlZ3JpdHkvaW1hL2lt
YV9jcnlwdG8ubzogaW4gZnVuY3Rpb24gYGltYV9jYWxjX2Jvb3RfYWdncmVnYXRlX3RmbSc6Cj4g
PiBpbWFfY3J5cHRvLmM6KC50ZXh0KzB4MTA0NCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHRw
bV9wY3JfcmVhZCcKPiA+IGxkOiBpbWFfY3J5cHRvLmM6KC50ZXh0KzB4MTBkOCk6IHVuZGVmaW5l
ZCByZWZlcmVuY2UgdG8gYHRwbV9wY3JfcmVhZCcKPiA+Cj4gPiBNb2RpZnkgdGhlIElNQSBLY29u
ZmlnIGVudHJ5IHNvIHRoYXQgaXQgc2VsZWN0cyBUQ0dfVFBNIGlmIEhBU19JT01FTQo+ID4gaXMg
c2V0LCByZWdhcmRsZXNzIG9mIHRoZSBVTUwgS2NvbmZpZyBzZXR0aW5nLgo+ID4gVGhpcyB1cGRh
dGVzIFRDR19UUE0gZnJvbSA9bSB0byA9eSBhbmQgZml4ZXMgdGhlIGxpbmtlciBlcnJvcnMuCj4g
Pgo+ID4gRml4ZXM6IGY0YTAzOTFkZmE5MSAoImltYTogZml4IEtjb25maWcgZGVwZW5kZW5jaWVz
IikKClRoaXMgaXMgd2hhdCBJIHRyaWdnZXJlZCBvZmYgb2YuCgo+ID4gQ2M6IFN0YWJsZSA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NS4xNCsKPiAKPiAidjUuMTQrIgoKU29ycnksIGdvb2Qg
Y2F0Y2gsIEknbGwgZ28gZHJvcCB0aGlzIGZyb20gYWxsIG9mIHRoZSBvbGRlciBxdWV1ZXMuCgp0
aGFua3MgZm9yIHRoZSByZXZpZXchCgpncmVnIGstaAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=
