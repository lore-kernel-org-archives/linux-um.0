Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1QjpPB-0000m7-Ow
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:53 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QjpP7-0001AP-KT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Jul 2011 09:18:53 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 21 Jul 2011 11:18:25 +0200
Message-Id: <1311239914-8301-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 01/10] uml: cow_user.c warning corrections
To: akpm@linux-foundation.org
Cc: Richard Weinberger <richard@nod.at>, Vitaliy Ivanov <vitalivanov@gmail.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

RnJvbTogVml0YWxpeSBJdmFub3YgPHZpdGFsaXZhbm92QGdtYWlsLmNvbT4KCmFyY2gvdW0vZHJp
dmVycy9jb3dfdXNlci5jOiBJbiBmdW5jdGlvbiDigJhhYnNvbHV0aXpl4oCZOgphcmNoL3VtL2Ry
aXZlcnMvY293X3VzZXIuYzoxODk6Nzogd2FybmluZzogaWdub3JpbmcgcmV0dXJuIHZhbHVlIG9m
IOKAmGNoZGly4oCZLCBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSB3YXJuX3VudXNlZF9yZXN1bHQK
ClNpZ25lZC1vZmYtYnk6IFZpdGFsaXkgSXZhbm92IDx2aXRhbGl2YW5vdkBnbWFpbC5jb20+Clty
aWNoYXJkQG5vZC5hdDogaGFwcGVucyBvbmx5IHdpdGggLURfRk9SVElGWV9TT1VSQ0U9Ml0KU2ln
bmVkLW9mZi1ieTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KLS0tCiBhcmNo
L3VtL2RyaXZlcnMvY293X3VzZXIuYyB8ICAgIDYgKysrKystCiAxIGZpbGVzIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3VtL2RyaXZl
cnMvY293X3VzZXIuYyBiL2FyY2gvdW0vZHJpdmVycy9jb3dfdXNlci5jCmluZGV4IDkzZjIyN2Eu
LjljYmI0MjYgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vZHJpdmVycy9jb3dfdXNlci5jCisrKyBiL2Fy
Y2gvdW0vZHJpdmVycy9jb3dfdXNlci5jCkBAIC0xODYsNyArMTg2LDExIEBAIHN0YXRpYyBpbnQg
YWJzb2x1dGl6ZShjaGFyICp0bywgaW50IHNpemUsIGNoYXIgKmZyb20pCiAJCXN0cmNhdCh0bywg
Ii8iKTsKIAkJc3RyY2F0KHRvLCBmcm9tKTsKIAl9Ci0JY2hkaXIoc2F2ZV9jd2QpOworCWlmIChj
aGRpcihzYXZlX2N3ZCkpIHsKKwkJY293X3ByaW50ZigiYWJzb2x1dGl6ZSA6IENhbid0IGNkIHRv
ICclcycgLSAiCisJCQkgICAiZXJybm8gPSAlZFxuIiwgc2F2ZV9jd2QsIGVycm5vKTsKKwkJcmV0
dXJuIC0xOworCX0KIAlyZXR1cm4gMDsKIH0KIAotLSAKMS43LjYKCgotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KNSBXYXlzIHRvIEltcHJvdmUgJiBTZWN1cmUgVW5pZmllZCBDb21tdW5pY2F0aW9ucwpV
bmlmaWVkIENvbW11bmljYXRpb25zIHByb21pc2VzIGdyZWF0ZXIgZWZmaWNpZW5jaWVzIGZvciBi
dXNpbmVzcy4gVUMgY2FuIAppbXByb3ZlIGludGVybmFsIGNvbW11bmljYXRpb25zIGFzIHdlbGwg
YXMgb2ZmZXIgZmFzdGVyLCBtb3JlIGVmZmljaWVudCB3YXlzCnRvIGludGVyYWN0IHdpdGggY3Vz
dG9tZXJzIGFuZCBzdHJlYW1saW5lIGN1c3RvbWVyIHNlcnZpY2UuIExlYXJuIG1vcmUhCmh0dHA6
Ly93d3cuYWNjZWxhY29tbS5jb20vamF3L3NmbmwvMTE0LzUxNDI2MjUzLwpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwg
bWFpbGluZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxp
bnV4LWRldmVsCg==

