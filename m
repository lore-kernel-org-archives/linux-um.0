Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E4E8EB64DD
	for <linux-um@archiver.kernel.org>; Mon, 31 Jul 2023 02:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iubsDa2BFTee8kHOVvSUcVsJmjxH6Vt4Rs2Xe+Rl6vE=; b=JWWOqk31HdY1we
	vBTRuUdffE3apVOwovwUEyF/ytqx1hWpyY0pJAXLTg2dPjN3iP3vgnmHIYvedNec/TF4VjNRgdRxZ
	+GFn0ZQIxoTLfJV75iXz37Sau+VTLnZHWmLlZ4ke60XLM3uqj5MS4bKgRq8OqMnPK5GACV38nFapx
	J63abQ8ZJffpTJuS6qnUJ6dy00wudfBmNJ1JUQJJzgQnVBW7zY4qZMVshb5cwurtnWCfWgMKrafWd
	RkewewANgnOpvZp5PagltNFK0PpUJDIQhhdI5JkmTVaXY/FmXUOr6ohZQN3G8iy6EZUm22zVzkYtZ
	1vKANbp+GmMVmerwjsUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQInW-00DXFB-1T;
	Mon, 31 Jul 2023 02:38:14 +0000
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qQInP-00DXEJ-0Z;
	Mon, 31 Jul 2023 02:38:07 +0000
Message-ID: <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
Date: Sun, 30 Jul 2023 19:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Tejun Heo <tj@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Jaroslav Kysela <perex@perex.cz>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20230728043013.27776-1-rdunlap@infradead.org>
 <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
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

CgpPbiA3LzI4LzIzIDAxOjUxLCBNYXNhaGlybyBZYW1hZGEgd3JvdGU6Cj4gT24gRnJpLCBKdWwg
MjgsIDIwMjMgYXQgMTozMOKAr1BNIFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3Jn
PiB3cm90ZToKPj4KPj4gVXNlICJzZWxlY3QicyB0byBlbnN1cmUgdGhhdCB0aGUgcmVxdWlyZWQg
a2NvbmZpZyBzeW1ib2xzIGFyZSBzZXQKPj4gYXMgZXhwZWN0ZWQuCj4+IERyb3AgSE9TVEFVRElP
IHNpbmNlIGl0IGlzIG5vdyBlcXVpdmFsZW50IHRvIFVNTF9TT1VORC4KPj4KPj4gQWxsb3cgU09V
TkQgd2l0aCBVTUwgcmVnYXJkbGVzcyBvZiBIQVNfSU9NRU0uIE90aGVyd2lzZSB0aGVyZSBpcyBh
Cj4+IGtjb25maWcgd2FybmluZyBmb3IgdW5tZXQgZGVwZW5kZW5jaWVzLiAoVGhpcyB3YXMgbm90
IGFuIGlzc3VlIHdoZW4KPj4gU09VTkQgd2FzIGRlZmluZWQgaW4gYXJjaC91bS9kcml2ZXJzL0tj
b25maWcuIEkgaGF2ZSBkb25lIDUwIHJhbmRjb25maWcKPj4gYnVpbGRzIGFuZCBkaWRuJ3QgZmlu
ZCBhbnkgaXNzdWVzLikKPj4KPj4gVGhpcyBmaXhlcyBidWlsZCBlcnJvcnMgd2hlbiBDT05GSUdf
U09VTkQgaXMgbm90IHNldDoKPj4KPj4gbGQ6IGFyY2gvdW0vZHJpdmVycy9ob3N0YXVkaW9fa2Vy
bi5vOiBpbiBmdW5jdGlvbiBgaG9zdGF1ZGlvX2NsZWFudXBfbW9kdWxlJzoKPj4gaG9zdGF1ZGlv
X2tlcm4uYzooLmV4aXQudGV4dCsweGEpOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGB1bnJlZ2lz
dGVyX3NvdW5kX21peGVyJwo+PiBsZDogaG9zdGF1ZGlvX2tlcm4uYzooLmV4aXQudGV4dCsweDE1
KTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdW5yZWdpc3Rlcl9zb3VuZF9kc3AnCj4+IGxkOiBh
cmNoL3VtL2RyaXZlcnMvaG9zdGF1ZGlvX2tlcm4ubzogaW4gZnVuY3Rpb24gYGhvc3RhdWRpb19p
bml0X21vZHVsZSc6Cj4+IGhvc3RhdWRpb19rZXJuLmM6KC5pbml0LnRleHQrMHgxOSk6IHVuZGVm
aW5lZCByZWZlcmVuY2UgdG8gYHJlZ2lzdGVyX3NvdW5kX2RzcCcKPj4gbGQ6IGhvc3RhdWRpb19r
ZXJuLmM6KC5pbml0LnRleHQrMHgzMSk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHJlZ2lzdGVy
X3NvdW5kX21peGVyJwo+PiBsZDogaG9zdGF1ZGlvX2tlcm4uYzooLmluaXQudGV4dCsweDQ5KTog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0byBgdW5yZWdpc3Rlcl9zb3VuZF9kc3AnCj4+Cj4+IGFuZCB0
aGlzIGtjb25maWcgd2FybmluZzoKPj4gV0FSTklORzogdW5tZXQgZGlyZWN0IGRlcGVuZGVuY2ll
cyBkZXRlY3RlZCBmb3IgU09VTkQKPj4KPj4gRml4ZXM6IDFkYTE3N2U0YzNmNCAoIkxpbnV4LTIu
Ni4xMi1yYzIiKQo+PiBGaXhlczogZDg4NmU4N2NiODJiICgic291bmQ6IG1ha2UgT1NTIHNvdW5k
IGNvcmUgb3B0aW9uYWwiKQo+PiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4KPj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50
ZWwuY29tPgo+PiBMaW5rOiBsb3JlLmtlcm5lbC5vcmcvci8yMDIzMDcxNDE0MTYudnh1UlZwRnYt
bGtwQGludGVsLmNvbQo+PiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4K
Pj4gQ2M6IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4g
Q2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+Cj4+IENjOiBsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4+IENjOiBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+
Cj4+IENjOiBUYWthc2hpIEl3YWkgPHRpd2FpQHN1c2UuZGU+Cj4+IENjOiBKYXJvc2xhdiBLeXNl
bGEgPHBlcmV4QHBlcmV4LmN6Pgo+PiBDYzogTWFzYWhpcm8gWWFtYWRhIDxtYXNhaGlyb3lAa2Vy
bmVsLm9yZz4KPj4gQ2M6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVsLm9yZz4KPj4g
Q2M6IE5pY2sgRGVzYXVsbmllcnMgPG5kZXNhdWxuaWVyc0Bnb29nbGUuY29tPgo+PiBDYzogTmlj
b2xhcyBTY2hpZXIgPG5pY29sYXNAZmphc2xlLmV1Pgo+PiBDYzogbGludXgta2J1aWxkQHZnZXIu
a2VybmVsLm9yZwo+PiBDYzogYWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCj4+IC0tLQo+PiB2
MjogZG9uJ3QgZGVsZXRlIHRoZSBIT1NUQVVESU8gS2NvbmZpZyBlbnRyeSAoTWFzYWhpcm8pCj4+
IHYzOiBkcm9wIEhPU1RBVURJTyBhbmQgdXNlIENPTkZJR19VTUxfU09VTkQgZm9yIGl0IGluIE1h
a2VmaWxlIChUYWthc2hpKTsKPj4gICAgIGFkZCBTT1VORCBkZXBlbmRzIG9uICJ8fCBVTUwiIHRv
IEhBU19JT01FTQo+Pgo+PiAgYXJjaC91bS9kcml2ZXJzL0tjb25maWcgIHwgICAxNCArKy0tLS0t
LS0tLS0tLQo+PiAgYXJjaC91bS9kcml2ZXJzL01ha2VmaWxlIHwgICAgMiArLQo+PiAgc291bmQv
S2NvbmZpZyAgICAgICAgICAgIHwgICAgMiArLQo+PiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tIGEvYXJjaC91bS9kcml2ZXJz
L0tjb25maWcgYi9hcmNoL3VtL2RyaXZlcnMvS2NvbmZpZwo+PiAtLS0gYS9hcmNoL3VtL2RyaXZl
cnMvS2NvbmZpZwo+PiArKysgYi9hcmNoL3VtL2RyaXZlcnMvS2NvbmZpZwo+PiBAQCAtMTExLDI0
ICsxMTEsMTQgQEAgY29uZmlnIFNTTF9DSEFOCj4+Cj4+ICBjb25maWcgVU1MX1NPVU5ECj4+ICAg
ICAgICAgdHJpc3RhdGUgIlNvdW5kIHN1cHBvcnQiCj4+ICsgICAgICAgc2VsZWN0IFNPVU5ECj4g
Cj4gCj4gVGhpcyB3b3VsZCBiZSB0aGUgb25seSBpbnN0YW5jZSB0aGF0IHNlbGVjdCdzIFNPVU5E
Lgo+IFBlcmhhcHMsIHRoaXMgY291bGQgYmUgJ2RlcGVuZHMgb24gU09VTkQnLgo+IChpbiB0aGF0
IGNhc2UsIGFyY2gvdW0vY29uZmlncy8qX2RlZmNvbmZpZyBuZWVkcyBtb2RpZmljYXRpb24pLgo+
IAo+IEp1c3QgbXkgdHdvIGNlbnRzLgo+IAoKT2gsIGdvb2QgcG9pbnQsIGFuZCBvbmUgdGhhdCBJ
IGFncmVlIHdpdGguCgpJJ2xsIHNlbmQgYSB2NC4KCj4gCj4gUmV2aWV3ZWQtYnk6IE1hc2FoaXJv
IFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+CgpUYWthc2hpLCBJIGRvbid0IGtub3cgd2hv
IHdpbGwgbWVyZ2UgdGhlIHBhdGNoLCBidXQgSSB3b3VsZCBleHBlY3QKdGhhdCBvbmUgb2YgdGhl
IFVNTCBtYWludGFpbmVycyB0byBtZXJnZSBpdC4uLi4gRldJVy4KClRoYW5rcy4KLS0gCn5SYW5k
eQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
