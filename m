Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLgZb-0007l7-LL for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 08:48:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KLgZZ-00052v-6I
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 08:48:14 -0700
Date: Wed, 23 Jul 2008 11:48:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080723154801.GB15682@c2.user-mode-linux.org>
References: <20080722174152.GF3081@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080722174152.GF3081@hack.voiplan.pt>
Subject: Re: [uml-devel] [Patch] uml: fix another build error
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

T24gVHVlLCBKdWwgMjIsIDIwMDggYXQgMDY6NDE6NTJQTSArMDEwMCwgV0FORyBDb25nIHdyb3Rl
Ogo+IAo+IEZpeGVkIHRoaXMgZXJyb3I6Cj4gCj4gICBDQyAgICAgIGFyY2gvdW0vZHJpdmVycy92
ZGVfdXNlci5vCj4gICAvaG9tZS93YW5nY29uZy9Qcm9qZWN0cy9saW51eC0yLjYvYXJjaC91bS9k
cml2ZXJzL3ZkZV91c2VyLmM6IEluCj4gZnVuY3Rpb24g4oCYdmRlX2luaXRfbGlic3R1ZmbigJk6
Cj4gL2hvbWUvd2FuZ2NvbmcvUHJvamVjdHMvbGludXgtMi42L2FyY2gvdW0vZHJpdmVycy92ZGVf
dXNlci5jOjgxOgo+IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJhr
bWFsbG9j4oCZCj4gL2hvbWUvd2FuZ2NvbmcvUHJvamVjdHMvbGludXgtMi42L2FyY2gvdW0vZHJp
dmVycy92ZGVfdXNlci5jOjgxOgo+IHdhcm5pbmc6IGFzc2lnbm1lbnQgbWFrZXMgcG9pbnRlciBm
cm9tIGludGVnZXIgd2l0aG91dCBhIGNhc3QKPiBtYWtlWzJdOiAqKiogW2FyY2gvdW0vZHJpdmVy
cy92ZGVfdXNlci5vXSBFcnJvciAxCj4gbWFrZVsxXTogKioqIFthcmNoL3VtL2RyaXZlcnMvdmRl
X3VzZXIua29dIEVycm9yIDIKPiBtYWtlOiAqKiogW3N1Yi1tYWtlXSBFcnJvciAyCgpUaGFua3Mg
LSBhZGRlZCB0byB0aGUgcXVldWUuCgogICAgICAgCSAgICAgICAJICBKZWZmCgotLSAKV29yayBl
bWFpbCAtIGpkaWtlIGF0IGxpbnV4IGRvdCBpbnRlbCBkb3QgY29tCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClRoaXMgU0YuTmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieSB0aGUgTW9ibGluIFlvdXIgTW92ZSBE
ZXZlbG9wZXIncyBjaGFsbGVuZ2UKQnVpbGQgdGhlIGNvb2xlc3QgTGludXggYmFzZWQgYXBwbGlj
YXRpb25zIHdpdGggTW9ibGluIFNESyAmIHdpbiBncmVhdCBwcml6ZXMKR3JhbmQgcHJpemUgaXMg
YSB0cmlwIGZvciB0d28gdG8gYW4gT3BlbiBTb3VyY2UgZXZlbnQgYW55d2hlcmUgaW4gdGhlIHdv
cmxkCmh0dHA6Ly9tb2JsaW4tY29udGVzdC5vcmcvcmVkaXJlY3QucGhwP2Jhbm5lcl9pZD0xMDAm
dXJsPS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVXNl
ci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlz
dHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xp
c3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
