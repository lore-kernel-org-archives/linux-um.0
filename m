Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F29C4708C
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 20:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jtjpt8mEanFdWLOgNJA2l65XlBR2JZiGBAasZTdPc50=; b=uGASRFtP/3pGdJ
	dpOp/RbxJ/ZTaUxkKfoOr5xFtDEPYtsh3N6NgNosT4pxFvDCSWbGqoWqgb+UoEu1FQutRDSdKptlN
	QaQTswVA2sQ7w6WFuvIbG6jip5PDqI6yMF0naZMVgtZ+iZ/Uu5ZlJr2Rt4S/t1S3ktuk4RbX9TSoe
	+4lX7Tl7wZICwM/irZSOIL9Xs3cCHAvkL7w1sSauNvhhnLSQfBNdXI4Rzvv5qGrsElfjtrs7ljB1P
	dDCD32OMwqEiulp3lFGU43JRpvWpNoUILUmcaMT+E8YFF6+IrNiPuRENRUTvlMGUHQl9HexiKbmPa
	y4zSM+UOl3Bx9jyXmSEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TP4-002HPI-G5; Wed, 30 Nov 2022 20:09:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TP3-002HMo-Dd; Wed, 30 Nov 2022 20:09:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=E47s7ipLMlIc2p61K7hVJzDyYXzzIeBc7VvzcwFMKS0=; b=fCreKj5Uhk8PkDJ0ePgOKryMGY
	Oo5vAepcgn4j3ApgPA8Yt8s94K3O+M9LixUfH0tkR6V102fEfIfojXL8+fnMDam4Ce2ZibF4kbrgS
	g/W6809lzC8ktKSJbUTn73N7wWnSp1/l6Kwuf9gg1JVkO9EX7eg+j9QMpec4i4Tb6qVzlSv8yYJxB
	aPRo+FS+mGMpvTBF51YdoWIwOYa7ZOjZKgXEI4Os2uF9puTFIZQUihfwb+FqPZb6PAKzHcIkQm6cQ
	nhGbt+r7Zk8CV0KxuekterH7AUvfW/9eqqRifh0FP+y/xeo0nwceJAFC8iFAM/svEYUfGWX4LkcfH
	aexETR5g==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TP3-00FGQd-BU; Wed, 30 Nov 2022 20:09:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org,
	Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Date: Wed, 30 Nov 2022 12:09:45 -0800
Message-Id: <20221130200945.24459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

V2hlbiBidWlsZGluZyBxaWJfd2NfeDg2XzY0LmMgb24gQVJDSD11bSwgcmVmZXJlbmNlcyB0byBz
b21lIGNwdWluZm8KZmllbGRzIGNhdXNlIGJ1aWxkIGVycm9ycyBzaW5jZSBjcHVpbmZvIGRvZXMg
bm90IGNvbnRhaW4geDg2LXNwZWNpZmljCmZpZWxkcy4KCkZpeCB0aGUgYnVpbGQgZXJyb3JzIGJ5
IG1ha2luZyB0aGlzIGRyaXZlciBkZXBlbmQgb24gIVVNTC4KClByZXZlbnRzIHRoZXNlIGJ1aWxk
IGVycm9yczoKCi4uL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3djX3g4Nl82NC5jOiBJ
biBmdW5jdGlvbiDigJhxaWJfdW5vcmRlcmVkX3dj4oCZOgouLi9kcml2ZXJzL2luZmluaWJhbmQv
aHcvcWliL3FpYl93Y194ODZfNjQuYzoxNDk6Mjk6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191
beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4Nl92ZW5kb3LigJkKICAxNDkgfCAgICAgICAg
IHJldHVybiBib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgIT0gWDg2X1ZFTkRPUl9BTUQ7Ci4uL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3djX3g4Nl82NC5jOjE0OTo0NDogZXJyb3I6IOKA
mFg4Nl9WRU5ET1JfQU1E4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KTsgZGlkIHlvdSBtZWFuIOKAmFg4Nl9WRU5ET1JfQU5Z4oCZPwogIDE0OSB8ICAgICAgICAgcmV0
dXJuIGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciAhPSBYODZfVkVORE9SX0FNRDsKLi4vZHJpdmVy
cy9pbmZpbmliYW5kL2h3L3FpYi9xaWJfd2NfeDg2XzY0LmM6MTQ5OjQ0OiBub3RlOiBlYWNoIHVu
ZGVjbGFyZWQgaWRlbnRpZmllciBpcyByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rp
b24gaXQgYXBwZWFycyBpbgouLi9kcml2ZXJzL2luZmluaWJhbmQvaHcvcWliL3FpYl93Y194ODZf
NjQuYzoxNTA6MTogZXJyb3I6IGNvbnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rp
b24gWy1XZXJyb3I9cmV0dXJuLXR5cGVdCiAgMTUwIHwgfQoKRml4ZXM6IDY4ZjVkM2YzYjY1NCAo
InVtOiBhZGQgUENJIG92ZXIgdmlydGlvIGVtdWxhdGlvbiBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5
OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KQ2M6IEphc29uIEd1bnRob3Jw
ZSA8amdnQG52aWRpYS5jb20+CkNjOiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4K
Q2M6IERlbm5pcyBEYWxlc3NhbmRybyA8ZGVubmlzLmRhbGVzc2FuZHJvQGNvcm5lbGlzbmV0d29y
a3MuY29tPgpDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IEplZmYgRGlrZSA8amRp
a2VAYWRkdG9pdC5jb20+CkNjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpD
YzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgpDYzogSm9o
YW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4KQ2M6IGxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmcKLS0tCnYyOiByZWJhc2UgJiByZXNlbmQKCiBkcml2ZXJzL2luZmluaWJh
bmQvaHcvcWliL0tjb25maWcgfCAgICAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvS2NvbmZpZyBiL2RyaXZlcnMv
aW5maW5pYmFuZC9ody9xaWIvS2NvbmZpZwotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvcWli
L0tjb25maWcKKysrIGIvZHJpdmVycy9pbmZpbmliYW5kL2h3L3FpYi9LY29uZmlnCkBAIC0zLDYg
KzMsNyBAQCBjb25maWcgSU5GSU5JQkFORF9RSUIKIAl0cmlzdGF0ZSAiSW50ZWwgUENJZSBIQ0Eg
c3VwcG9ydCIKIAlkZXBlbmRzIG9uIDY0QklUICYmIElORklOSUJBTkRfUkRNQVZUCiAJZGVwZW5k
cyBvbiBQQ0kKKwlkZXBlbmRzIG9uICFVTUwKIAloZWxwCiAJVGhpcyBpcyBhIGxvdy1sZXZlbCBk
cml2ZXIgZm9yIEludGVsIFBDSWUgUUxFIEluZmluaUJhbmQgaG9zdAogCWNoYW5uZWwgYWRhcHRl
cnMuICBUaGlzIGRyaXZlciBkb2VzIG5vdCBzdXBwb3J0IHRoZSBJbnRlbAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0
CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcv
bWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
