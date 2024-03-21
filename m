Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8772C54E68
	for <linux-um@archiver.kernel.org>; Thu, 21 Mar 2024 04:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P+vFqswTrFiOwnKkRP0vS+i0kmAsLWKOvl1Z6WpX3dY=; b=Vlo66lHw87gmwBO9uGPNYF/KvR
	P1F4wsncpFu8bwb1c66eFObDKWbiKeMfgdh4oHh7R/51PZqUK5/dalhqILwlnqNJ0iDkybSxfSDjA
	/kSq7ZUuPAjgoJgk2A3NPh1H+ytq57ejFo5uhpfQFyYLRrjNF6sBX5U8TWIiOCoPyEkQAps6tOxdU
	aPMpFq77G91kcmFWS835W4nd2i+dyBcPR899b1eINv2GeawJaV5IDXBwjpQ3viFSzoLraE5CqnUeG
	jHJ5Rkr0XFHjotG7rrjlMCXiHMC3KTWpoQZLZhlc6R9XkSRS4RjLjaE2G795wBdCvsF6OVx1tLvfK
	Qwg4lLhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnAIb-00000001qGh-2xEV;
	Thu, 21 Mar 2024 04:45:05 +0000
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnAIY-00000001qFH-1xd6
	for linux-um@lists.infradead.org;
	Thu, 21 Mar 2024 04:45:04 +0000
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-56b9dac4e6cso4448a12.1
        for <linux-um@lists.infradead.org>; Wed, 20 Mar 2024 21:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710996296; x=1711601096; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P+vFqswTrFiOwnKkRP0vS+i0kmAsLWKOvl1Z6WpX3dY=;
        b=X0XDSmH28tgaGQyHR2uWPIGMVUq/NMDEdzst0hX0hGMrzLiz9HcIBIPOScMwinZwB4
         a9RD0OuIYtGetDXyPPX/HPUzbFNQf2OsOLNf4sjN0RYXrxmbYHLArd3qL7Nxasy9AhJl
         AseN44nyMj4ed9lq7HCT0Lc5MxpojHfr7oa1QYXMN5H+8DLNQrs7oKybWkQyllbgJ4gh
         G+vCTadZRAe1bPVeotpmbTekOmAc0EX6AsGFymgJg4ZoaqNCiDNtYOCR8HrNnwzGZMVU
         ax5C4Z9ML9VEGk5ixqFZps+iGYmm20ya17KqdOkAL1PXBwaPOaXkHlgEq0YHTfwGn5im
         O8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996296; x=1711601096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+vFqswTrFiOwnKkRP0vS+i0kmAsLWKOvl1Z6WpX3dY=;
        b=YEt/GXVQ91tMog/YP+TMHNRlme5yn+ZweXoV6nRkflTrLDg92ABsQwCBepPaSkAyK7
         C+2zkKLvk+ls7nhXd5WMpZ5ev5B4siDxJTJSB6SbD1/bQgaPzmhwA0H1Ayjk4fuXQ0YR
         DZlNy8QrooPCurRXJWgsce3znksQdPtHpGLc3QhTx/PJXKXZbItEshLQUpvkuxggWLK7
         Ld1IHnsYxvA9bK5jEI5vlaDKfFTGI8X6LuTJdneQr5CMr+4QgYugmwbvTaubcJRLRhi1
         6PeJ5QDgRHiEHYAYgbVoErh2VdedKIji5+GK7rQeZfg5BtVatzhgbYgGSjCBcZbMbD6x
         i+Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVvayMwcj3Qe8pVUt4SfsO3dxTEg/6wEHgVuWeEB5DzZOCMm5qJ+G9FngFrls77zfWUBZF31VDv4xqzh+K1f2cEG4koHRX7vo/6Ue/o
X-Gm-Message-State: AOJu0YzFBvHGbem+ocEnrZi9SycCwpAnonvNJ7N71oHQSPaKS7IUUsiJ
	mUlOyg8CKxF45DINwbomBcKYIzFpRY32u2uxBvxALmFcbd72gG8oD8MYhhH87NS9VI9Y3mtjAEV
	JahSDRLsePaXSQIfvk0uOcwjUrleY35vWTFlyCTisPeOcCtifVw==
X-Google-Smtp-Source: AGHT+IHesn7qSfEB7TXcVlmCgNUBgETncAdDFxHKgSDImUR+X1aXP2XSU1L5thiOrete5cF9u50Ggl9wStXEybQCbqA=
X-Received: by 2002:aa7:d487:0:b0:56b:b472:205a with SMTP id
 b7-20020aa7d487000000b0056bb472205amr97185edr.6.1710996295878; Wed, 20 Mar
 2024 21:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
In-Reply-To: <20240223140435.1240-1-petrtesarik@huaweicloud.com>
From: David Gow <davidgow@google.com>
Date: Thu, 21 Mar 2024 12:44:42 +0800
Message-ID: <CABVgOSmNbBzR=QV4RDSdBPzBU=8mP5r0gVf5wqADm_9e9htM2g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/1] um: oops on accessing a non-present page in
 the vmalloc area
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	"open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000076e68e0614245eba"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240320_214502_548200_FE3A5633 
X-CRM114-Status: GOOD (  27.72  )
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

--00000000000076e68e0614245eba
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 22:07, Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
>
> From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
>
> If a segmentation fault is caused by accessing an address in the vmalloc
> area, check that the target page is present.
>
> Currently, if the kernel hits a guard page in the vmalloc area, UML blindly
> assumes that the fault is caused by a stale mapping and will be fixed by
> flush_tlb_kernel_vm(). Unsurprisingly, if the fault is caused by accessing
> a guard page, no mapping is created, and when the faulting instruction is
> restarted, it will cause exactly the same fault again, effectively creating
> an infinite loop.
>
> Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> ---
>  arch/um/kernel/trap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index 6d8ae86ae978..d5b85f1bfe33 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -206,11 +206,15 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>         int err;
>         int is_write = FAULT_WRITE(fi);
>         unsigned long address = FAULT_ADDRESS(fi);
> +       pte_t *pte;
>
>         if (!is_user && regs)
>                 current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>
>         if (!is_user && (address >= start_vm) && (address < end_vm)) {
> +               pte = virt_to_pte(&init_mm, address);
> +               if (!pte_present(*pte))
> +                       page_fault_oops(regs, address, ip);

page_fault_oops() appears to be private to arch/x86/mm/fault.c, so
can't be used here?
Also, it accepts struct pt_regs*, not struct uml_pt_regs*, so would
need to at least handle the type difference here.

Could we equally avoid the infinite loop here by putting the
'flush_tlb_kernel_vm();goto out;' behind a if (pte_present(...))
check, and let the rest of the UML checks panic or oops if required.
(Actually OOPSing where we can under UML would be nice to do at some
point anyway, but is a bigger issue than just fixing a bug, IMO.)

Or am I lacking a prerequisite patch or applying this to the wrong
version (or otherwise missing something), as it definitely doesn't
build here.

Cheers,
-- David

--00000000000076e68e0614245eba
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
7xDrOPfX3COqq162RFg/MFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AK0lDd6/eSh3qHmXaw1YUfIFy07B25BEcTvWgOdla99gF1O7sOsdYaTz/DFkZI5ghjgaPJCovgla
mRMfNcxZCfoBtsB7mAS6iOYjuwFOZxi9cv6jhfiON6b89QWdMaPeDddg/F2Q0bxZ9Z2ZEBxyT34G
wlDp+1p6RAqlDpHifQJW16h5jWIIwYisvm5QyfxQEVc+XH1lt+taSzCfiBT0ZLgjB9Sg+zAo8ys6
5PHxFaT2a5Td/fj5yJ5hRSrqy/nj/hjT14w3/ZdX5uWg+cus6VjiiR/5qGSZRjHt8JoApD6t6/tg
ITv8ZEy6ByumbU23nkHTMOzzQSxczHkT+0q10/MxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAHS+TgZvH/tCq5FcDC0n9IwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIEPCKOZW5Q0pn0dDn8fB0Mo26dbP0mF3LzF/XY4ibw27MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMyMTA0NDQ1NlowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDOJz1t
ydgg1WFpIzPw4lczlVQVyAvSV9QHBIbrDAfEMHdti5+O1BFy1V3O0L1lYzewkWa83cbA0gCZbcrs
AdUjpQzIACd1Tx90x0cxSoB45VpdBIh9neKTFgDZz0px6U2nsIsBZ+ltdTgHYZkd6r7yG8Yj/BWY
wmf0UaAIGhmkPJY+8l0IZW+i9eHGxwImi1G9sLnjWpgXShl1F7Fp8Hy7jtaPLf5jXPLehPnAyGJn
us31cwXRaQaSwF+3YEVOdCalcbvD2NGf6U7bf+YeJDYu2K+SGHC/SFa7/WbI0mgPMTwt804bK7gp
WhOnDDDrC9bW8LG0mKuIJoYsK9E8EVul
--00000000000076e68e0614245eba--

