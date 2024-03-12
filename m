Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BD5C54E49
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 04:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AgcyjIukuOPqFaJgiJ+gs4s8z4t+pJoTeZIpFZLJFjk=; b=vTocHiNPITDnzULTfuVT5t1JRG
	gK7mkCJ192oel4u83gdgWMCs2jODsWRUfQ1PZjfMJRcj5SdAyACOeTHV5fZBZUb0SruR0ikcCUlbm
	oV+I5wjeeMlb8B0cutcRFXUca64hlGtP6fgmBoerbUjz/mnAYQ6+f9w9WVGcjuHc7KIn+K9eGmS66
	0q8UztZ0o6w4Xkf4xRlcklksuUO3WoVGXa5Sq+kkLRPhSZLMySEDvalKFdqIyce0lateX5/8NzMO4
	Z+cMlUj4j3HQjc6ckEnZ1i5ka0hwh/6Gfr3KGnY7v21d771jgG3NGHjWwTDaBE9mgkYksSsIc0z1T
	QwjI0N4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjuA5-00000004KIy-2v02;
	Tue, 12 Mar 2024 04:54:49 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjuA2-00000004KHU-22lJ
	for linux-um@lists.infradead.org;
	Tue, 12 Mar 2024 04:54:48 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso3753a12.1
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 21:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219284; x=1710824084; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AgcyjIukuOPqFaJgiJ+gs4s8z4t+pJoTeZIpFZLJFjk=;
        b=YfOW3H4lwKc3FCRqKQSkj727k4uCFXck7JrzQqVRoWIy0LZqFFL/Hn1HHNFW5MczRe
         gulUEK+/ySGJUDwNw9jfbnt6foeU8+AFhxry+1+ZQJVfXA1NqZDEFrFn/qh5cB/EsRg4
         78woMGeSJSQBEPxC9jNZ2nn0ib00/F/7qWTpj3tlFijfC4V1R7VD4MJDXNCLJFxCDkEk
         sM2IUIjuMSrHm5Prnovy1mJtiiKgvYn/+ColnVWFGPi2BeNcCvsjivzWXDSJtkg4T8T7
         0Q94f0BoqJPSKUYUGhhcNnL1VhLHyB6iZcDketrD3qf8FNfnLb0v25CPpRBNtWcDqJ+3
         TFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219284; x=1710824084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AgcyjIukuOPqFaJgiJ+gs4s8z4t+pJoTeZIpFZLJFjk=;
        b=DMS9OHde/ARBOsm2nTHyWXwE4UXEmMCTBvYnGayaFJUsleD5fU67DfIu0QVWYwvppJ
         chtFiwb0y9xo0FTK0T/K0bTxrfUKpwloFZMciBClWuwgHq0uwrKwDh3wM0SZtrSr9b22
         +Pnjxh6Ln1gOYFCdM+1vloTlVsg5I07fnotxRnPP9MDtKtSV4HM0dvLLedDaPDHFyhew
         H2ghpo9x9U7OC1yYiFlhZrSWZe0M0juU09EuyQivQ/EbpRZHivbqbmdWQm51ciUU8aZF
         /0fzMzbXiGJB3A75o24+GPlehA/qOWkK9OCbyL/9jvmHVTVCriRSVlyO5i6EvtPZS+iy
         qGVg==
X-Forwarded-Encrypted: i=1; AJvYcCUG2Nn9NVxc0Yn5HVyZIUmyrRgYLGSlY/yvUquv3XC06JDvWIWRmmGXLEmfPRHTRZ+LolKu40lU0y3Z36VuVP1diMjoUvybGOE2dNtB
X-Gm-Message-State: AOJu0YxGzWSFHcC2h4Aq9/FvgznfMnYEqD6J5fa/GYcca8BQU7qhtyZg
	0CrlNv1GzPwQIZNdoCJfDMOnYWwrg8mRVE07VjxhNF+wmuk38YARUV8mzB9PN6xYHSNr0pxvPmI
	8XxgCFFSJ5mcraJFmvCFhNyLpbLiCGuCH8UVZ
X-Google-Smtp-Source: AGHT+IHMvpeCp94H9+CQpRLnJE1D5gDLC9RFj181IDRLKbMYyc3PKjlVy1+AZvJ+pPL6yiwer/hG6jBTxxW66UEzA90=
X-Received: by 2002:a05:6402:8c5:b0:568:7767:14fd with SMTP id
 d5-20020a05640208c500b00568776714fdmr12186edz.7.1710219283993; Mon, 11 Mar
 2024 21:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-6-mic@digikod.net>
In-Reply-To: <20240301194037.532117-6-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 12:54:32 +0800
Message-ID: <CABVgOS=AkKYjEuzrTGEh_AwMYZ0kmYz-uXsNKW--ExSCae6pVw@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] kunit: Fix KUNIT_SUCCESS() calls in iov_iter tests
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Brendan Higgins <brendanhiggins@google.com>, Kees Cook <keescook@chromium.org>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, James Morris <jamorris@linux.microsoft.com>, 
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
	boundary="000000000000f0605f06136f741d"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_215446_562929_ACBBA5C2 
X-CRM114-Status: GOOD (  22.47  )
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

--000000000000f0605f06136f741d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> Fix KUNIT_SUCCESS() calls to pass a test argument.
>
> This is a no-op for now because this macro does nothing, but it will be
> required for the next commit.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-6-mic@digikod.net
> ---

This is a pretty straightforward fix.

I'm actually a bit surprised how many tests were actually using
KUNIT_SUCCEEDED().

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


-- David


>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit_iov_iter.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
> index 859b67c4d697..27e0c8ee71d8 100644
> --- a/lib/kunit_iov_iter.c
> +++ b/lib/kunit_iov_iter.c
> @@ -139,7 +139,7 @@ static void __init iov_kunit_copy_to_kvec(struct kuni=
t *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -194,7 +194,7 @@ static void __init iov_kunit_copy_from_kvec(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  struct bvec_test_range {
> @@ -302,7 +302,7 @@ static void __init iov_kunit_copy_to_bvec(struct kuni=
t *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -359,7 +359,7 @@ static void __init iov_kunit_copy_from_bvec(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  static void iov_kunit_destroy_xarray(void *data)
> @@ -453,7 +453,7 @@ static void __init iov_kunit_copy_to_xarray(struct ku=
nit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -516,7 +516,7 @@ static void __init iov_kunit_copy_from_xarray(struct =
kunit *test)
>                         return;
>         }
>
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -596,7 +596,7 @@ static void __init iov_kunit_extract_pages_kvec(struc=
t kunit *test)
>  stop:
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_EQ(test, iter.count, 0);
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -674,7 +674,7 @@ static void __init iov_kunit_extract_pages_bvec(struc=
t kunit *test)
>  stop:
>         KUNIT_EXPECT_EQ(test, size, 0);
>         KUNIT_EXPECT_EQ(test, iter.count, 0);
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  /*
> @@ -753,7 +753,7 @@ static void __init iov_kunit_extract_pages_xarray(str=
uct kunit *test)
>         }
>
>  stop:
> -       KUNIT_SUCCEED();
> +       KUNIT_SUCCEED(test);
>  }
>
>  static struct kunit_case __refdata iov_kunit_cases[] =3D {
> --
> 2.44.0
>

--000000000000f0605f06136f741d
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
hvcNAQkEMSIEIAwntcAOUrRJsRZBbycG7e3AU2cSN+1k0xuF7otav2ZJMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA0NTQ0NFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQC0xxcO
XomfL4QL28VwieN1Zwu6fNNGL2lKjrw5Ic+ujk7USwQ8l44k8mf3ALzeWRTC+6XIUgALpIBBgcY7
zxL8qJ4S88QxYxLaR1OXTbvCHLzLTK+/otuiVhDObaPmLJfwjXLJdOuWkMpdUXSeHq3nBTtfCPCK
SzuXKTwChdfVEtfYHnoO8hAkeOrvQkYMbKF4P9XfcDbwjwOWc4+im09Dt0TsrgEer7zhKgZTfOJk
JUzlCIlFbO2oMwSBWLhKYSljBy0orUOM4yj497a18ncWzsNLHWUW57bQA88lvPrcN3brR1ZWd+Xn
1q+/SpjDK4YFoH/sNKy+M/DAo1VeBFFR
--000000000000f0605f06136f741d--

