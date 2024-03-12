Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452D5C54E49
	for <linux-um@archiver.kernel.org>; Tue, 12 Mar 2024 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rx6uaJA5GaTA6x0A03YxbYQQZ8SnjBq3KBc25hb9xtY=; b=hJxPOEygv8Mplk0/rCnAxfbhoH
	Yub723klx8uke+OLgBrLhPylVqZkxwKofrdDxha3L5QLHHrJKCQgw2cmW87UFOihfj3V8jWAML3O/
	STg0zSMRlUpfztb1IQ7eXE8z3VXdD066hs5hMnyqFzu2Rfc+Bg9oeObTihwp10ofqc9eYDZKmRY37
	u7bAEJCuFbIs2rz95OGHHfaLH4lToq6f/pVUZXJjnrFkh5pQfxC70yrgZXLCgGn1MnepWuBAD7Og4
	O1qbfK0t8VBNHR9F6TqDcRr8+FHbHwjNo93H99nIq/xWUFBSXA42pYTPXtr4NB8TWOxSzaXRdc7wR
	0947+2hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rju98-00000004K36-3FEA;
	Tue, 12 Mar 2024 04:53:50 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rju94-00000004JzV-2Y9a
	for linux-um@lists.infradead.org;
	Tue, 12 Mar 2024 04:53:48 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso3732a12.1
        for <linux-um@lists.infradead.org>; Mon, 11 Mar 2024 21:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710219224; x=1710824024; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx6uaJA5GaTA6x0A03YxbYQQZ8SnjBq3KBc25hb9xtY=;
        b=Ypipf1eFyX+9K8AbSD3I/bKWIVScC2TpPvdrgnf9nIMgSrv0tSOGvho1Q0MszzDgl3
         hrzX2jr3YiYhhb6mwASOXsrWkZ5auUk1NQ+4gDhoFTpPHdH3KVzHROC+Iw53EQPLcScH
         JxWTx5nQYwCGy8Y/Kyc5CWuZ1w7w9fHLjwUdx2C09ZOrtjHs7uxKGxjvDlyI9SA0Gboe
         m/wslqYM9APLruneg8YxYP/Le71Q311amrU9pT1EEmJwprkLnTcDrkeqXIhSefiRgswH
         Co5LZUPC6ZlhppjQz5H3+9OoGJ1/wJewLCSGQYGgn4KOVw0UXwkC82C5EjCRAOs4E9iX
         cnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710219224; x=1710824024;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rx6uaJA5GaTA6x0A03YxbYQQZ8SnjBq3KBc25hb9xtY=;
        b=Jbvj1tWk3vi8b8EC+PKUByjNN/m2d/mCFcZzCMIyXH8FBPm8Ri0At7m6xizePxjZey
         kxHFObAcljlPYYwGxjSN/MA9dnPXljZv7e2L2Vy5i5KBk4dBQ6WWSlBeftunAe6mQM1o
         SmZxtY7L4Z9Urw1SJT1k9q3H+GvuLNtZeX/UWz3IGLQ9FkWsK9LLove8NrrX87UUNDde
         cpOx07e7imUbyLqb/ScdyeHsO+2W6cL0nm6avapDXLqDjp1/ktVK79QNsoW2sa7R2Qmy
         uYtZyvQgQWzvPvo/HwIJOSIArqnncGuMS4V9wJ6PdhjbYWFBsupHoABkgMyNEhed6XbT
         IqIw==
X-Forwarded-Encrypted: i=1; AJvYcCWaV1frbcJnUADAn+dFD0T7QpT0Hn1AltOUgipUFYa1v15go05Ps1HIQsPe17O/LhpF53IkM7ynOsoHy8ni+IgXlpSPZT3m/V1BgMoa
X-Gm-Message-State: AOJu0YydEV7p421U9h3XCpB1PrbUjJ5NU69QYZZXQE0RgxGJ/uZ50l0/
	rmjij+dF5fen7PiJeU6BhtY4NfFV5CZSCjJhjJjay7x6dVvpgdf5TK9sqeHDlNs+9WLKK4pEA4g
	JeEN9I+6+ldn4F2JmZ1AzmrCKTjHIylzM/se5
X-Google-Smtp-Source: AGHT+IHDyL7/kwgr/0FC8GfwKZO4dzMG+0nGwiUgO+KM0lSe1OBVxz/fJ1q0orM6NTZxI9cNT/o09ctwDuxQhsewYqc=
X-Received: by 2002:aa7:c31a:0:b0:568:5606:71f9 with SMTP id
 l26-20020aa7c31a000000b00568560671f9mr56360edq.5.1710219224544; Mon, 11 Mar
 2024 21:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240301194037.532117-1-mic@digikod.net> <20240301194037.532117-3-mic@digikod.net>
In-Reply-To: <20240301194037.532117-3-mic@digikod.net>
From: David Gow <davidgow@google.com>
Date: Tue, 12 Mar 2024 12:53:33 +0800
Message-ID: <CABVgOS=WjRuFLbJt5DgJv7X7ouFOXXOvXeRUSFSSfi=m5iYD+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] kunit: Fix kthread reference
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
	boundary="00000000000063288606136f7110"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_215346_673027_A2133F3B 
X-CRM114-Status: GOOD (  22.36  )
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

--00000000000063288606136f7110
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Mar 2024 at 03:40, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> wro=
te:
>
> There is a race condition when a kthread finishes after the deadline and
> before the call to kthread_stop(), which may lead to use after free.
>
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240301194037.532117-3-mic@digikod.net
> ---

Thanks: I've never been unlucky enough to hit this, but it's definitely a b=
ug.
We should ideally mark it with a fixes tag:
Fixes: adf505457032 ("kunit: fix UAF when run kfence test case test_gfpzero=
")

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>
> Changes since v1:
> * Added Kees's Reviewed-by.
> ---
>  lib/kunit/try-catch.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index a5cb2ef70a25..73f5007f20ea 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -11,6 +11,7 @@
>  #include <linux/completion.h>
>  #include <linux/kernel.h>
>  #include <linux/kthread.h>
> +#include <linux/sched/task.h>
>
>  #include "try-catch-impl.h"
>
> @@ -65,14 +66,15 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>         try_catch->context =3D context;
>         try_catch->try_completion =3D &try_completion;
>         try_catch->try_result =3D 0;
> -       task_struct =3D kthread_run(kunit_generic_run_threadfn_adapter,
> -                                 try_catch,
> -                                 "kunit_try_catch_thread");
> +       task_struct =3D kthread_create(kunit_generic_run_threadfn_adapter=
,
> +                                    try_catch, "kunit_try_catch_thread")=
;
>         if (IS_ERR(task_struct)) {
>                 try_catch->try_result =3D PTR_ERR(task_struct);
>                 try_catch->catch(try_catch->context);
>                 return;
>         }
> +       get_task_struct(task_struct);
> +       wake_up_process(task_struct);
>
>         time_remaining =3D wait_for_completion_timeout(&try_completion,
>                                                      kunit_test_timeout()=
);
> @@ -82,6 +84,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>                 kthread_stop(task_struct);
>         }
>
> +       put_task_struct(task_struct);
>         exit_code =3D try_catch->try_result;
>
>         if (!exit_code)
> --
> 2.44.0
>

--00000000000063288606136f7110
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
hvcNAQkEMSIEIA+Iivc9sGB5XvNfiEsi2BqxDoDHSaxYzcQTh0ZrrlQqMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDMxMjA0NTM0NFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAQq/La
jnnImYcqOuobgr7Ddfs5z7pagFP0+FuKyz5kC29UICH0HmdekGhlRUK8I5eLevWfGP+Ag0gzdtZg
a5wlxP1bF19ygUNNLLHRiJI8d6eONS+4vZBOECrTnX1BR/WqhyVHwAjQ7cV1ucBwUEjFSyZDPnOT
HZmXHENaa8CGIEYI8dLMNAoN4RKM2PWHOXBkpeD1MZcA+y8mgbW1OLsH8XSiwqW3JP/h21zR6dUd
4vONLq6K7HB/tTffOqOU6tWZQx/QREhco3obrAdS4FgtrxCmkwr6eBZb82fri99WBnuBjIN+v5rO
9WDBQVi4woq62YIE91oUaSF5bqRlv2Z7
--00000000000063288606136f7110--

