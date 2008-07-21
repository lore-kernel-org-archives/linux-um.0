Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKyfz-0006u3-Dk for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 09:55:55 -0700
Received: from nf-out-0910.google.com ([64.233.182.186])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKyfx-0003r1-Pr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Jul 2008 09:55:55 -0700
Received: by nf-out-0910.google.com with SMTP id g16so417666nfd.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 21 Jul 2008 09:55:52 -0700 (PDT)
Date: Mon, 21 Jul 2008 17:54:09 +0100
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20080721165409.GA9023@hack.voiplan.pt>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [Patch] um: fix a build error
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

CkZpeGVkIHRoaXMgYnVpbGQgZXJyb3I6CgovaG9tZS93YW5nY29uZy9Qcm9qZWN0cy9saW51eC0y
LjYvYXJjaC91bS9kcml2ZXJzL2xpbmUuYzogSW4gZnVuY3Rpb24K4oCYbGluZV93cml0ZV9pbnRl
cnJ1cHTigJk6Ci9ob21lL3dhbmdjb25nL1Byb2plY3RzL2xpbnV4LTIuNi9hcmNoL3VtL2RyaXZl
cnMvbGluZS5jOjM2NjogZXJyb3I6CuKAmHN0cnVjdCB0dHlfbGRpc2PigJkgaGFzIG5vIG1lbWJl
ciBuYW1lZCDigJh3cml0ZV93YWtldXDigJkKL2hvbWUvd2FuZ2NvbmcvUHJvamVjdHMvbGludXgt
Mi42L2FyY2gvdW0vZHJpdmVycy9saW5lLmM6MzY3OiBlcnJvcjoK4oCYc3RydWN0IHR0eV9sZGlz
Y+KAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHdyaXRlX3dha2V1cOKAmQptYWtlWzJdOiAqKiog
W2FyY2gvdW0vZHJpdmVycy9saW5lLm9dIEVycm9yIDEKbWFrZVsxXTogKioqIFthcmNoL3VtL2Ry
aXZlcnNdIEVycm9yIDIKbWFrZTogKioqIFtzdWItbWFrZV0gRXJyb3IgMgoKU2lnZW5kLW9mZi1i
eTogV0FORyBDb25nIDx3YW5nY29uZ0B6ZXV1eC5vcmc+CkNjOiBqZGlrZUBhZGR0b2l0LmNvbQoK
LS0tCmRpZmYgLS1naXQgYS9hcmNoL3VtL2RyaXZlcnMvbGluZS5jIGIvYXJjaC91bS9kcml2ZXJz
L2xpbmUuYwppbmRleCA1MDQ3NDkwLi5jODcyZGFkIDEwMDY0NAotLS0gYS9hcmNoL3VtL2RyaXZl
cnMvbGluZS5jCisrKyBiL2FyY2gvdW0vZHJpdmVycy9saW5lLmMKQEAgLTM2Myw4ICszNjMsOCBA
QCBzdGF0aWMgaXJxcmV0dXJuX3QgbGluZV93cml0ZV9pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAq
ZGF0YSkKIAkJcmV0dXJuIElSUV9OT05FOwogCiAJaWYgKHRlc3RfYml0KFRUWV9ET19XUklURV9X
QUtFVVAsICZ0dHktPmZsYWdzKSAmJgotCSAgICh0dHktPmxkaXNjLndyaXRlX3dha2V1cCAhPSBO
VUxMKSkKLQkJKHR0eS0+bGRpc2Mud3JpdGVfd2FrZXVwKSh0dHkpOworCSAgICh0dHktPmxkaXNj
Lm9wcy0+d3JpdGVfd2FrZXVwICE9IE5VTEwpKQorCQkodHR5LT5sZGlzYy5vcHMtPndyaXRlX3dh
a2V1cCkodHR5KTsKIAogCS8qCiAJICogQkxPQ0tJTkcgbW9kZQoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpU
aGlzIFNGLk5ldCBlbWFpbCBpcyBzcG9uc29yZWQgYnkgdGhlIE1vYmxpbiBZb3VyIE1vdmUgRGV2
ZWxvcGVyJ3MgY2hhbGxlbmdlCkJ1aWxkIHRoZSBjb29sZXN0IExpbnV4IGJhc2VkIGFwcGxpY2F0
aW9ucyB3aXRoIE1vYmxpbiBTREsgJiB3aW4gZ3JlYXQgcHJpemVzCkdyYW5kIHByaXplIGlzIGEg
dHJpcCBmb3IgdHdvIHRvIGFuIE9wZW4gU291cmNlIGV2ZW50IGFueXdoZXJlIGluIHRoZSB3b3Js
ZApodHRwOi8vbW9ibGluLWNvbnRlc3Qub3JnL3JlZGlyZWN0LnBocD9iYW5uZXJfaWQ9MTAwJnVy
bD0vCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXIt
bW9kZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby91c2VyLW1vZGUtbGludXgtZGV2ZWwK
