Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <keescook@google.com>) id 1bMmya-0001ru-Ah
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 01:59:08 +0000
Received: from mail-wm0-f42.google.com ([74.125.82.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bMmyZ-0003jd-GU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 01:59:08 +0000
Received: by mail-wm0-f42.google.com with SMTP id i5so5290659wmg.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Jul 2016 18:59:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468274222-31726-1-git-send-email-mic@digikod.net>
References: <1468274222-31726-1-git-send-email-mic@digikod.net>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 11 Jul 2016 21:59:00 -0400
Message-ID: <CAGXu5jLBdhuG1G0xLJk5=XrdT4Vd6ac88_Pz3QKksn5SVPFAxQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH v1 0/3] Fix seccomp for UM (next)
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
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, James Morris <jmorris@namei.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Olof Johansson <olof@lixom.net>

T24gTW9uLCBKdWwgMTEsIDIwMTYgYXQgNTo1NiBQTSwgTWlja2HDq2wgU2FsYcO8biA8bWljQGRp
Z2lrb2QubmV0PiB3cm90ZToKPiBIaSwKPgo+IFRoaXMgc2VyaWVzIGZpeCB0aGUgcmVjZW50IHNl
Y2NvbXAgdXBkYXRlIGZvciB0aGUgVXNlci1tb2RlIExpbnV4IGFyY2hpdGVjdHVyZQo+ICgzMi1i
aXQgYW5kIDY0LWJpdCkgc2luY2UgY29tbWl0IDI2NzAzYzYzNmMxZjMyNzJiMzliZDBmNmQwNGQy
ZTk3MDk4NGYxYjYKPiAoY2xvc2UgdGhlIGhvbGUgd2hlcmUgcHRyYWNlIGNhbiBjaGFuZ2UgYSBz
eXNjYWxsIG91dCBmcm9tIHVuZGVyIHNlY2NvbXApLgo+Cj4gUmVnYXJkcywKPgo+IE1pY2thw6ts
IFNhbGHDvG4gKDMpOgo+ICAgdW0vcHRyYWNlOiBGaXggdGhlIHN5c2NhbGxfdHJhY2VfbGVhdmUg
Y2FsbAo+ICAgdW0vcHRyYWNlOiBGaXggdGhlIHN5c2NhbGwgbnVtYmVyIHVwZGF0ZSBhZnRlciBh
IHB0cmFjZQo+ICAgc2VjY29tcDogUmVtb3ZlIDItcGhhc2UgQVBJIGRvY3VtZW50YXRpb24KPgo+
ICBhcmNoL0tjb25maWcgICAgICAgICAgICAgICAgICB8IDExIC0tLS0tLS0tLS0tCj4gIGFyY2gv
dW0va2VybmVsL3NrYXMvc3lzY2FsbC5jIHwgMTAgKysrLS0tLS0tLQo+ICBhcmNoL3g4Ni91bS9w
dHJhY2VfMzIuYyAgICAgICB8ICAzICsrKwo+ICBhcmNoL3g4Ni91bS9wdHJhY2VfNjQuYyAgICAg
ICB8ICA0ICsrKysKPiAgNCBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxOCBkZWxl
dGlvbnMoLSkKCkFoLCBwZXJmZWN0ISBUaGFua3MgZm9yIGZpeGluZyB0aGlzISBKYW1lcywgY2Fu
IHlvdSBwaWNrIHRoaXMgdXAgZm9yIC1uZXh0PwoKQWNrZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nv
b2tAY2hyb21pdW0ub3JnPgoKLUtlZXMKCi0tIApLZWVzIENvb2sKQ2hyb21lIE9TICYgQnJpbGxv
IFNlY3VyaXR5CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KV2hhdCBOZXRGbG93IEFuYWx5emVyIGNh
biBkbyBmb3IgeW91PyBNb25pdG9ycyBuZXR3b3JrIGJhbmR3aWR0aCBhbmQgdHJhZmZpYwpwYXR0
ZXJucyBhdCBhbiBpbnRlcmZhY2UtbGV2ZWwuIFJldmVhbHMgd2hpY2ggdXNlcnMsIGFwcHMsIGFu
ZCBwcm90b2NvbHMgYXJlIApjb25zdW1pbmcgdGhlIG1vc3QgYmFuZHdpZHRoLiBQcm92aWRlcyBt
dWx0aS12ZW5kb3Igc3VwcG9ydCBmb3IgTmV0RmxvdywgCkotRmxvdywgc0Zsb3cgYW5kIG90aGVy
IGZsb3dzLiBNYWtlIGluZm9ybWVkIGRlY2lzaW9ucyB1c2luZyBjYXBhY2l0eSBwbGFubmluZwpy
ZXBvcnRzLmh0dHA6Ly9zZG0ubGluay96b2hvZGV2MmRldgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBs
aXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVs
Cg==

