Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B95C47089
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 20:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=H49ciwjWougnfwmzzrNQdUCtbjjpYoWNSS61lntOD4w=; b=cp61VBBsqCRg80
	NGHsi4/EdXMKsmz7QeoMdAsED9GnTA8BR5Y2r4GDacgmeaToIqek3XH4m7R1Xow/LEmw2BXM6GCEA
	zooboFVnZrS97DiPQu8g00ZzZHzAgS6slnYSdNd/XtM+BjHS+E8rQpDPK5sv1kl7UQro5VlKgVy+P
	jnA9C+gdMWCSIYorwQL/m+MF1ZrNrUtEod2r3I/V7Xg4XVW4AiEZ6vG5WxrnZqCOt6++OCvZ5jQqh
	ktzPFDgavklVrJr1X+9VyCS8GVz+8siAndzcPb6WcjNUZJ9awQ4L5A3S3tKHXMUxs4WfXTbceTQZC
	pF/vvp+L5S1bYaufnZfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TPD-002HV3-0O; Wed, 30 Nov 2022 20:10:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TPA-002HTX-VC; Wed, 30 Nov 2022 20:10:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=NwdMiyCjs6mBb9kzRTViptsfgQPSjSYNBJwUO380cGY=; b=uxj1BF9/I/5pNSHmqGTJuYm1N3
	tohajqYrPBHQV8fIjEsRWOBkskUeekGasvvjKuVZVYVoT+0KuVqGPtzWYQuhz/z5uqjJbI+kSkbv2
	Pp55Z+uH8QXeGgIA88m3+VNQ/Oo1GpoVgXC7hXvitzpcVcVrk2zMMpARsbR/QjoIdvS4mvhIg71i2
	Lc2CDfDoG/RMXultHOWY0LUyPfRxK5tarBXAq7HAQnx+c70DcvFuAK2jPChUo3Miu8Jp/V87a6VnG
	UyizTR2IPrz5b+EAO72nFY2W6SHIUsf3qpKkpx1pmOFJHHRH4Sco3JHinEGsiYPu8iLoluRpD5im1
	A599fzTA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0TPG-00FGSf-4M; Wed, 30 Nov 2022 20:10:10 +0000
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
Subject: [PATCH 2/2] IB/rdmavt: don't use rdmavt for UML
Date: Wed, 30 Nov 2022 12:09:58 -0800
Message-Id: <20221130200958.25305-1-rdunlap@infradead.org>
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

V2hlbiBidWlsZGluZyByZG1hdnQgZm9yIEFSQ0g9dW0sIHFwLmMgaGFzIGEgYnVpbGQgZXJyb3Ig
b24gYSByZWZlcmVuY2UKdG8gdGhlIHg4Ni1zcGVjaWZpYyBjcHVpbmZvIGZpZWxkICd4ODZfY2Fj
aGVfc2l6ZScuCgpGaXggdGhlIGJ1aWxkIGVycm9ycyBieSBtYWtpbmcgdGhpcyBkcml2ZXIgZGVw
ZW5kIG9uICFVTUwuCgpQcmV2ZW50cyB0aGVzZSBidWlsZCBlcnJvcnM6CgouLi9kcml2ZXJzL2lu
ZmluaWJhbmQvc3cvcmRtYXZ0L3FwLmM6IEluIGZ1bmN0aW9uIOKAmHJ2dF93c3NfbGxjX3NpemXi
gJk6Ci4uL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYzo4ODoyOTogZXJyb3I6IOKA
mHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg2X2NhY2hlX3Np
emXigJkKICAgODggfCAgICAgICAgIHJldHVybiBib290X2NwdV9kYXRhLng4Nl9jYWNoZV9zaXpl
OwouLi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L3FwLmM6IEluIGZ1bmN0aW9uIOKAmGNh
Y2hlbGVzc19tZW1jcHnigJk6Ci4uL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvcXAuYzox
MDA6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uIOKAmF9fY29weV91
c2VyX25vY2FjaGXigJk7IGRpZCB5b3UgbWVhbiDigJhjb3B5X3VzZXJfcGFnZeKAmT8gWy1XZXJy
b3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCiAgMTAwIHwgICAgICAgICBfX2NvcHlf
dXNlcl9ub2NhY2hlKGRzdCwgKHZvaWQgX191c2VyICopc3JjLCBuLCAwKTsKLi4vZHJpdmVycy9p
bmZpbmliYW5kL3N3L3JkbWF2dC9xcC5jOiBJbiBmdW5jdGlvbiDigJhydnRfd3NzX2xsY19zaXpl
4oCZOgouLi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L3FwLmM6ODk6MTogZXJyb3I6IGNv
bnRyb2wgcmVhY2hlcyBlbmQgb2Ygbm9uLXZvaWQgZnVuY3Rpb24gWy1XZXJyb3I9cmV0dXJuLXR5
cGVdCiAgIDg5IHwgfQoKRml4ZXM6IDY4ZjVkM2YzYjY1NCAoInVtOiBhZGQgUENJIG92ZXIgdmly
dGlvIGVtdWxhdGlvbiBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4KQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+CkNj
OiBMZW9uIFJvbWFub3Zza3kgPGxlb25Aa2VybmVsLm9yZz4KQ2M6IERlbm5pcyBEYWxlc3NhbmRy
byA8ZGVubmlzLmRhbGVzc2FuZHJvQGNvcm5lbGlzbmV0d29ya3MuY29tPgpDYzogbGludXgtcmRt
YUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IEplZmYgRGlrZSA8amRpa2VAYWRkdG9pdC5jb20+CkNjOiBS
aWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzogQW50b24gSXZhbm92IDxhbnRv
bi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgpDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNA
c2lwc29sdXRpb25zLm5ldD4KQ2M6IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKLS0tCnYy
OiByZWJhc2UgJiByZXNlbmQKCiBkcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L0tjb25maWcg
fCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L0tjb25maWcgYi9kcml2ZXJz
L2luZmluaWJhbmQvc3cvcmRtYXZ0L0tjb25maWcKLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3
L3JkbWF2dC9LY29uZmlnCisrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9zdy9yZG1hdnQvS2NvbmZp
ZwpAQCAtMiw3ICsyLDcgQEAKIGNvbmZpZyBJTkZJTklCQU5EX1JETUFWVAogCXRyaXN0YXRlICJS
RE1BIHZlcmJzIHRyYW5zcG9ydCBsaWJyYXJ5IgogCWRlcGVuZHMgb24gSU5GSU5JQkFORF9WSVJU
X0RNQQotCWRlcGVuZHMgb24gWDg2XzY0CisJZGVwZW5kcyBvbiBYODZfNjQgJiYgIVVNTAogCWRl
cGVuZHMgb24gUENJCiAJaGVscAogCVRoaXMgaXMgYSBjb21tb24gc29mdHdhcmUgdmVyYnMgcHJv
dmlkZXIgZm9yIFJETUEgbmV0d29ya3MuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==
