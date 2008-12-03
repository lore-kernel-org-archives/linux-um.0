Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1L7qtl-0004oa-VL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 12:32:09 +0000
Received: from rv-out-0708.google.com ([209.85.198.241])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L7qtj-0007eu-CI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Dec 2008 12:32:09 +0000
Received: by rv-out-0708.google.com with SMTP id f25so3325868rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Dec 2008 04:32:05 -0800 (PST)
Message-ID: <2375c9f90812030432m771984edkdd0c599bbae9bb3c@mail.gmail.com>
Date: Wed, 3 Dec 2008 12:32:02 +0000
From: "=?UTF-8?Q?Am=C3=A9rico_Wang?=" <xiyou.wangcong@gmail.com>
In-Reply-To: <20081203012051.GA8953@cmpxchg.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <2375c9f90812021451hfd77292yf2463ca99d07b88e@mail.gmail.com>
	<20081203012051.GA8953@cmpxchg.org>
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

T24gV2VkLCBEZWMgMywgMjAwOCBhdCAxOjIwIEFNLCBKb2hhbm5lcyBXZWluZXIgPGhhbm5lc0Bj
bXB4Y2hnLm9yZz4gd3JvdGU6Cj4gT24gVHVlLCBEZWMgMDIsIDIwMDggYXQgMTA6NTE6MDlQTSAr
MDAwMCwgQW3DqXJpY28gV2FuZyB3cm90ZToKPj4gVU1MIGltcGxlbWVudGF0aW9uIG9mIGtlcm5l
bF9leGVjdmUoKSBzaG91bGQgbm90IGhhdmUgY29uc3QgcXVhbGlmaWVyLAo+PiBiZWNhdXNlIGl0
IHdpbGwgZmluYWxseSBjYWxsIGRvX2V4ZWN2ZSgpIHdoaWNoIGRvZXNuJ3QgaGF2ZS4KPgo+IEFu
ZCB5b3UgbWFkZSBzdXJlIHRoYXQgZG9fZXhlY3ZlKCkgaXMgY29ycmVjdGx5IGFubm90YXRlZD8K
PgoKWWVzLCBJIGNoZWNrZWQgdGhhdC4KClRoYW5rcy4KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNG
Lk5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIE1vYmxpbiBZb3VyIE1vdmUgRGV2ZWxvcGVy
J3MgY2hhbGxlbmdlCkJ1aWxkIHRoZSBjb29sZXN0IExpbnV4IGJhc2VkIGFwcGxpY2F0aW9ucyB3
aXRoIE1vYmxpbiBTREsgJiB3aW4gZ3JlYXQgcHJpemVzCkdyYW5kIHByaXplIGlzIGEgdHJpcCBm
b3IgdHdvIHRvIGFuIE9wZW4gU291cmNlIGV2ZW50IGFueXdoZXJlIGluIHRoZSB3b3JsZApodHRw
Oi8vbW9ibGluLWNvbnRlc3Qub3JnL3JlZGlyZWN0LnBocD9iYW5uZXJfaWQ9MTAwJnVybD0vCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1s
aW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91
c2VyLW1vZGUtbGludXgtZGV2ZWwK
