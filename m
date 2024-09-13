Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7AAFA3730
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 08:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+QQTqN1HrEaTSOTqHo8iQv7M3dTJMrpJy9JCMkqk80=; b=mBGeN0gL6ueTjwylTh9slqMfBb
	yn3DrTi03E5z7VG2w0dK8yJzCD7X4pDpLxdhns9gNkiF9NlpxeT/tQKWgT9v+whu0M+curcTh7Rd7
	/RUX/hNmoppvJm6/Wszx15g7+xW384nJ0uLt6Ym/3gs0H6szZQRL/NH9EFQCTwY9Dd7T22u0YOLWN
	DK7FpS1m2hfxlXtBYyycrTgTKXKljIaFfJ2DjxCEmulESPgspZWEepaRErCRv4NfZvjWP4tljjjQL
	pkbosemcaM5Yg+xUhQDt5daHEwFXcD0Q51sDHXqDFuAx7VWd8CqpkocXpeRiDtYNTtGMF66lXfBLw
	aWOiEogw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1vO-0000000FO7X-2Q82;
	Fri, 13 Sep 2024 08:45:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp1vM-0000000FO79-31Vn
	for linux-um@bombadil.infradead.org;
	Fri, 13 Sep 2024 08:45:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B+QQTqN1HrEaTSOTqHo8iQv7M3dTJMrpJy9JCMkqk80=; b=GjPzSF56Qm5BQRMWvjQzk9hslC
	w4v32Vcna4IRgQodLQKdctxEZdIdHeYJjqCWvXFrRSnCwqOTQPoNugoLTxsRbuDCfER0Us0vi8dUo
	1S2fy6gE2oE2m4NB/ivH8G4x2xxD/nN96Aau+o/aUaLRDBeXVgjaX8NnW7nOlPV0zJ2Cr0p+1aIyS
	fxzTi3DdWSL5mlHxOG5IJ7r1Z2rcmCy0NwY1zvZrQ9TRA0rUC9lTPnT1+6ujrwJxIzEmOvCgBYRLS
	etFHjFpv7bVezIniBRHS8grfpBTpcLDZIJqubkIzaRpAYgfe7eJAit9TYRYtOXhm/mBW7ItVU/Bw8
	+gWpXvJg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sp1vH-00000000cll-28zz
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 08:45:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Content-Transfer-Encoding:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=B+QQTqN1HrEaTSOTqHo8iQv7M3dTJMrpJy9JCMkqk80=; t=1726217097; x=1727426697; 
	b=w44VHRc4+kYH/VVLNUHbUWJ/BZUAApntuG9EFq8jx9mp7BwuvvzhagJnimdJSeUq5Xfk30vLC4Z
	7QWxYNmV8L1CxCl7v+dKrTihS4R8sywLCIlqoodNvHMUZezWuD+TSIfg92KqQaWMj1SFMmR8FZoDp
	OdL/Pdtn5tQyESq/EmBdmXP6FGzx2LBcnVem5oNtyjbg8NlXOcY3FvHcXr8DdWSK4NvTFuT8w+oQ7
	F/VZhcDfIB0MhR10VHjy/bTwT4KlsLdvGEMYQ/YJ09u9bom8wsbyl1246Xd6JZVN8+8rL9a64IlQI
	H56JLXnjTQycmdNjU6TCSkOp+ku/Zqmh5jGQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sp1tE-0000000Fpoi-2pSr;
	Fri, 13 Sep 2024 10:42:53 +0200
Message-ID: <48731e0f0d956a00518bb635b122c0937962be50.camel@sipsolutions.net>
Subject: Re: [PATCH] um: always use the internal copy of the FP registers
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>
Date: Fri, 13 Sep 2024 10:42:50 +0200
In-Reply-To: <20240913082244.767799-1-benjamin@sipsolutions.net>
References: <20240913082244.767799-1-benjamin@sipsolutions.net>
Content-Type: multipart/mixed; boundary="=-F+7tBXuZ/jXTslE71BKc"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-malware-bazaar-2: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_094459_896049_B4EAE951 
X-CRM114-Status: GOOD (  17.43  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--=-F+7tBXuZ/jXTslE71BKc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-09-13 at 10:22 +0200, Benjamin Berg wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
>=20
> When switching from userspace to the kernel, all registers including the
> FP registers are copied into the kernel and restored later on. As such,
> the true source for the FP register state is actually already in the
> kernel and they should never be grabbed from the userspace process.
>=20
> Change the various places to simply copy the data from the internal FP
> register storage area. Note that on i386 the format of PTRACE_GETFPREGS
> and PTRACE_GETFPXREGS is different enough that conversion would be
> needed. With this patch, -EINVAL is returned if the non-native format is
> requested.
>=20
> The upside is, that this patchset fixes setting registers via ptrace
> (which simply did not work before) as well as fixing setting floating
> point registers using the mcontext on signal return on i386.
>=20
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

Hi,

I did test this mcontext restore and ptrace register setting both on
i386 and x86_64 using the attached program.

Benjamin

--=-F+7tBXuZ/jXTslE71BKc
Content-Disposition: attachment; filename="test-signal-restore.c"
Content-Transfer-Encoding: base64
Content-Type: text/x-csrc; name="test-signal-restore.c"; charset="UTF-8"

LyoKICogZ2NjIHRlc3Qtc2lnbmFsLXJlc3RvcmUuYyAtbyB0ZXN0LXNpZ25hbC1yZXN0b3JlLWFt
ZDY0CiAqIGdjYyAtbTMyIC1tYXJjaD1pNjg2IC1sbSB0ZXN0LXNpZ25hbC1yZXN0b3JlLmMgLW8g
dGVzdC1zaWduYWwtcmVzdG9yZS1pMzg2CiAqLwoKI2luY2x1ZGUgPG1hdGguaD4KI2luY2x1ZGUg
PHN0ZGlvLmg+CiNpbmNsdWRlIDxzaWduYWwuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVk
ZSA8c3lzL21tYW4uaD4KI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiNpbmNsdWRlIDxlcnJuby5oPgoj
aW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxzeXMvcHRyYWNlLmg+CiNpbmNsdWRlIDxzeXMv
dXNlci5oPgojaW5jbHVkZSA8YXNtL3VuaXN0ZC5oPgoKI2RlZmluZSBTVDBfRVhQX0FERCAxMAoK
dm9pZCAqc2NyYXRjaF9wYWdlOwoKdm9pZCBzaWdoYW5kbGVyKGludCBzaWcsIHNpZ2luZm9fdCAq
aW5mbywgdm9pZCAqcCkKewoJdWNvbnRleHRfdCAqdWMgPSBwOwoKCXByaW50Zigic2lnaGFuZGxl
clxuIik7CgoJdWMtPnVjX21jb250ZXh0LmZwcmVncy0+X3N0WzBdLmV4cG9uZW50ICs9IFNUMF9F
WFBfQUREOwp9CgppbnQgdGVzdF9mcCgpCnsKCWRvdWJsZSBudW0gPSAwLjU7Cglsb25nIHJldDsK
CglwcmludGYoInByZS1zaWduYWw6ICVnXG4iLCBudW0pOwoJLyoKCSAqIFRoaXMgZG9lcyBraWxs
KGdldHBpZCgpLCBTSUdVU1IxKTsgd2l0aCAibnVtIiBiZWluZyBwYXNzZWQgaW4gQU5ECgkgKiBv
dXQgb2YgdGhlIGZsb2F0aW5nIHBvaW50IHN0YWNrLiBXZSBjYW4gdGhlcmVmb3JlIG1vZGlmeSBu
dW0gYnkKCSAqIGNoYW5naW5nIHN0WzBdIHdoZW4gaGFuZGxpbmcgdGhlIHNpZ25hbC4KCSAqLwoj
aWZkZWYgX19pMzg2X18KCWFzbSB2b2xhdGlsZSAoCgkJImludCAkMHg4MDsiCgkJOiAiPXQiIChu
dW0pLCAiPWEiIChyZXQpCgkJOiAiMCIgKG51bSksICIxIiAoX19OUl9raWxsKSwgImIiIChnZXRw
aWQoKSksICJjIiAoU0lHVVNSMSkgOiApOwojZWxzZQoJYXNtIHZvbGF0aWxlICgKCQkic3lzY2Fs
bDsiCgkJOiAiPXQiIChudW0pLCAiPWEiIChyZXQpCgkJOiAiMCIgKG51bSksICIxIiAoX19OUl9r
aWxsKSwgIkQiIChnZXRwaWQoKSksICJTIiAoU0lHVVNSMSkgOiAicjExIiwgInJjeCIpOwojZW5k
aWYKCXByaW50ZigicG9zdC1zaWduYWw6ICVnXG4iLCBudW0pOwoKCWlmIChudW0gIT0gcG93KDIs
IFNUMF9FWFBfQUREIC0gMSkpIHsKCQlwcmludGYoImZsb2F0aW5nIHBvaW50IHJlZ2lzdGVyIHdh
cyBub3QgbWFuaXB1bGF0ZWRcbiIpOwoJCXJldHVybiAxOwoJfQoKCXJldHVybiAwOwp9CgppbnQg
dGVzdF9mcF9wdHJhY2UoaW50IGZweCkKewoJaW50IHBpZCwgc3RhdHVzLCByZXQ7CgoJcGlkID0g
Zm9yaygpOwoJaWYgKHBpZCA8IDApCgkJcmV0dXJuIDEyNzsKCglpZiAocGlkID09IDApIHsKCQkv
KiBjaGlsZCAqLwoJCXB0cmFjZShQVFJBQ0VfVFJBQ0VNRSwgMCwgMCwgMCk7CgkJa2lsbChnZXRw
aWQoKSwgU0lHU1RPUCk7CgkJCgkJaWYgKHRlc3RfZnAoKSkKCQkJZXhpdCgxKTsKCgkJZXhpdCgw
KTsKCX0KCgkvKiBXYWl0IGZvciBjaGlsZCB0byBzdG9wIGl0c2VsZiAqLwoJZG8gewoJCXJldCA9
IHdhaXRwaWQocGlkLCAmc3RhdHVzLCAwKTsKCX0gd2hpbGUgKHJldCA8IDAgJiYgZXJybm8gPT0g
RUlOVFIpOwoJaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCgkJcmV0dXJuIDEyNzsKCgkvKiBDb250
aW51ZSB1bnRpbCBTSUdVU1IxIHRvIHNlbGYgKi8KCXB0cmFjZShQVFJBQ0VfQ09OVCwgcGlkLCBO
VUxMLCAwKTsKCWRvIHsKCQlyZXQgPSB3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7Cgl9IHdoaWxl
IChyZXQgPCAwICYmIGVycm5vID09IEVJTlRSKTsKCWlmICghV0lGU1RPUFBFRChzdGF0dXMpKQoJ
CXJldHVybiAxMjc7CgoJaWYgKGZweCkgewojaWZkZWYgX19pMzg2X18KCQlzdHJ1Y3QgdXNlcl9m
cHhyZWdzX3N0cnVjdCAqZnBzdGF0ZTsKCQkjZGVmaW5lIGZwX3JlZ190eXBlIHN0cnVjdCBfbGli
Y19mcHJlZwoJCWZwc3RhdGUgPSBzY3JhdGNoX3BhZ2UgKyA0MDk2IC0gc2l6ZW9mKCpmcHN0YXRl
KTsKCgkJaWYgKHB0cmFjZShQVFJBQ0VfR0VURlBYUkVHUywgcGlkLCBOVUxMLCBmcHN0YXRlKSkg
ewoJCQlraWxsKHBpZCwgU0lHS0lMTCk7CgkJCWlmIChlcnJubyA9PSBFSU5WQUwpIHsKCQkJCXBy
aW50ZigiR2V0dGluZyBGUFggcmVncyBub3Qgc3VwcG9ydGVkXG4iKTsKCQkJCXJldHVybiAwOwoJ
CQl9IGVsc2UgewoJCQkJcHJpbnRmKCJFcnJvciBnZXR0aW5nIEZQWCByZWdzOiAlZFxuIiwgZXJy
bm8pOwoJCQkJcmV0dXJuIDEyNzsKCQkJfQoJCX0KCQkoKGZwX3JlZ190eXBlKikmZnBzdGF0ZS0+
c3Rfc3BhY2VbMF0pLT5leHBvbmVudCArPSBTVDBfRVhQX0FERDsKCQlpZiAocHRyYWNlKFBUUkFD
RV9TRVRGUFhSRUdTLCBwaWQsIE5VTEwsIGZwc3RhdGUpKQoJCQlyZXR1cm4gMTI3OwojZWxzZQoJ
CXByaW50ZigiTm8gRlBYUkVHUyBvbiB4ODZfNjRcbiIpOwoJCWtpbGwocGlkLCBTSUdLSUxMKTsK
CQlyZXR1cm4gMTI3OwojZW5kaWYKCX0gZWxzZSB7CgkJc3RydWN0IF9saWJjX2Zwc3RhdGUgKmZw
c3RhdGU7CgkJZnBzdGF0ZSA9IHNjcmF0Y2hfcGFnZSArIDQwOTYgLSBzaXplb2YoKmZwc3RhdGUp
OwoKCQlpZiAocHRyYWNlKFBUUkFDRV9HRVRGUFJFR1MsIHBpZCwgTlVMTCwgZnBzdGF0ZSkpIHsK
CQkJa2lsbChwaWQsIFNJR0tJTEwpOwoJCQlpZiAoZXJybm8gPT0gRUlOVkFMKSB7CgkJCQlwcmlu
dGYoIkdldHRpbmcgRlBYIHJlZ3Mgbm90IHN1cHBvcnRlZFxuIik7CgkJCQlyZXR1cm4gMDsKCQkJ
fSBlbHNlIHsKCQkJCXByaW50ZigiRXJyb3IgZ2V0dGluZyBGUFggcmVnczogJWRcbiIsIGVycm5v
KTsKCQkJCXJldHVybiAxMjc7CgkJCX0KCQl9CgkJZnBzdGF0ZS0+X3N0WzBdLmV4cG9uZW50ICs9
IFNUMF9FWFBfQUREOwoJCWlmIChwdHJhY2UoUFRSQUNFX1NFVEZQUkVHUywgcGlkLCBOVUxMLCBm
cHN0YXRlKSkKCQkJcmV0dXJuIDEyNzsKCX0KCgkvKiBSdW4gdW50aWwgY29tcGxldGlvbiAod2l0
aG91dCBoYW5kbGluZyB0aGUgc2lnbmFsKSAqLwoJcHRyYWNlKFBUUkFDRV9DT05ULCBwaWQsIE5V
TEwsIDApOwoJZG8gewoJCXJldCA9IHdhaXRwaWQocGlkLCAmc3RhdHVzLCAwKTsKCX0gd2hpbGUg
KHJldCA8IDAgJiYgZXJybm8gPT0gRUlOVFIpOwoKCWlmICghV0lGRVhJVEVEKHN0YXR1cykpCgkJ
cmV0dXJuIDEyNzsKCglyZXR1cm4gV0VYSVRTVEFUVVMoc3RhdHVzKTsKfQoKaW50IG1haW4oKQp7
CglzdHJ1Y3Qgc2lnYWN0aW9uIHNhID0gewoJCS5zYV9mbGFncyA9IFNBX1NJR0lORk8sCgkJLnNh
X2hhbmRsZXIgPSAodm9pZCAoKikoaW50KSlzaWdoYW5kbGVyLAoJfTsKCWludCByZXQ7CgoJc2Ny
YXRjaF9wYWdlID0gbW1hcChOVUxMLCA4MTkyLCBQUk9UX1JFQUQgfCBQUk9UX1dSSVRFLCBNQVBf
UFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsKCW11bm1hcChzY3JhdGNoX3BhZ2UgKyA0
MDk2LCA0MDk2KTsKCglzaWdhY3Rpb24oU0lHVVNSMSwgJnNhLCBOVUxMKTsKCglpZiAodGVzdF9m
cCgpKQoJCXJldHVybiAxOwoKCXNhLnNhX2hhbmRsZXIgPSBTSUdfREZMOwoJc2lnYWN0aW9uKFNJ
R1VTUjEsICZzYSwgTlVMTCk7CgoJcHJpbnRmKCJcbm1vZGlmeSB1c2luZyBwdHJhY2UgUFRSQUNF
X0dFVEZQUkVHUyBpbnN0ZWFkIG9mIHNpZ2hhbmRsZXI6XG4iKTsKCXJldCA9IHRlc3RfZnBfcHRy
YWNlKDApOwoJaWYgKHJldCkKCQlyZXR1cm4gcmV0OwoKI2lmZGVmIF9faTM4Nl9fCglwcmludGYo
IlxubW9kaWZ5IHVzaW5nIHB0cmFjZSBQVFJBQ0VfR0VURlBYUkVHUyBpbnN0ZWFkIG9mIHNpZ2hh
bmRsZXI6XG4iKTsKCXJldCA9IHRlc3RfZnBfcHRyYWNlKDEpOwoJaWYgKHJldCkKCQlyZXR1cm4g
cmV0OwojZW5kaWYKCglyZXR1cm4gMDsKfQo=


--=-F+7tBXuZ/jXTslE71BKc--

