Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L8lYt-0001RX-Dp
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 01:02:23 +0000
Received: from ti-out-0910.google.com ([209.85.142.186])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L8lYp-0003JD-QC for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Dec 2008 01:02:23 +0000
Received: by ti-out-0910.google.com with SMTP id y6so177448tia.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 05 Dec 2008 17:02:17 -0800 (PST)
Message-ID: <2375c9f90812051702m217ee049i79ce2f9cc8280fb1@mail.gmail.com>
Date: Sat, 6 Dec 2008 01:02:16 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
In-Reply-To: <20081203134035.GA17560@cmpxchg.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
	<20081203012051.GA8953@cmpxchg.org>
	<2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
	<20081203134035.GA17560@cmpxchg.org>
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

T24gV2VkLCBEZWMgMywgMjAwOCBhdCAxOjQwIFBNLCBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz4gd3JvdGU6Cj4gT24gV2VkLCBEZWMgMDMsIDIwMDggYXQgMTI6MzI6MDJQTSAr
MDAwMCwgQW3DqXJpY28gV2FuZyB3cm90ZToKPj4gT24gV2VkLCBEZWMgMywgMjAwOCBhdCAxOjIw
IEFNLCBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0BjbXB4Y2hnLm9yZz4gd3JvdGU6Cj4+ID4gT24g
VHVlLCBEZWMgMDIsIDIwMDggYXQgMTA6NTE6MDlQTSArMDAwMCwgQW3DqXJpY28gV2FuZyB3cm90
ZToKPj4gPj4gVU1MIGltcGxlbWVudGF0aW9uIG9mIGtlcm5lbF9leGVjdmUoKSBzaG91bGQgbm90
IGhhdmUgY29uc3QgcXVhbGlmaWVyLAo+PiA+PiBiZWNhdXNlIGl0IHdpbGwgZmluYWxseSBjYWxs
IGRvX2V4ZWN2ZSgpIHdoaWNoIGRvZXNuJ3QgaGF2ZS4KPj4gPgo+PiA+IEFuZCB5b3UgbWFkZSBz
dXJlIHRoYXQgZG9fZXhlY3ZlKCkgaXMgY29ycmVjdGx5IGFubm90YXRlZD8KPj4gPgo+Pgo+PiBZ
ZXMsIEkgY2hlY2tlZCB0aGF0Lgo+Cj4gR29vZC4gIFRoZW4gcGxlYXNlIGZpeCB1cCBkb19leGVj
dmUoKSBvciBsZXQgdGhlIHdhcm5pbmcgc3RhbmQgb3V0IGFzCj4gYSByZW1pbmRlci4KCj8/CkNv
bmZ1c2VkLi4uCgpkb19leGVjdmUoKSBpcyBPSywgd2UgZG9uJ3QgbmVlZCB0byBmaXggaXQuCgpU
aGFua3MuCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTRi5OZXQgZW1haWwgaXMgU3BvbnNvcmVkIGJ5
IE1JWDA5LCBNYXJjaCAxOC0yMCwgMjAwOSBpbiBMYXMgVmVnYXMsIE5ldmFkYS4KVGhlIGZ1dHVy
ZSBvZiB0aGUgd2ViIGNhbid0IGhhcHBlbiB3aXRob3V0IHlvdS4gIEpvaW4gdXMgYXQgTUlYMDkg
dG8gaGVscApwYXZlIHRoZSB3YXkgdG8gdGhlIE5leHQgV2ViIG5vdy4gTGVhcm4gbW9yZSBhbmQg
cmVnaXN0ZXIgYXQKaHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MjA4NjY5NDM4OzEzNTAz
MDM4O2k/aHR0cDovLzIwMDkudmlzaXRtaXguY29tLwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0
ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==
