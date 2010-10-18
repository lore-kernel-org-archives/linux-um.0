Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <richard@nod.at>) id 1P7sit-0003xc-Ru
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 16:38:07 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P7sir-00068V-JO
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2010 16:38:07 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 18 Oct 2010 18:36:54 +0200
Message-Id: <1287419814-20086-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Subject: [uml-devel] [PATCH 1/1] hostfs: fix UML crash
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
To: akpm@linux-foundation.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, toralf.foerster@gmx.de

MzY1YjE4MTggcmVzaXplZCBmX3NwYXJlIHdpdGhpbiBzdHJ1Y3Qgc3RhdGZzLgpob3N0ZnMgYWNj
ZXNzZXMgZl9zcGFyZSBkaXJlY3RseSBhbmQgbmVlZHMgYW4gdXBkYXRlLgoKU2lnbmVkLW9mZi1i
eTogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KUmVwb3J0ZWQtYnk6IFRvcmFs
ZiBGw7Zyc3RlciA8dG9yYWxmLmZvZXJzdGVyQGdteC5kZT4KVGVzdGVkLWJ5OiBUb3JhbGYgRsO2
cnN0ZXIgPHRvcmFsZi5mb2Vyc3RlckBnbXguZGU+Ci0tLQogZnMvaG9zdGZzL2hvc3Rmc191c2Vy
LmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9mcy9ob3N0ZnMvaG9zdGZzX3VzZXIuYyBiL2ZzL2hvc3Rmcy9o
b3N0ZnNfdXNlci5jCmluZGV4IDY3NzdhYTAuLmNlMmYxNjggMTAwNjQ0Ci0tLSBhL2ZzL2hvc3Rm
cy9ob3N0ZnNfdXNlci5jCisrKyBiL2ZzL2hvc3Rmcy9ob3N0ZnNfdXNlci5jCkBAIC0zODgsNiAr
Mzg4LDYgQEAgaW50IGRvX3N0YXRmcyhjaGFyICpyb290LCBsb25nICpic2l6ZV9vdXQsIGxvbmcg
bG9uZyAqYmxvY2tzX291dCwKIAlzcGFyZV9vdXRbMV0gPSBidWYuZl9zcGFyZVsxXTsKIAlzcGFy
ZV9vdXRbMl0gPSBidWYuZl9zcGFyZVsyXTsKIAlzcGFyZV9vdXRbM10gPSBidWYuZl9zcGFyZVsz
XTsKLQlzcGFyZV9vdXRbNF0gPSBidWYuZl9zcGFyZVs0XTsKKwogCXJldHVybiAwOwogfQotLSAK
MS42LjYuMQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpEb3dubG9hZCBuZXcgQWRvYmUoUikgRmxh
c2goUikgQnVpbGRlcihUTSkgNApUaGUgbmV3IEFkb2JlKFIpIEZsZXgoUikgNCBhbmQgRmxhc2go
UikgQnVpbGRlcihUTSkgNCAoZm9ybWVybHkgCkZsZXgoUikgQnVpbGRlcihUTSkpIGVuYWJsZSB0
aGUgZGV2ZWxvcG1lbnQgb2YgcmljaCBhcHBsaWNhdGlvbnMgdGhhdCBydW4KYWNyb3NzIG11bHRp
cGxlIGJyb3dzZXJzIGFuZCBwbGF0Zm9ybXMuIERvd25sb2FkIHlvdXIgZnJlZSB0cmlhbHMgdG9k
YXkhCmh0dHA6Ly9wLnNmLm5ldC9zZnUvYWRvYmUtZGV2MmRldgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpVc2VyLW1vZGUtbGludXgtZGV2ZWwgbWFpbGlu
ZyBsaXN0ClVzZXItbW9kZS1saW51eC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vdXNlci1tb2RlLWxpbnV4LWRl
dmVsCg==

