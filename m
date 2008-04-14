Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JlQFb-0000ik-HM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 08:05:43 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JlQEM-0004j2-2E
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Apr 2008 08:05:38 -0700
Date: Mon, 14 Apr 2008 11:03:58 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080414150358.GD7186@c2.user-mode-linux.org>
References: <20080412.174733.133433510.xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080412.174733.133433510.xiyou.wangcong@gmail.com>
Subject: Re: [uml-devel] [Patch] uml: compile error fix
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
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

T24gU2F0LCBBcHIgMTIsIDIwMDggYXQgMDU6NDc6MzNQTSArMDgwMCwgV0FORyBDb25nIHdyb3Rl
Ogo+IAo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhpcyBlcnJvcjoKPiAKPiAgIENDICAgICAgYXJjaC91
bS9rZXJuZWwvc21wLm8KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL2hvbWUvd2FuZ2NvbmcvcHJv
amVjdHMvbGludXgtMi42L2FyY2gvdW0va2VybmVsL3NtcC5jOjk6Cj4gaW5jbHVkZTIvYXNtL3Rs
Yi5oOiBJbiBmdW5jdGlvbiDigJh0bGJfcmVtb3ZlX3BhZ2XigJk6Cj4gaW5jbHVkZTIvYXNtL3Rs
Yi5oOjEwMTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmHBhZ2Vf
Y2FjaGVfcmVsZWFzZeKAmQo+IG1ha2VbMl06ICoqKiBbYXJjaC91bS9rZXJuZWwvc21wLm9dIEVy
cm9yIDEKPiBtYWtlWzFdOiAqKiogW2FyY2gvdW0va2VybmVsXSBFcnJvciAyCj4gbWFrZTogKioq
IFtzdWItbWFrZV0gRXJyb3IgMgo+IAo+IEFuZCBzaW5jZSBpbmNsdWRpbmcgPGxpbnV4L3BhZ2Vt
YXAuaD4gaW4gPGxpbnV4L3N3YXAuaD4gd2lsbCBicmVhayBzcGFyYywKPiB3ZSBhZGQgdGhpcyAj
aW5jbHVkZSBpbiB1bWwncyBvd24gaGVhZGVyLgoKU2lnaCwgQUNLLgoKSSB0b29rIGEgc3RhYiBh
dCBmaXhpbmcgdGhpcyBwcm9ibGVtIGZvciByZWFsIGEgd2hpbGUgYWdvIGJ5CnVudGFuZ2xpbmcg
dGhlIGhlYWRlcnMgaW52b2x2ZWQsIGJ1dCBmYWlsZWQuCgoJICAgICAgIAkgICAgICAgCQkgSmVm
ZgoKLS0gCldvcmsgZW1haWwgLSBqZGlrZSBhdCBsaW51eCBkb3QgaW50ZWwgZG90IGNvbQoKLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIDIwMDgg
SmF2YU9uZShTTSkgQ29uZmVyZW5jZSAKRG9uJ3QgbWlzcyB0aGlzIHllYXIncyBleGNpdGluZyBl
dmVudC4gVGhlcmUncyBzdGlsbCB0aW1lIHRvIHNhdmUgJDEwMC4gClVzZSBwcmlvcml0eSBjb2Rl
IEo4VEwyRDIuIApodHRwOi8vYWQuZG91YmxlY2xpY2submV0L2NsazsxOTg3NTc2NzM7MTM1MDMw
Mzg7cD9odHRwOi8vamF2YS5zdW4uY29tL2phdmFvbmUKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlz
dApVc2VyLW1vZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
