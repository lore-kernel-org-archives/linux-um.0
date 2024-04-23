Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140E1C04FF8
	for <linux-um@archiver.kernel.org>; Tue, 23 Apr 2024 09:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCgGer30rG2OLWSsx+p0e0UBTvYVCl16RxGYeSzOhrA=; b=iYiBoLobY8rlMY93Iat9nqDGu3
	LNzB5sRiW8zldnM8mh3l2SygUCylQaJLcs+ILtxj14OgDa3Vvr0DF0LHtBRs6q85xpsGZkn2JwuuC
	oA7dZ3SdXe8APH86LdlneyxwMyaYbJW0UsIJIEY1RxklIgChP8LkA7eZC4/QFdaIfHvl9r/jJpjNE
	/QpDVeZD5Wn2aKkIvJTnTxFNZeTeil0/W7rkyLlV6QQVHcMOJrAM2zW3jDkp2KSPzjxWIcz6fvz+z
	QQIsTQSz2dgLAAcnQDXKg5jWiXM4SZQnhMKyOavoY324ErStz20SSV+z+KAGpjgL1DYAfvYsljflJ
	N8p1bpUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzCMO-0000000Gehd-2aX9;
	Tue, 23 Apr 2024 09:22:44 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzCML-0000000GefP-0Gt8
	for linux-um@lists.infradead.org;
	Tue, 23 Apr 2024 09:22:42 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-439b1c72676so301201cf.1
        for <linux-um@lists.infradead.org>; Tue, 23 Apr 2024 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713864158; x=1714468958; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCgGer30rG2OLWSsx+p0e0UBTvYVCl16RxGYeSzOhrA=;
        b=n/ZizZiDv+VmfQTxhR8Ggrud9+zXgFkwWjHOhXY2K4APZ6xwG1qQWjr9O96XtRt/cB
         JPZ8qLuZmzqh2k3gwZ+455xVZrilDkPX+p1UZYNrmxW02BWHVJSU3NDpQgPzLYOOVoWO
         tEsyhQRuZ+Lrd9DLZddiQeMG0XdvEYGE3ukdq5dmXSVc+N2wSiL2HSq3QPT97ZRO9tCu
         0JGnxF+baEE2tRmI4kqClOX3d/ixP7vSoJRwbHWGGStban7mtVOm/TKXYr9xFJN5nbFj
         vkATNAVYqjMuxDUbN86XwowRQ973lmAjEXTN330ePokUWcNGh/c2O0qrKHMn3LDw6JcM
         TcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713864158; x=1714468958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCgGer30rG2OLWSsx+p0e0UBTvYVCl16RxGYeSzOhrA=;
        b=ZJDsCjxclxOPubE2rCyHsoUxg1UljTsPUvec9hKfyWz5fruEM5o3kV7jpNz87V3nCG
         Z0vGrhy5E0OFCR3mJdVsqyP463zInSQEJSzKCcSb+dB+lJEAVOzStN52PHHLoIDlCASm
         P+PcL4vYWw5P174GSn4WC2pq54Nf8YZionRR2t7yMKu4Ww2x62ffdpqWlQKXiLLseY5c
         bMDBoBexYygDk1P92HO20A+VIrYg+NJSMW9rGH+bMsiQVM/1WCaDDCQY6cm7ZNc1CWlg
         GF1uQOJX6C2Ykm7/Xjwr2/ErN4V/YUSeY6K5FKICTRLnpFpRscN0dsLV7MngBA+cEFno
         dPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCURwswRwVNDLPXxUoVXXoFBrEPSnkHRbzcfFV+V+3pNQEGVL5n3AFKJWjo8G1mkXuK0+5YsmUdKXyda+2HM9lDwxedJ6hGprXN/yjwm
X-Gm-Message-State: AOJu0YxLCZ2zkLavknkXSTUmr9FWx5kh8E4/im9/ZibU5pz9sic6i+CC
	H49GwlxQKcCwkyfKrjqAVdHzCTbouXfvmE7/YIcvnYTKYUrELGcYg3L/n2zJ457+vu0ZSYyK02i
	ijiEXqGcIn+FlJmIyqZQgmnsjEpoSBNBn5kE3
X-Google-Smtp-Source: AGHT+IHUVImZr46KE7NjLsb4voeWSuhmpLmq8uDA7LeYXKhI00U6dSCZBVehDUFO7fu/ApIxReC1GPQBk/y0xeNhlH0=
X-Received: by 2002:ac8:6682:0:b0:439:891f:bbd2 with SMTP id
 d2-20020ac86682000000b00439891fbbd2mr232880qtp.28.1713864158511; Tue, 23 Apr
 2024 02:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240319104857.70783-1-mic@digikod.net> <20240319104857.70783-8-mic@digikod.net>
 <928249cc-e027-4f7f-b43f-502f99a1ea63@roeck-us.net> <b70332b0-3e55-4375-935f-35ef3167a151@roeck-us.net>
 <20240422.thesh7quoo0U@digikod.net> <a0179848-99a2-4169-b7b2-1a8cddb27615@roeck-us.net>
In-Reply-To: <a0179848-99a2-4169-b7b2-1a8cddb27615@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Tue, 23 Apr 2024 17:22:24 +0800
Message-ID: <CABVgOS=MOaWhUwVb2Rp2JDTK9=qX_p2SDZp7ZAj+03isZps9iA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] kunit: Add tests for fault
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <keescook@chromium.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marco Pagani <marpagan@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Thara Gopinath <tgopinath@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Zahra Tarkhani <ztarkhani@microsoft.com>, kvm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-um@lists.infradead.org, x86@kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006325580616c018b6"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240423_022241_202366_8955AC1A 
X-CRM114-Status: GOOD (  33.49  )
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

--0000000000006325580616c018b6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 at 21:36, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 4/22/24 06:08, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Fri, Apr 19, 2024 at 04:38:01PM -0700, Guenter Roeck wrote:
> >> On Fri, Apr 19, 2024 at 03:33:49PM -0700, Guenter Roeck wrote:
> >>> Hi,
> >>>
> >>> On Tue, Mar 19, 2024 at 11:48:57AM +0100, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> >>>> Add a test case to check NULL pointer dereference and make sure it w=
ould
> >>>> result as a failed test.
> >>>>
> >>>> The full kunit_fault test suite is marked as skipped when run on UML
> >>>> because it would result to a kernel panic.
> >>>>
> >>>> Tested with:
> >>>> ./tools/testing/kunit/kunit.py run --arch x86_64 kunit_fault
> >>>> ./tools/testing/kunit/kunit.py run --arch arm64 \
> >>>>    --cross_compile=3Daarch64-linux-gnu- kunit_fault
> >>>>
> >>>
> >>> What is the rationale for adding those tests unconditionally whenever
> >>> CONFIG_KUNIT_TEST is enabled ? This completely messes up my test syst=
em
> >>> because it concludes that it is pointless to continue testing
> >>> after the "Unable to handle kernel NULL pointer dereference" backtrac=
e.
> >>> At the same time, it is all or nothing, meaning I can not disable
> >>> it but still run other kunit tests.
> >>>
> >
> > CONFIG_KUNIT_TEST is to test KUnit itself.  Why does this messes up you=
r
> > test system, and what is your test system?  Is it related to the kernel
> > warning and then the message you previously sent?
>
> It is not a warning, it is a BUG which terminates the affected kernel thr=
ead.
> NULL pointer dereferences are normally fatal, which is why I abort tests
> if one is encountered. I am not going to start introducing code into my
> scripts to ignore such warnings (or BUG messages) on a case by case basis=
;
> this would be unmaintainable.
>
> > https://lore.kernel.org/r/fd604ae0-5630-4745-acf2-1e51c69cf0c0@roeck-us=
.net
> > It seems David has a solution to suppress such warning.
> >
>
> I don't think so. My series tried to suppress warning backtraces, not BUG
> messages. BUG messages can not easily be suppressed since the reaction is
> architecture specific and typically fatal.
>
> As I said below, never mind, I just disabled CONFIG_KUNIT_TEST in my test=
ing.
>
> Guenter
>

I think it probably makes sense to permit disabling the fault tests
independently, at least until we have a way of suppressing the
warnings.

I've sent out a patch to add a CONFIG_KUNIT_FAULT_TEST option to
disable these tests. Would that help?
https://lore.kernel.org/linux-kselftest/20240423090808.242389-1-davidgow@go=
ogle.com/

(The other option is to split the tests out into a totally separate
file / module. I think that's an option (and would make the config
option more consistent with other test options) but since they're
otherwise part of the KUnit tests, I think I prefer to keep them
together.)

Cheers,
-- David

--0000000000006325580616c018b6
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
hvcNAQkEMSIEICOgtZbnjNPnp0XK9jkyAuFSQkAiQFiPF/waq0dMweU1MBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyMzA5MjIzOFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCLzff9
FDeDetOWvy6uoOdJnlb25fbO6q5RHkefp+asUsi42FPODqn3EfHQdwwl4+C+keK704m9Y6zGgg4T
0vxixRA/BtSXwbM8Fl6Df200ElutWw3ljz5zva1NfMfAx2CNpDgHNtbAmEOhYUYd+VGOxVVlCOOk
0gsqxi6xHO2Yxbyf0Wkz6fPhz3TyElZQUrHt/Jim/6rNIaDHAlKzp34cdFdWdsIu9R+eJSazQHy0
ruGHCF3+zW0TxdeWINQJE/W2WKrLUAUhBQgatT1cAY5aMozV35d8JLYMiZ1m/Ft57btFmiR78bxn
aX+P2Imbjr5ryox6Ves599tT+j+e7/kq
--0000000000006325580616c018b6--

