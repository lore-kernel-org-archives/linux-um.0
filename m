Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndTx3-004ZmF-Ub
 for linux-um@lists.infradead.org; Sun, 10 Apr 2022 09:33:47 +0000
Date: Sun, 10 Apr 2022 11:33:33 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1087614384.239493.1649583213699.JavaMail.zimbra@nod.at>
In-Reply-To: <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
 <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
 <1b03d888-cea3-3e6f-087f-daeb5642a975@leemhuis.info>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
MIME-Version: 1.0
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
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Zhen Lei <thunder.leizhen@huawei.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIlRob3JzdGVuIExlZW1odWlz
IiA8cmVncmVzc2lvbnNAbGVlbWh1aXMuaW5mbz4KPiBIaSwgdGhpcyBpcyB5b3VyIExpbnV4IGtl
cm5lbCByZWdyZXNzaW9uIHRyYWNrZXIuIFRvcC1wb3N0aW5nIGZvciBvbmNlLAo+IHRvIG1ha2Ug
dGhpcyBlYXNpbHkgYWNjZXNzaWJsZSB0byBldmVyeW9uZS4KPiAKPiBaaGVuIExlaSwgUmljaGFy
ZCwgd2hhdCdzIHVwIGhlcmU/IEJlbG93IHJlZ3Jlc3Npb24gcmVwb3J0IGlzIG1vcmUgdGhhbgo+
IHR3byB3ZWVrcyBvbGQgbm93IGFuZCBhZmFpY3MgZGlkbid0IGV2ZW4gZ2V0IGEgc2luZ2xlIHJl
cGx5LgoKU29ycnksIGJ1dCBVTUwgaXMgbGVpc3VyZSBwdXJzdWl0LCBzbyBJIGNhbiBvbmx5IHdv
cmsgb24gaXQgd2hlbiBteQpzY2hlZHVsZSBwZXJtaXRzIGl0LgogCj4gQ2lhbywgVGhvcnN0ZW4g
KHdlYXJpbmcgaGlzICd0aGUgTGludXgga2VybmVsJ3MgcmVncmVzc2lvbiB0cmFja2VyJyBoYXQp
Cj4gCj4gUC5TLjogQXMgdGhlIExpbnV4IGtlcm5lbCdzIHJlZ3Jlc3Npb24gdHJhY2tlciBJJ20g
Z2V0dGluZyBhIGxvdCBvZgo+IHJlcG9ydHMgb24gbXkgdGFibGUuIEkgY2FuIG9ubHkgbG9vayBi
cmllZmx5IGludG8gbW9zdCBvZiB0aGVtIGFuZCBsYWNrCj4ga25vd2xlZGdlIGFib3V0IG1vc3Qg
b2YgdGhlIGFyZWFzIHRoZXkgY29uY2Vybi4gSSB0aHVzIHVuZm9ydHVuYXRlbHkKPiB3aWxsIHNv
bWV0aW1lcyBnZXQgdGhpbmdzIHdyb25nIG9yIG1pc3Mgc29tZXRoaW5nIGltcG9ydGFudC4gSSBo
b3BlCj4gdGhhdCdzIG5vdCB0aGUgY2FzZSBoZXJlOyBpZiB5b3UgdGhpbmsgaXQgaXMsIGRvbid0
IGhlc2l0YXRlIHRvIHRlbGwgbWUKPiBpbiBhIHB1YmxpYyByZXBseSwgaXQncyBpbiBldmVyeW9u
ZSdzIGludGVyZXN0IHRvIHNldCB0aGUgcHVibGljIHJlY29yZAo+IHN0cmFpZ2h0Lgo+IAo+IAo+
IAo+IE9uIDIzLjAzLjIyIDIwOjQxLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToKClsuLi5dCgo+
PiBpbiBjYXNlIGl0IGhlbHBzLiBJIGFtIGhhcHB5IHRvIHByb3ZpZGUgbW9yZSBpbmZvcm1hdGlv
biBvciB0ZXN0IHBhdGNoZXMKPj4gYXMgbmVjZXNzYXJ5LgoKTmF0aGFuLCBjYW4geW91IHByb3Zp
ZGUgbWUgdGhlIGVycm9yIGNvZGUgZnJvbSBvc19zZXRfZmRfYmxvY2soKT8KTXkgYmVzdCBndWVz
cyBpcyB0aGF0IHNldHRpbmcgdGhlIGZkIGlzIG9wdGlvbmFsIGhlcmUgYW5kIFVNTCBkb2VzCm5v
dCBleHBlY3QgZmFpbHVyZSBoZXJlLgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K

