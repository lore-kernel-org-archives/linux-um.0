Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jquy0-0003bj-Bz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 11:54:16 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user53291)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jquxy-00006w-PU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Apr 2008 11:54:16 -0700
References: <20080425175613.GA11192@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Tue, 29 Apr 2008 19:54:02 +0100
In-Reply-To: <20080425175613.GA11192@c2.user-mode-linux.org> (Jeff Dike's
	message of "Fri, 25 Apr 2008 13:56:13 -0400")
Message-ID: <877iegcx11.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH 11/19] UML - Track and make up lost ticks
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-7"
Content-Transfer-Encoding: base64
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

T24gMjUgQXByIDIwMDgsIEplZmYgRGlrZSBzdGF0ZWQsIGluIHBhcnQ6Cj4gSW5kZXg6IGxpbnV4
LTIuNi1naXQvYXJjaC91bS9vcy1MaW51eC90aW1lLmMKPiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gLS0tIGxpbnV4
LTIuNi1naXQub3JpZy9hcmNoL3VtL29zLUxpbnV4L3RpbWUuYwkyMDA4LTA0LTI1IDEwOjQyOjEy
LjAwMDAwMDAwMCAtMDQwMAo+ICsrKyBsaW51eC0yLjYtZ2l0L2FyY2gvdW0vb3MtTGludXgvdGlt
ZS5jCTIwMDgtMDQtMjUgMTE6MTk6MjYuMDAwMDAwMDAwIC0wNDAwCj4gKwlhbGFybV9oYW5kbGVy
KFNJR1ZUQUxSTSwgTlVMTCk7Cj4gKwkJYWxhcm1faGFuZGxlcihTSUdWVEFMUk0sIE5VTEwpOwo+
IC1leHRlcm4gdm9pZCBhbGFybV9oYW5kbGVyKGludCBzaWcsIHN0cnVjdCBzaWdjb250ZXh0ICpz
Yyk7Cj4gLQkJYWxhcm1faGFuZGxlcihTSUdWVEFMUk0sIE5VTEwpOwoKWWV0LCBpbiBhcmNoL3Vt
L2luY2x1ZGUvcHJvY2Vzcy5oLCB3ZSBzZWUsIHVuY2hhbmdlZCBzaW5jZSB0aGUgeWVhciBkb3Qs
IHRoZQpvYnZpb3VzbHkgd3JvbmcgcHJvdG90eXBlOgoKZXh0ZXJuIHZvaWQgYWxhcm1faGFuZGxl
cihpbnQgc2lnLCBzdHJ1Y3Qgc2lnY29udGV4dCBzYyk7CgpIZW5jZToKCiAgQ0MgICAgICBhcmNo
L3VtL29zLUxpbnV4L3RpbWUubwphcmNoL3VtL29zLUxpbnV4L3RpbWUuYzogSW4gZnVuY3Rpb24g
oWRlbGl2ZXJfYWxhcm2iOgphcmNoL3VtL29zLUxpbnV4L3RpbWUuYzoxMTk6IGVycm9yOiBpbmNv
bXBhdGlibGUgdHlwZSBmb3IgYXJndW1lbnQgMiBvZiChYWxhcm1faGFuZGxlcqIKbWFrZVsxXTog
KioqIFthcmNoL3VtL29zLUxpbnV4L3RpbWUub10gRXJyb3IgMQptYWtlOiAqKiogW2FyY2gvdW0v
b3MtTGludXhdIEVycm9yIDIKCkZpeCB0cml2aWFsOgoKU2lnbmVkLW9mZi1ieTogTmljayBBbGNv
Y2sgPG5peEBlc3Blcmkub3JnLnVrPgotLSAKSW5kZXg6IGxpbnV4L2FyY2gvdW0vaW5jbHVkZS9w
cm9jZXNzLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgub3JpZy9hcmNoL3VtL2luY2x1ZGUvcHJvY2Vz
cy5oCTIwMDYtMDctMDkgMTQ6MTk6NTIuMDAwMDAwMDAwICswMTAwCisrKyBsaW51eC9hcmNoL3Vt
L2luY2x1ZGUvcHJvY2Vzcy5oCTIwMDgtMDQtMjkgMTk6NDk6NDkuMDAwMDAwMDAwICswMTAwCkBA
IC04LDggKzgsOCBAQAogCiAjaW5jbHVkZSA8c2lnbmFsLmg+CiAKLWV4dGVybiB2b2lkIHNpZ19o
YW5kbGVyKGludCBzaWcsIHN0cnVjdCBzaWdjb250ZXh0IHNjKTsKLWV4dGVybiB2b2lkIGFsYXJt
X2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2NvbnRleHQgc2MpOworZXh0ZXJuIHZvaWQgc2ln
X2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2NvbnRleHQgKnNjKTsKK2V4dGVybiB2b2lkIGFs
YXJtX2hhbmRsZXIoaW50IHNpZywgc3RydWN0IHNpZ2NvbnRleHQgKnNjKTsKIAogI2VuZGlmCiAK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KVGhpcyBTRi5uZXQgZW1haWwgaXMgc3BvbnNvcmVkIGJ5IHRoZSAy
MDA4IEphdmFPbmUoU00pIENvbmZlcmVuY2UgCkRvbid0IG1pc3MgdGhpcyB5ZWFyJ3MgZXhjaXRp
bmcgZXZlbnQuIFRoZXJlJ3Mgc3RpbGwgdGltZSB0byBzYXZlICQxMDAuIApVc2UgcHJpb3JpdHkg
Y29kZSBKOFRMMkQyLiAKaHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MTk4NzU3NjczOzEz
NTAzMDM4O3A/aHR0cDovL2phdmEuc3VuLmNvbS9qYXZhb25lCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9kZS1saW51eC1kZXZlbCBtYWlsaW5n
IGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby91c2VyLW1vZGUtbGludXgtZGV2
ZWwK
