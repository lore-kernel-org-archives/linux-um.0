Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IxMKB-0007cv-0m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 04:47:31 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=dorka.pomaz.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IxMKA-0005mM-Cd
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Nov 2007 04:47:31 -0800
MIME-version: 1.0
Message-Id: <E1IxMK0-0006ae-2s@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Nov 2007 13:47:20 +0100
Subject: [uml-devel] -rt doesn't compile for UML
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
To: mingo@elte.hu
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

V2hlbiB3cml0aW5nIGEgYmlnIGZpbGUgdG8gYSB1YmQgZGlzaywgZXZlcnl0aGluZyBpbiB1bWwg
c2xvd3MgZG93biB0bwphIGNyYXdsLCBldmVuIHRob3VnaCBDUFUgdXNhZ2UgaXMgbWluaW1hbC4K
ClNvIEkgd2FudGVkIHRvIHRyeSB0aGUgbGF0ZW5jeSB0cmFjZXIgZnJvbSAtcnQsIGJ1dCBpdCBk
b2Vzbid0IGNvbXBpbGUKd2l0aCBVTUw6CgogIENDICAgICAgYXJjaC91bS9rZXJuZWwvYXNtLW9m
ZnNldHMucwpJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC91bS9pbmNsdWRlL3N5c2RlcC9rZXJu
ZWwtb2Zmc2V0cy5oOjIsCiAgICAgICAgICAgICAgICAgZnJvbSBhcmNoL3VtL2tlcm5lbC9hc20t
b2Zmc2V0cy5jOjE6CmluY2x1ZGUvbGludXgvc2NoZWQuaDogSW4gZnVuY3Rpb24g4oCYc2V0X3Rz
a19uZWVkX3Jlc2NoZWRfZGVsYXllZOKAmToKaW5jbHVkZS9saW51eC9zY2hlZC5oOjIxMDU6IGVy
cm9yOiDigJhUSUZfTkVFRF9SRVNDSEVEX0RFTEFZRUTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNl
IGluIHRoaXMgZnVuY3Rpb24pCmluY2x1ZGUvbGludXgvc2NoZWQuaDoyMTA1OiBlcnJvcjogKEVh
Y2ggdW5kZWNsYXJlZCBpZGVudGlmaWVyIGlzIHJlcG9ydGVkIG9ubHkgb25jZQppbmNsdWRlL2xp
bnV4L3NjaGVkLmg6MjEwNTogZXJyb3I6IGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4u
KQppbmNsdWRlL2xpbnV4L3NjaGVkLmg6IEluIGZ1bmN0aW9uIOKAmGNsZWFyX3Rza19uZWVkX3Jl
c2NoZWRfZGVsYXllZOKAmToKaW5jbHVkZS9saW51eC9zY2hlZC5oOjIxMTA6IGVycm9yOiDigJhU
SUZfTkVFRF9SRVNDSEVEX0RFTEFZRUTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg
ZnVuY3Rpb24pCmluY2x1ZGUvbGludXgvc2NoZWQuaDogSW4gZnVuY3Rpb24g4oCYbmVlZF9yZXNj
aGVkX2RlbGF5ZWTigJk6CmluY2x1ZGUvbGludXgvc2NoZWQuaDoyMTE1OiBlcnJvcjog4oCYVElG
X05FRURfUkVTQ0hFRF9ERUxBWUVE4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1
bmN0aW9uKQptYWtlWzFdOiAqKiogW2FyY2gvdW0va2VybmVsL2FzbS1vZmZzZXRzLnNdIEVycm9y
IDEKbWFrZTogKioqIFtwcmVwYXJlMF0gRXJyb3IgMgoKSW5nbywgZG8geW91IHRoaW5rIHRoaXMg
cm91dGUgaXMgd29ydGh3aGlsZSBwdXJzdWluZywgb3IgaXMgaXQgdG9vCmRpZmZpY3VsdCB0byBt
YWtlIC1ydCB3b3JrIGZvciBVTUw/CgpUaGFua3MsCk1pa2xvcwoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpT
Ri5OZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5OiBUaGUgRnV0dXJlIG9mIExpbnV4IEJ1c2luZXNz
IFdoaXRlIFBhcGVyCmZyb20gTm92ZWxsLiAgRnJvbSB0aGUgZGVza3RvcCB0byB0aGUgZGF0YSBj
ZW50ZXIsIExpbnV4IGlzIGdvaW5nCm1haW5zdHJlYW0uICBMZXQgaXQgc2ltcGxpZnkgeW91ciBJ
VCBmdXR1cmUuCmh0dHA6Ly9hbHRmYXJtLm1lZGlhcGxleC5jb20vYWQvY2svODg1Ny01MDMwNy0x
ODkxOC00Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVz
ZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK
