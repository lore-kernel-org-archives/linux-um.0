Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1efOOS-00071K-PB
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:11:32 +0000
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]
 helo=smtp.smtpout.orange.fr)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
 (Exim 4.89) id 1efOOR-00089w-A1
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:11:32 +0000
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sat, 27 Jan 2018 11:53:57 +0100
Message-Id: <20180127105357.2728-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 1/2] um: vector: Fix a memory allocation check
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, user-mode-linux-user@lists.sourceforge.net
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, kernel-janitors@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Q2hlY2tpbmcgdGhlIHJlc3VsdCBvZiB0aGUgcHJldmlvdXMgJ2tzdHJkdXAoKScgY2FsbCBpcyBl
eHBlY3RlZCBoZXJlLCBzbwp3ZSBzaG91bGQgdGVzdCAncGFyYW1zJyBhbmQgbm90ICdzdHInICh3
aGljaCBpcyBrbm93biB0byBiZSBub24tTlVMTCBhdAp0aGlzIHBvaW50KQoKRml4ZXM6IGFkMWY2
MmFiMmJkNCAoIkhpZ2ggUGVyZm9ybWFuY2UgVU1MIFZlY3RvciBOZXR3b3JrIERyaXZlciIpClNp
Z25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFk
b28uZnI+Ci0tLQogYXJjaC91bS9kcml2ZXJzL3ZlY3Rvcl9rZXJuLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNo
L3VtL2RyaXZlcnMvdmVjdG9yX2tlcm4uYyBiL2FyY2gvdW0vZHJpdmVycy92ZWN0b3Jfa2Vybi5j
CmluZGV4IGQxZDUzMDE1ZDU3Mi4uM2MxZTZhZDkxMDE2IDEwMDY0NAotLS0gYS9hcmNoL3VtL2Ry
aXZlcnMvdmVjdG9yX2tlcm4uYworKysgYi9hcmNoL3VtL2RyaXZlcnMvdmVjdG9yX2tlcm4uYwpA
QCAtNzIzLDcgKzcyMyw3IEBAIHN0YXRpYyBpbnQgdmVjdG9yX2NvbmZpZyhjaGFyICpzdHIsIGNo
YXIgKiplcnJvcl9vdXQpCiAJICovCiAKIAlwYXJhbXMgPSBrc3RyZHVwKHBhcmFtcywgR0ZQX0tF
Uk5FTCk7Ci0JaWYgKHN0ciA9PSBOVUxMKSB7CisJaWYgKHBhcmFtcyA9PSBOVUxMKSB7CiAJCSpl
cnJvcl9vdXQgPSAidmVjdG9yX2NvbmZpZyBmYWlsZWQgdG8gc3RyZHVwIHN0cmluZyI7CiAJCXJl
dHVybiAtRU5PTUVNOwogCX0KLS0gCjIuMTQuMQoKCi0tLQpMJ2Fic2VuY2UgZGUgdmlydXMgZGFu
cyBjZSBjb3VycmllciDDqWxlY3Ryb25pcXVlIGEgw6l0w6kgdsOpcmlmacOpZSBwYXIgbGUgbG9n
aWNpZWwgYW50aXZpcnVzIEF2YXN0LgpodHRwczovL3d3dy5hdmFzdC5jb20vYW50aXZpcnVzCgoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCkNoZWNrIG91dCB0aGUgdmlicmFudCB0ZWNoIGNvbW11bml0
eSBvbiBvbmUgb2YgdGhlIHdvcmxkJ3MgbW9zdAplbmdhZ2luZyB0ZWNoIHNpdGVzLCBTbGFzaGRv
dC5vcmchIGh0dHA6Ly9zZG0ubGluay9zbGFzaGRvdApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGluZyBsaXN0
ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRldmVsCg==

