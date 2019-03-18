Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h5npr-0006Bu-Uz
 for linux-um@lists.infradead.org; Mon, 18 Mar 2019 08:41:33 +0000
Subject: Re: [PATCH] hostfs: fix mismatch between link_file definition and
 declaration
References: <20190317230909.7373-1-colin.king@canonical.com>
 <1760676.zAVrM27zAz@blindfold>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <fa1378b0-3048-8309-a152-8fdf5696731d@canonical.com>
Date: Mon, 18 Mar 2019 08:41:28 +0000
MIME-Version: 1.0
In-Reply-To: <1760676.zAVrM27zAz@blindfold>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: kernel-janitors@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

T24gMTcvMDMvMjAxOSAyMzo0OSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IEFtIE1vbnRh
ZywgMTguIE3DpHJ6IDIwMTksIDAwOjA5OjA5IENFVCBzY2hyaWViIENvbGluIEtpbmc6Cj4+IEZy
b206IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Cj4+Cj4+IFRoZSBm
dW5jdGlvbiBsaW5rX2ZpbGUgZGVjbGFyYXRpb24gaW4gdGhlIGhlYWRlciBmaWxlIGhhcyB0aGUg
b3JkZXIKPj4gb2YgdGhlIHR3byBhcmd1bWVudHMgKGZyb20sIHRvKSBzd2FwcGVkIHdoZW4gY29t
cGFyZWQgdG8gdGhlIGRlZmluaXRpb24KPj4gYXJndW1lbnRzIG9mICh0bywgZnJvbSkuICBGaXgg
dGhpcyBieSBzd2FwcGluZyB0aGVtIGFyb3VuZCB0byBtYXRjaAo+PiB0aGUgZGVmaW5pdGlvbi4K
Pj4KPj4gVGhpcyBlcnJvciBwcmVkYXRlcyB0aGUgZ2l0IGhpc3RvcnksIHNvIG5vIGlkZWEgd2hl
biB0aGlzIGVycm9yCj4+IHdhcyBpbnRyb2R1Y2VkLgo+IAo+IGNvbW1pdCBiZjRmODA0NzM4NTQ0
YTk1YjhiYzhkNmE3ZTI2MjljM2ZjMDI0MGRkCj4gQXV0aG9yOiBqZGlrZSA8amRpa2U+Cj4gRGF0
ZTogICBTYXQgRGVjIDkgMjI6NTI6NDQgMjAwMCArMDAwMAo+IAo+ICAgICBob3N0ZnMgbm93IG1v
c3RseSB3b3Jrcy4gIEFsbW9zdCBhbGwgb2YgdGhlIGNvbW1vbiBvcGVyYXRpb25zIGFyZSBub3cK
PiAgICAgaW1wbGVtZW50ZWQsIHRoZSBtYWluIGV4Y2VwdGlvbnMgYmVpbmcgbWtub2QgYW5kIGV4
ZWN1dGluZyBmaWxlcyBmcm9tCj4gICAgIGEgaG9zdGZzIGZpbGVzeXN0ZW0uCj4gCj4gRW5vdWdo
IGFyY2hhZW9sb2d5IGZvciB0b2RheS4gOi0pCgpOaWNlLiBIb3cgZG8geW91IGZpbmQgdGhlc2Ug
YW5jaWVudCBnaXQgY29tbWl0cz8KCj4gCj4gVGhhbmtzLAo+IC8vcmljaGFyZAo+IAo+IAoKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1h
aWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

