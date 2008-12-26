Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1LG93O-00083g-TT
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Dec 2008 09:32:22 +0000
Received: from ti-out-0910.google.com ([209.85.142.191])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LG93J-0002Ll-An for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Dec 2008 09:32:23 +0000
Received: by ti-out-0910.google.com with SMTP id y6so3198591tia.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 26 Dec 2008 01:32:14 -0800 (PST)
Message-ID: <2375c9f90812260132h6b4b5f94g404f628ec4b74afd@mail.gmail.com>
Date: Fri, 26 Dec 2008 09:32:13 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
In-Reply-To: <20081207195537.GA24808@cmpxchg.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
	<20081203012051.GA8953@cmpxchg.org>
	<2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
	<20081203134035.GA17560@cmpxchg.org>
	<2375c9f90812051702m217ee049i79ce2f9cc8280fb1@mail.gmail.com>
	<20081207195537.GA24808@cmpxchg.org>
Subject: Re: [uml-devel] [Patch] uml: drop const qualifier for kernel_execve()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

T24gU3VuLCBEZWMgNywgMjAwOCBhdCA3OjU1IFBNLCBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz4gd3JvdGU6Cj4gT24gU2F0LCBEZWMgMDYsIDIwMDggYXQgMDE6MDI6MTZBTSAr
MDAwMCwgQW3DqXJpY28gV2FuZyB3cm90ZToKPj4gT24gV2VkLCBEZWMgMywgMjAwOCBhdCAxOjQw
IFBNLCBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4gd3JvdGU6Cj4+ID4gT24g
V2VkLCBEZWMgMDMsIDIwMDggYXQgMTI6MzI6MDJQTSArMDAwMCwgQW3DqXJpY28gV2FuZyB3cm90
ZToKPj4gPj4gT24gV2VkLCBEZWMgMywgMjAwOCBhdCAxOjIwIEFNLCBKb2hhbm5lcyBXZWluZXIg
PGhhbm5lc0BjbXB4Y2hnLm9yZz4gd3JvdGU6Cj4+ID4+ID4gT24gVHVlLCBEZWMgMDIsIDIwMDgg
YXQgMTA6NTE6MDlQTSArMDAwMCwgQW3DqXJpY28gV2FuZyB3cm90ZToKPj4gPj4gPj4gVU1MIGlt
cGxlbWVudGF0aW9uIG9mIGtlcm5lbF9leGVjdmUoKSBzaG91bGQgbm90IGhhdmUgY29uc3QgcXVh
bGlmaWVyLAo+PiA+PiA+PiBiZWNhdXNlIGl0IHdpbGwgZmluYWxseSBjYWxsIGRvX2V4ZWN2ZSgp
IHdoaWNoIGRvZXNuJ3QgaGF2ZS4KPj4gPj4gPgo+PiA+PiA+IEFuZCB5b3UgbWFkZSBzdXJlIHRo
YXQgZG9fZXhlY3ZlKCkgaXMgY29ycmVjdGx5IGFubm90YXRlZD8KPj4gPj4gPgo+PiA+Pgo+PiA+
PiBZZXMsIEkgY2hlY2tlZCB0aGF0Lgo+PiA+Cj4+ID4gR29vZC4gIFRoZW4gcGxlYXNlIGZpeCB1
cCBkb19leGVjdmUoKSBvciBsZXQgdGhlIHdhcm5pbmcgc3RhbmQgb3V0IGFzCj4+ID4gYSByZW1p
bmRlci4KPj4KPj4gPz8KPj4gQ29uZnVzZWQuLi4KPj4KPj4gZG9fZXhlY3ZlKCkgaXMgT0ssIHdl
IGRvbid0IG5lZWQgdG8gZml4IGl0Lgo+Cj4gSSBkb24ndCBzZWUgd2hlcmUgaXQgd3JpdGVzIHRo
cm91Z2ggQGZpbGVuYW1lLiAgU28gaXQgc2VlbXMgdGhlIHJpZ2h0Cj4gZml4IHdvdWxkIGJlIHRv
IG1ha2UgZG9fZXhlY3ZlKClzIHBhcmFtZXRlciBjb25zdCAoYW5kIGFzIGl0IHNlZW1zLCBhCj4g
bG90IG1vcmUgYWRqdXN0bWVudHMgZG93biB0aGlzIGNhbGwgZ3JhcGgpIGFuZCBub3QgcmVtb3Zl
IGEgY29ycmVjdAo+IGNvbnN0IGZyb20gYSBjYWxsc2l0ZS4KCkhlbGxvLCBKb2hhbm5lcy4KCkkg
YXBvbG9naXplIGZvciBteSBsYXRlIHJlcGx5LgoKV2VsbCwgbm90IG9ubHkgQGZpbGVuYW1lLCBi
dXQgYWxzbyB0aGUgbmV4dCB0d28gcGFyYW1ldGVycywgYnV0IGlmIHlvdSBhbHNvCm1ha2UgdGhl
bSBjb25zdCBpbiBkb19leGVjdmUoKSwgeW91IHdpbGwgZ2V0IG1vcmUgd2FybmluZ3MuIDopClNv
IEkgdGhpbmsgbXkgcGF0Y2ggaXMgY29ycmVjdC4KClRoYW5rcyBmb3IgeW91ciByZXZpZXcuCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1s
aW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
