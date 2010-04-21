Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <xiyou.wangcong@gmail.com>) id 1O4T1j-0001PN-Nb
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 06:03:11 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O4T1i-0007Up-P9 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2010 06:03:11 +0000
Received: by pwj5 with SMTP id 5so4286707pwj.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 20 Apr 2010 23:03:05 -0700 (PDT)
Date: Wed, 21 Apr 2010 14:06:51 +0800
From: Amerigo Wang <xiyou.wangcong@gmail.com>
Message-ID: <20100421060651.GB4467@cr0.nay.redhat.com>
References: <cover.1271713955.git.jan.kiszka@web.de>
	<1d97cd7761a1eae73923b1adda4c6915a0647bb3.1271713955.git.jan.kiszka@web.de>
	<20100420100949.GB5317@cr0.nay.redhat.com>
	<20100420143016.GB30011@c-98-229-117-200.hsd1.ma.comcast.net>
	<4BCDDFBB.40805@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4BCDDFBB.40805@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Jeff Dike <jdike@addtoit.com>, trivial@kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

T24gVHVlLCBBcHIgMjAsIDIwMTAgYXQgMDc6MDk6MTVQTSArMDIwMCwgSmFuIEtpc3prYSB3cm90
ZToKPkplZmYgRGlrZSB3cm90ZToKPj4gT24gVHVlLCBBcHIgMjAsIDIwMTAgYXQgMDY6MDk6NDlQ
TSArMDgwMCwgQW1lcmlnbyBXYW5nIHdyb3RlOgo+Pj4gT24gTW9uLCBBcHIgMTksIDIwMTAgYXQg
MTE6NTM6MDZQTSArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToKPj4+PiBXZSBjYW4ndCBwdWxsIGlu
IGxpbnV4L3NjaGVkLmgsIHNvIGp1c3QgZGVjbGFyZSB0aGUgc3RydWN0Lgo+Pj4+Cj4+PiBEaWQg
eW91IG1lZXQgYW55IGJ1aWxkIGVycm9yPyBJZiB5ZXMsIHBsZWFzZSBpbmNsdWRlIGl0Lgo+PiAK
Pj4gV2hhdCBkb2VzIHRoaXMgcGF0Y2ggZml4LCBhc2lkZSBmcm9tIGJlaW5nIGEgYml0IGNsZWFu
ZXI/Cj4KPiAgQ0MgICAgICBhcmNoL3VtL3N5cy1pMzg2L2VsZmNvcmUubwo+SW4gZmlsZSBpbmNs
dWRlZCBmcm9tIC9kYXRhL2xpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L2VsZi5oOjgsCj4gICAgICAg
ICAgICAgICAgIGZyb20gL2RhdGEvbGludXgtMi42L2FyY2gvdW0vc3lzLWkzODYvZWxmY29yZS5j
OjI6Cj4vZGF0YS9saW51eC0yLjYvYXJjaC91bS9zeXMtaTM4Ni9hc20vZWxmLmg6Nzg6IHdhcm5p
bmc6IOKAmHN0cnVjdCB0YXNrX3N0cnVjdOKAmSBkZWNsYXJlZCBpbnNpZGUgcGFyYW1ldGVyIGxp
c3QKPi9kYXRhL2xpbnV4LTIuNi9hcmNoL3VtL3N5cy1pMzg2L2FzbS9lbGYuaDo3ODogd2Fybmlu
ZzogaXRzIHNjb3BlIGlzIG9ubHkgdGhpcyBkZWZpbml0aW9uIG9yIGRlY2xhcmF0aW9uLCB3aGlj
aCBpcyBwcm9iYWJseSBub3Qgd2hhdCB5b3Ugd2FudAo+Cj5JIGd1ZXNzIG5vdCBtYW55IHBlb3Bs
ZSBidWlsZCBhZ2FpbnN0IGkzODYgaG9zdHMgYW55bW9yZSwgc28gdGhpcwo+cmVtYWluZWQgd2lk
ZWx5IHVubm90aWNlZC4KPgo+PiAKPj4gSWYgaXQgYnVpbHQgYmVmb3JlLCB3aXRob3V0IGhhdmlu
ZyBhIHRhc2tfc3RydWN0IGRlY2xhcmF0aW9uLCBJIHRoaW5rCj4+IHRoYXQgbWVhbnMgdGhhdCB0
aGUgZWxmX2NvcmVfY29weV9mcHJlZ3Mgd2FzIG5ldmVyIHVzZWQuICBUaGUKPj4gdGFza19zdHJ1
Y3QgKiBpbiB0aGUgZGVjbGFyYXRpb24gd291bGQgYmVjb21lIGEgcHJpdmF0ZSB0YXNrX3N0cnVj
dCwKPj4ga25vd24gb25seSB0byB0aGUgZGVjbGFyYXRpb24uICBJZiB0aGUgaW1wbGVtZW50YXRp
b24gb3IgY2FsbGVycyBoYXZlCj4+IHRoZSByZWd1bGFyIHRhc2tfc3RydWN0LCBpdCB3aWxsIGJl
IGEgZGlmZmVyZW50IG9uZSwgYW5kIHRoZQo+PiBwcm90b3R5cGVzIHdpbGwgY29uZmxpY3QgZHVl
IHRvIHRoZSBkaWZmZXJlbnQgdHlwZXMgb2YgdGhlIGZpcnN0Cj4+IHBhcmFtZXRlci4KPgo+VGhp
cyBpcyBqdXN0IGEgZm9yd2FyZCBkZWNsYXJhdGlvbiAodGhhdCBtYW55IGFyY2ggZWxmIGhlYWRl
ciBpbmNsdWRlKSwKPnNvIG5vIHN1Y2ggcHJvYmxlbSBleGlzdHMuCj4KPkJUVywgdG8gYW5zd2Vy
IHRoZSBvdGhlciBxdWVzdGlvbiBpbiB0aGlzIHRocmVhZDogV2UgaGF2ZSBhIGNpcmN1bGFyCj5k
ZXBlbmRlbmN5IHRoYXQgcHJldmVudHMgaW5jbHVkaW5nIHNjaGVkLmguCiBeXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eClRoaXMgaXMgdGhlIHJpZ2h0IHJlYXNvbiB0
byBkbyB0aGlzLiBPayB0aGVuLCB0aGFua3MuCgpCdXQgaXQgbG9va3MgbGlrZSB4ODZfNjQgbmVl
ZHMgdGhpcyB0b28uCgoKQlRXLCBJIGRvbid0IHRoaW5rIGNvbXBpbGUgd2FybmluZyBmaXhlcyBh
cmUgdHJpdmlhbCBlbm91Z2ggdG8gZ28KdG8gdHJpdmlhbEBrZXJuZWwub3JnLgoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRl
dmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9s
aXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK

