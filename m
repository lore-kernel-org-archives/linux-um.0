Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30470C4332F
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pytg6vdVo4ro+G3sVuvzRNz3oHzZUvUntWE9Pkjxy6E=; b=oZ4LMWb9mcUMEbDQTQBmuxPIda
	moiDqWZ2tZtui1RISlTOfyoFo/h7uxThd5ZPAVRoLvfBV1i5T329of47p8o+2wK7ry8EKFhGo2GWQ
	eVlvCfx/YuQ871r+Wq6Mfd76yTPco0wB/E+kbQ73aMD6+Hs4vvG2zyGp/JQiJ9JDWhgTWpBLUKRJI
	jAGJUtrKNeLsTqgb995XqTFJ73ysM3w8z/yDAyIj5D8FXqD6BtleCSf5R2ApFE6MHwe8SvhL0pBVk
	kewjd/lgXA+MzF/NVjWYKsrPV9xBIdc2JfgAVwxlyXyvkxEyV8Qd61f+RqEtXurUPnFxjvW6w95oT
	SmKjxJ0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UY2-0095nY-0o;
	Fri, 10 Nov 2023 16:39:58 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1UXy-0095mw-2A
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 16:39:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=tAje5/jvw70Jy4s1mJSaED5YleWazOG5O4JAQLxDU04=; t=1699634390; x=1700843990; 
	b=QRFvgQo8aepXup8KdoSvHC6a7QcXt68yyHr0ToksyCJRu9bo5RSVSHS6g++5yhki+BqnL4WovO4
	8onnehVwOFWUbInGr81yDb466b19AO9lK8Cg+4ZA7VN3xyMOyhDz1K5Oni0aIc1bKkiNyyauzNBcw
	G/CG6uC7Hyol5Rtj2i30eZaSXhdmVVOyFBGwgzHPM0appeaYDD0+LkT+1ScVgbYClIqDd1fizESN7
	SQR22WLkj7uq8HvZWTjJN6lxKsU0UaRfxL4FDJYULjOW6aluFBu2qkqito0me1RbcvOSc/g/+XPMc
	aLZCM/KpzffNuigEHlHaGj70ZGtBiHhZfb+w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1r1UXl-000000035ec-1KQU;
	Fri, 10 Nov 2023 17:39:41 +0100
Message-ID: <0246e8d9dbccf86a2e83560cc62c0d4b752c7c25.camel@sipsolutions.net>
Subject: Re: [PATCH RFC 10/11] um: Delay timer_read only in possible busy
 loops in TT-mode
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, Johannes Berg
 <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Date: Fri, 10 Nov 2023 17:39:39 +0100
In-Reply-To: <867df5dc-8e78-48de-aa1a-da7c8fedb5e6@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
	 <20231103-bb-timetravel-patches-v1-10-e2c68efcf664@uni-rostock.de>
	 <7daf6651289bd6b48e069f4d0dd7751244177a44.camel@sipsolutions.net>
	 <867df5dc-8e78-48de-aa1a-da7c8fedb5e6@uni-rostock.de>
Content-Type: multipart/mixed; boundary="=-wQNp8qjQHojR5UQncRFW"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
X-malware-bazaar-3: OK
X-malware-bazaar-4: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_083954_868497_B8661315 
X-CRM114-Status: GOOD (  28.79  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--=-wQNp8qjQHojR5UQncRFW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-11-10 at 16:54 +0100, Benjamin Beichler wrote:
> At the moment, we haven't patched the random device that fetches random=
=20
> bytes from the host (do you already have a patch for this?),
> so complete repeatability isn't guaranteed at the moment. However, that=
=20
> could be a logical next step.

Right, we have the attached kernel patches internally. This simply
disables some of the random sources and replaces os_getrandom with
returning static random from the UML_RANDOM environment variable.

I doubt that it makes sense to upstream these patches, but may we can
include them as patch files in USFSTL or so.

The second piece is using a mount namespace to ensure that the linux
command line is identical between runs and that the location of all
files that are accessed directly from the host through hostfs never
changes.

The last piece was setting GLIBC_TUNABLES=3D-AVX512CD in the environment
just in case the CPU feature set is slightly different. That would
cause ld.so to search for a different set of optimized library versions
(affecting syscalls and with that randomness).

Benjamin

--=-wQNp8qjQHojR5UQncRFW
Content-Disposition: attachment;
	filename="0001-um-Use-fixed-random-seed-if-UML_RANDOM-is-set.patch"
Content-Type: text/x-patch;
	name="0001-um-Use-fixed-random-seed-if-UML_RANDOM-is-set.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAwYjUxMjAyODcyMTExZjFhNWY3YTU5NDM1ZmY3NDFlZjAyNzJkMzBmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNv
bT4KRGF0ZTogVGh1LCAxNiBNYXIgMjAyMyAxMzoxOTozNyArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
MS8zXSB1bTogVXNlIGZpeGVkIHJhbmRvbSBzZWVkIGlmIFVNTF9SQU5ET00gaXMgc2V0CgpUaGlz
IGhlbHBzIHdpdGggcmVwcm9kdWNhYmxlIHRlc3QgcnVucy4KClNpZ25lZC1vZmYtYnk6IEJlbmph
bWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPgotLS0KIGFyY2gvdW0vb3MtTGludXgv
dXRpbC5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGludXgv
dXRpbC5jIGIvYXJjaC91bS9vcy1MaW51eC91dGlsLmMKaW5kZXggZmMwZjJhOWRlZTVhLi4xZTdi
MTkyNzJkZmEgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vb3MtTGludXgvdXRpbC5jCisrKyBiL2FyY2gv
dW0vb3MtTGludXgvdXRpbC5jCkBAIC05OSw2ICs5OSw0MiBAQCBzdGF0aWMgaW5saW5lIHZvaWQg
X19hdHRyaWJ1dGVfXyAoKG5vcmV0dXJuKSkgdW1sX2Fib3J0KHZvaWQpCiAKIHNzaXplX3Qgb3Nf
Z2V0cmFuZG9tKHZvaWQgKmJ1Ziwgc2l6ZV90IGxlbiwgdW5zaWduZWQgaW50IGZsYWdzKQogewor
CXN0YXRpYyBjaGFyIHJhbmRvbV9wYXR0ZXJuWzEyOF07CisJc3RhdGljIHNzaXplX3QgcmFuZG9t
X3BhdHRlcm5fbGVuID0gLTE7CisKKwkvKiBUaGlzIGhhcHBlbnMgd2hlbiBjYWxsZWQgYnkgc2V0
dXBfYXJjaCAqLworCWlmIChyYW5kb21fcGF0dGVybl9sZW4gPT0gLTEpIHsKKwkJY29uc3QgY2hh
ciAqZW52OworCisJCWVudiA9IGdldGVudigiVU1MX1JBTkRPTSIpOworCQlpZiAoZW52KSB7CisJ
CQlyYW5kb21fcGF0dGVybl9sZW4gPQorCQkJCXN0cmxlbihlbnYpID4gc2l6ZW9mKHJhbmRvbV9w
YXR0ZXJuKSA/CisJCQkJc2l6ZW9mKHJhbmRvbV9wYXR0ZXJuKSA6IHN0cmxlbihlbnYpOworCQkJ
bWVtY3B5KHJhbmRvbV9wYXR0ZXJuLCBlbnYsIHJhbmRvbV9wYXR0ZXJuX2xlbik7CisJCX0gZWxz
ZSB7CisJCQlyYW5kb21fcGF0dGVybl9sZW4gPSAwOworCQl9CisJfQorCisJaWYgKHJhbmRvbV9w
YXR0ZXJuX2xlbiA+IDApIHsKKwkJc2l6ZV90IHRhaWwgPSBsZW47CisJCS8qCisJCSAqIElmIHRo
ZSByZXR1cm5lZCBsZW5ndGggaXMgdG9vIHNob3J0LCB0aGVuIHRoZSBrZXJuZWwgbWlnaHQKKwkJ
ICogbG9vcCB0cnlpbmcgdG8gZ2VuZXJhdGUgcmFuZG9tIGZyb20gdGhlIHBhc3Npbmcgb2YgdGlt
ZS4KKwkJICogV2hpY2ggc2VlbXMgdG8gcG9zc2libHkgaW5maW5pdGUgbG9vcCBpbiB0aW1lLXRy
YXZlbCBtb2RlLgorCQkgKiBTbyBqdXN0IHJlcGVhdCB0aGUgZ2l2ZW4gcGF0dGVybi4KKwkJICov
CisJCXdoaWxlICh0YWlsID4gcmFuZG9tX3BhdHRlcm5fbGVuKSB7CisJCQltZW1jcHkoYnVmLCBy
YW5kb21fcGF0dGVybiwgcmFuZG9tX3BhdHRlcm5fbGVuKTsKKwkJCXRhaWwgLT0gcmFuZG9tX3Bh
dHRlcm5fbGVuOworCQkJYnVmICs9IHJhbmRvbV9wYXR0ZXJuX2xlbjsKKwkJfQorCQltZW1jcHko
YnVmLCByYW5kb21fcGF0dGVybiwgdGFpbCk7CisKKwkJcmV0dXJuIGxlbjsKKwl9CisKIAlyZXR1
cm4gZ2V0cmFuZG9tKGJ1ZiwgbGVuLCBmbGFncyk7CiB9CiAKLS0gCjIuNDEuMAoK


--=-wQNp8qjQHojR5UQncRFW
Content-Disposition: attachment; filename="0002-random-disable-interrupt-random-source.patch"
Content-Type: text/x-patch; name="0002-random-disable-interrupt-random-source.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBiOGFhNzRhZWQ5ZmEwMDhiOTA4NjgyYmZhMDg1NDYxNjM1ZTg3NmUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNv
bT4KRGF0ZTogVGh1LCAxNiBNYXIgMjAyMyAxMzoyMToxOSArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8zXSByYW5kb206IGRpc2FibGUgaW50ZXJydXB0IHJhbmRvbSBzb3VyY2UKCkludGVycnVwdHMg
aW4gb3VyIFVNTCBlbnZpcm9ubWVudCBhcmUgc2lnbmFscywgd2hpY2ggY2FuIGJlIGRlbGl2ZXJl
ZCBhdApzb21ld2hhdCByYW5kb20gdGltZXMgZGVwZW5kaW5nIG9uIGhvc3Qgc2NoZWR1bGluZy4g
RGlzYWJsZSB0aGVzZSBhcyBhCnNvdXJjZSB0byBtYWtlIHRoZSByYW5kb20gcmVwcm9kdWNpYmxl
IGJldHdlZW4gcnVucy4KClNpZ25lZC1vZmYtYnk6IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJl
cmdAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMvY2hhci9yYW5kb20uYyB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jaGFyL3JhbmRv
bS5jIGIvZHJpdmVycy9jaGFyL3JhbmRvbS5jCmluZGV4IDI1M2YyZGRiODkxMy4uZGIyYzVhMjk2
YzA1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2NoYXIvcmFuZG9tLmMKKysrIGIvZHJpdmVycy9jaGFy
L3JhbmRvbS5jCkBAIC0xMDkzLDYgKzEwOTMsOSBAQCB2b2lkIGFkZF9pbnRlcnJ1cHRfcmFuZG9t
bmVzcyhpbnQgaXJxKQogCXN0cnVjdCBwdF9yZWdzICpyZWdzID0gZ2V0X2lycV9yZWdzKCk7CiAJ
dW5zaWduZWQgaW50IG5ld19jb3VudDsKIAorCS8qIFVNTCBzZWVtcyB0byBub3QgYWx3YXlzIGdl
dCB0aGUgc2lnbmFscyBlbnRpcmVseSBhdCB0aGUgc2FtZSB0aW1lICovCisJcmV0dXJuOworCiAJ
ZmFzdF9taXgoZmFzdF9wb29sLT5wb29sLCBlbnRyb3B5LAogCQkgKHJlZ3MgPyBpbnN0cnVjdGlv
bl9wb2ludGVyKHJlZ3MpIDogX1JFVF9JUF8pIF4gc3dhYihpcnEpKTsKIAluZXdfY291bnQgPSAr
K2Zhc3RfcG9vbC0+Y291bnQ7Ci0tIAoyLjQxLjAKCg==


--=-wQNp8qjQHojR5UQncRFW
Content-Disposition: attachment;
	filename="0003-random-do-not-include-utsname-in-early-random.patch"
Content-Type: text/x-patch;
	name="0003-random-do-not-include-utsname-in-early-random.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSBjNjJlNjcxMDczY2ZlOTkwZmQyMjAwYzgxZGVmYWU5OGIxZTkyNThiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5qYW1pbiBCZXJnIDxiZW5qYW1pbi5iZXJnQGludGVsLmNv
bT4KRGF0ZTogV2VkLCAyMiBNYXIgMjAyMyAxNzo1NjozNyArMDEwMApTdWJqZWN0OiBbUEFUQ0gg
My8zXSByYW5kb206IGRvIG5vdCBpbmNsdWRlIHV0c25hbWUgaW4gZWFybHkgcmFuZG9tCgpUaGUg
dXRzIG5hbWUgaW5jbHVkZXMgaW5mb3JtYXRpb24gYWJvdXQgdGhlIGNvbXBpbGUgdGltZSBhbmQg
c3VjaCBhbmQKY2hhbmdlcy4gRXhjbHVkZSBpdCwgc28gdGhhdCBkaWZmZXJlbnQga2VybmVsIGNv
bXBpbGF0aW9ucyB3aWxsIHNlZQp0aGUgc2FtZSByYW5kb20gbnVtYmVycy4KClNpZ25lZC1vZmYt
Ynk6IEJlbmphbWluIEJlcmcgPGJlbmphbWluLmJlcmdAaW50ZWwuY29tPgotLS0KIGRyaXZlcnMv
Y2hhci9yYW5kb20uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9yYW5kb20uYyBiL2RyaXZlcnMv
Y2hhci9yYW5kb20uYwppbmRleCBkYjJjNWEyOTZjMDUuLmRkNGFhNDJhNDQwNCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9jaGFyL3JhbmRvbS5jCisrKyBiL2RyaXZlcnMvY2hhci9yYW5kb20uYwpAQCAt
ODY1LDcgKzg2NSw3IEBAIHZvaWQgX19pbml0IHJhbmRvbV9pbml0X2Vhcmx5KGNvbnN0IGNoYXIg
KmNvbW1hbmRfbGluZSkKIAkJKytpOwogCX0KIAotCV9taXhfcG9vbF9ieXRlcyhpbml0X3V0c25h
bWUoKSwgc2l6ZW9mKCooaW5pdF91dHNuYW1lKCkpKSk7CisJLyogX21peF9wb29sX2J5dGVzKGlu
aXRfdXRzbmFtZSgpLCBzaXplb2YoKihpbml0X3V0c25hbWUoKSkpKTsgKi8KIAlfbWl4X3Bvb2xf
Ynl0ZXMoY29tbWFuZF9saW5lLCBzdHJsZW4oY29tbWFuZF9saW5lKSk7CiAKIAkvKiBSZXNlZWQg
aWYgYWxyZWFkeSBzZWVkZWQgYnkgZWFybGllciBwaGFzZXMuICovCi0tIAoyLjQxLjAKCg==


--=-wQNp8qjQHojR5UQncRFW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--=-wQNp8qjQHojR5UQncRFW--

