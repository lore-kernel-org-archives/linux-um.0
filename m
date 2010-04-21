Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jkosina@suse.cz>) id 1O4WOd-0003Kw-BS
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 09:39:03 +0000
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4WOc-0004I1-0t for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 09:39:03 +0000
Date: Wed, 21 Apr 2010 11:38:53 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
In-Reply-To: <20100421060651.GB4467@cr0.nay.redhat.com>
Message-ID: <alpine.LNX.2.00.1004211138320.7579@pobox.suse.cz>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<1d97cd7761a1eae73923b1adda4c6915a0647bb3.1271713955.git.jan.kiszka@web.de>
	<20100420100949.GB5317@cr0.nay.redhat.com>
	<20100420143016.GB30011@c-98-229-117-200.hsd1.ma.comcast.net>
	<4BCDDFBB.40805@web.de> <20100421060651.GB4467@cr0.nay.redhat.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 3/5] uml: Fix warning due to missing
 task_struct declaration
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
To: Amerigo Wang <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Jan Kiszka <jan.kiszka@web.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

T24gV2VkLCAyMSBBcHIgMjAxMCwgQW1lcmlnbyBXYW5nIHdyb3RlOgoKPiA+ICBDQyAgICAgIGFy
Y2gvdW0vc3lzLWkzODYvZWxmY29yZS5vCj4gPkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvZGF0YS9s
aW51eC0yLjYvaW5jbHVkZS9saW51eC9lbGYuaDo4LAo+ID4gICAgICAgICAgICAgICAgIGZyb20g
L2RhdGEvbGludXgtMi42L2FyY2gvdW0vc3lzLWkzODYvZWxmY29yZS5jOjI6Cj4gPi9kYXRhL2xp
bnV4LTIuNi9hcmNoL3VtL3N5cy1pMzg2L2FzbS9lbGYuaDo3ODogd2FybmluZzog4oCYc3RydWN0
IHRhc2tfc3RydWN04oCZIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdAo+ID4vZGF0YS9s
aW51eC0yLjYvYXJjaC91bS9zeXMtaTM4Ni9hc20vZWxmLmg6Nzg6IHdhcm5pbmc6IGl0cyBzY29w
ZSBpcyBvbmx5IHRoaXMgZGVmaW5pdGlvbiBvciBkZWNsYXJhdGlvbiwgd2hpY2ggaXMgcHJvYmFi
bHkgbm90IHdoYXQgeW91IHdhbnQKPiA+Cj4gPkkgZ3Vlc3Mgbm90IG1hbnkgcGVvcGxlIGJ1aWxk
IGFnYWluc3QgaTM4NiBob3N0cyBhbnltb3JlLCBzbyB0aGlzCj4gPnJlbWFpbmVkIHdpZGVseSB1
bm5vdGljZWQuCj4gPgo+ID4+IAo+ID4+IElmIGl0IGJ1aWx0IGJlZm9yZSwgd2l0aG91dCBoYXZp
bmcgYSB0YXNrX3N0cnVjdCBkZWNsYXJhdGlvbiwgSSB0aGluawo+ID4+IHRoYXQgbWVhbnMgdGhh
dCB0aGUgZWxmX2NvcmVfY29weV9mcHJlZ3Mgd2FzIG5ldmVyIHVzZWQuICBUaGUKPiA+PiB0YXNr
X3N0cnVjdCAqIGluIHRoZSBkZWNsYXJhdGlvbiB3b3VsZCBiZWNvbWUgYSBwcml2YXRlIHRhc2tf
c3RydWN0LAo+ID4+IGtub3duIG9ubHkgdG8gdGhlIGRlY2xhcmF0aW9uLiAgSWYgdGhlIGltcGxl
bWVudGF0aW9uIG9yIGNhbGxlcnMgaGF2ZQo+ID4+IHRoZSByZWd1bGFyIHRhc2tfc3RydWN0LCBp
dCB3aWxsIGJlIGEgZGlmZmVyZW50IG9uZSwgYW5kIHRoZQo+ID4+IHByb3RvdHlwZXMgd2lsbCBj
b25mbGljdCBkdWUgdG8gdGhlIGRpZmZlcmVudCB0eXBlcyBvZiB0aGUgZmlyc3QKPiA+PiBwYXJh
bWV0ZXIuCj4gPgo+ID5UaGlzIGlzIGp1c3QgYSBmb3J3YXJkIGRlY2xhcmF0aW9uICh0aGF0IG1h
bnkgYXJjaCBlbGYgaGVhZGVyIGluY2x1ZGUpLAo+ID5zbyBubyBzdWNoIHByb2JsZW0gZXhpc3Rz
Lgo+ID4KPiA+QlRXLCB0byBhbnN3ZXIgdGhlIG90aGVyIHF1ZXN0aW9uIGluIHRoaXMgdGhyZWFk
OiBXZSBoYXZlIGEgY2lyY3VsYXIKPiA+ZGVwZW5kZW5jeSB0aGF0IHByZXZlbnRzIGluY2x1ZGlu
ZyBzY2hlZC5oLgo+ICBeXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5e
Cj4gVGhpcyBpcyB0aGUgcmlnaHQgcmVhc29uIHRvIGRvIHRoaXMuIE9rIHRoZW4sIHRoYW5rcy4K
PiAKPiBCdXQgaXQgbG9va3MgbGlrZSB4ODZfNjQgbmVlZHMgdGhpcyB0b28uCj4gCj4gCj4gQlRX
LCBJIGRvbid0IHRoaW5rIGNvbXBpbGUgd2FybmluZyBmaXhlcyBhcmUgdHJpdmlhbCBlbm91Z2gg
dG8gZ28KPiB0byB0cml2aWFsQGtlcm5lbC5vcmcuCgpXaHk/CgotLSAKSmlyaSBLb3NpbmEKU1VT
RSBMYWJzLCBOb3ZlbGwgSW5jLgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBt
YWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGlu
dXgtZGV2ZWwK

