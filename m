Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPB-00077m-PJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:53 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP7-0001AR-KT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:53 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:26 +0200
Message-Id: <1311239914-8301-2-git-send-email-richard@nod.at>
In-Reply-To: <1311239914-8301-1-git-send-email-richard@nod.at>
References: <1311239914-8301-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
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
Subject: [uml-devel] [PATCH 02/10] uml: helper.c warning corrections
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Vitaliy Ivanov <vitalivanov@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

RnJvbTogVml0YWxpeSBJdmFub3YgPHZpdGFsaXZhbm92QGdtYWlsLmNvbT4KCmFyY2gvdW0vb3Mt
TGludXgvaGVscGVyLmM6IEluIGZ1bmN0aW9uIOKAmGhlbHBlcl9jaGlsZOKAmToKYXJjaC91bS9v
cy1MaW51eC9oZWxwZXIuYzozODo3OiB3YXJuaW5nOiBpZ25vcmluZyByZXR1cm4gdmFsdWUgb2Yg
4oCYd3JpdGXigJksIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3VsdAoK
U2lnbmVkLW9mZi1ieTogVml0YWxpeSBJdmFub3YgPHZpdGFsaXZhbm92QGdtYWlsLmNvbT4KW3Jp
Y2hhcmRAbm9kLmF0OiBoYXBwZW5zIG9ubHkgd2l0aCAtRF9GT1JUSUZZX1NPVVJDRT0yXQpTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgotLS0KIGFyY2gv
dW0vb3MtTGludXgvaGVscGVyLmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gvdW0vb3MtTGludXgv
aGVscGVyLmMgYi9hcmNoL3VtL29zLUxpbnV4L2hlbHBlci5jCmluZGV4IGI2YjEwOTYuLmZlZmYy
MmQgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vb3MtTGludXgvaGVscGVyLmMKKysrIGIvYXJjaC91bS9v
cy1MaW51eC9oZWxwZXIuYwpAQCAtMjgsMTQgKzI4LDE0IEBAIHN0YXRpYyBpbnQgaGVscGVyX2No
aWxkKHZvaWQgKmFyZykKIHsKIAlzdHJ1Y3QgaGVscGVyX2RhdGEgKmRhdGEgPSBhcmc7CiAJY2hh
ciAqKmFyZ3YgPSBkYXRhLT5hcmd2OwotCWludCBlcnI7CisJaW50IGVyciwgcmV0OwogCiAJaWYg
KGRhdGEtPnByZV9leGVjICE9IE5VTEwpCiAJCSgqZGF0YS0+cHJlX2V4ZWMpKGRhdGEtPnByZV9k
YXRhKTsKIAllcnIgPSBleGVjdnBfbm9hbGxvYyhkYXRhLT5idWYsIGFyZ3ZbMF0sIGFyZ3YpOwog
CiAJLyogSWYgdGhlIGV4ZWMgc3VjY2VlZHMsIHdlIGRvbid0IGdldCBoZXJlICovCi0Jd3JpdGUo
ZGF0YS0+ZmQsICZlcnIsIHNpemVvZihlcnIpKTsKKwlDQVRDSF9FSU5UUihyZXQgPSB3cml0ZShk
YXRhLT5mZCwgJmVyciwgc2l6ZW9mKGVycikpKTsKIAogCXJldHVybiAwOwogfQotLSAKMS43LjYK
CgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KNSBXYXlzIHRvIEltcHJvdmUgJiBTZWN1cmUgVW5pZmll
ZCBDb21tdW5pY2F0aW9ucwpVbmlmaWVkIENvbW11bmljYXRpb25zIHByb21pc2VzIGdyZWF0ZXIg
ZWZmaWNpZW5jaWVzIGZvciBidXNpbmVzcy4gVUMgY2FuIAppbXByb3ZlIGludGVybmFsIGNvbW11
bmljYXRpb25zIGFzIHdlbGwgYXMgb2ZmZXIgZmFzdGVyLCBtb3JlIGVmZmljaWVudCB3YXlzCnRv
IGludGVyYWN0IHdpdGggY3VzdG9tZXJzIGFuZCBzdHJlYW1saW5lIGN1c3RvbWVyIHNlcnZpY2Uu
IExlYXJuIG1vcmUhCmh0dHA6Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3NmbmwvMTE0LzUxNDI2
MjUzLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2Vy
LW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlz
dGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

