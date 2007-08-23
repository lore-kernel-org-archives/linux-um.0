Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IO1mt-0003FR-Ng for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 18:47:08 -0700
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IO1mt-0004Ik-B4
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Aug 2007 18:47:07 -0700
From: Rob Landley <rob@landley.net>
Date: Wed, 22 Aug 2007 20:47:01 -0500
References: <200708212148.05392.rob@landley.net>
	<200708221626.53510.rob@landley.net>
	<20070822213115.GB14287@c2.user-mode-linux.org>
In-Reply-To: <20070822213115.GB14287@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200708222047.01962.rob@landley.net>
Subject: Re: [uml-devel] UML doesn't build in 2.6.23-rc3.
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
To: Jeff Dike <jdike@addtoit.com>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gV2VkbmVzZGF5IDIyIEF1Z3VzdCAyMDA3IDQ6MzE6MTUgcG0gSmVmZiBEaWtlIHdyb3RlOgo+
IE9uIFdlZCwgQXVnIDIyLCAyMDA3IGF0IDA0OjI2OjUzUE0gLTA1MDAsIFJvYiBMYW5kbGV5IHdy
b3RlOgo+ID4gaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaDogSW4gZnVuY3Rpb24g4oCYdGxiX2Zs
dXNoX21tdeKAmToKPiA+IGluY2x1ZGUvYXNtLWdlbmVyaWMvdGxiLmg6NzY6IGVycm9yOiBpbXBs
aWNpdCBkZWNsYXJhdGlvbiBvZgo+ID4gZnVuY3Rpb24g4oCYcmVsZWFzZV9wYWdlc+KAmQo+ID4g
aW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaDogSW4gZnVuY3Rpb24g4oCYdGxiX3JlbW92ZV9wYWdl
4oCZOgo+ID4gaW5jbHVkZS9hc20tZ2VuZXJpYy90bGIuaDoxMDU6IGVycm9yOiBpbXBsaWNpdCBk
ZWNsYXJhdGlvbiBvZgo+ID4gZnVuY3Rpb24g4oCYcGFnZV9jYWNoZV9yZWxlYXNl4oCZCj4KPiBT
aG91bGRuJ3QgdGhlIG5ldyBpbmNsdWRlIGdvIGluIGFzbS1nZW5lcmljL3RsYi5oIGluc3RlYWQ/
CgpJIGRpZG4ndCBzYXkgaXQgd2FzIHRoZSByaWdodCBmaXgsIGp1c3QgdGhhdCBpdCBnb3QgaXQg
dG8gd29yayBmb3IgbWUuIDopCgo+IFRoaXMgZG9lc24ndCBjYXVzZSBhbnkgb2J2aW91cyBwcm9i
bGVtcywgYnV0IHRoZW4gSSB3YXNuJ3Qgc2VlaW5nIHRoZQo+IGJ1aWxkIGZhaWx1cmUgaW4gdGhl
IGZpcnN0IHBsYWNlLgoKY2F0ID4gbWluaS5jb25mIDw8IEVPRgpDT05GSUdfTU9ERV9TS0FTPXkK
Q09ORklHX0JJTkZNVF9FTEY9eQpDT05GSUdfSE9TVEZTPXkKQ09ORklHX1NZU0NUTD15CkNPTkZJ
R19TVERFUlJfQ09OU09MRT15CkNPTkZJR19VTklYOThfUFRZUz15CkNPTkZJR19CTEtfREVWX0xP
T1A9eQpDT05GSUdfTEJEPXkKQ09ORklHX0VYVDJfRlM9eQpDT05GSUdfUFJPQ19GUz15CkVPRgpt
YWtlIEFSQ0g9dW0gYWxsbm9jb25maWcgS0NPTkZJR19BTExDT05GSUc9bWluaS5jb25mCm1ha2Ug
QVJDSD11bQoKRG9lcyB0aGF0IHJlcHJvZHVjZSBpdCBmb3IgeW91PwoKPiAJCQkJSmVmZgoKUm9i
Ci0tIAoiT25lIG9mIG15IG1vc3QgcHJvZHVjdGl2ZSBkYXlzIHdhcyB0aHJvd2luZyBhd2F5IDEw
MDAgbGluZXMgb2YgY29kZS4iCiAgLSBLZW4gVGhvbXBzb24uCgotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRo
aXMgU0YubmV0IGVtYWlsIGlzIHNwb25zb3JlZCBieTogU3BsdW5rIEluYy4KU3RpbGwgZ3JlcHBp
bmcgdGhyb3VnaCBsb2cgZmlsZXMgdG8gZmluZCBwcm9ibGVtcz8gIFN0b3AuCk5vdyBTZWFyY2gg
bG9nIGV2ZW50cyBhbmQgY29uZmlndXJhdGlvbiBmaWxlcyB1c2luZyBBSkFYIGFuZCBhIGJyb3dz
ZXIuCkRvd25sb2FkIHlvdXIgRlJFRSBjb3B5IG9mIFNwbHVuayBub3cgPj4gIGh0dHA6Ly9nZXQu
c3BsdW5rLmNvbS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1vZGUtbGludXgtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=
