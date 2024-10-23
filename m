Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2DCD2E010
	for <linux-um@archiver.kernel.org>; Wed, 23 Oct 2024 04:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93PXesIwcFhvZDfe6eRFA29vAK8OHycQRWM18TUzsz0=; b=yq1WCj6TBQvSIEduoQ/ZaPExzQ
	LRSyav9ZXgKgnSyP8aJ62PHOz1B8ZijsJJIYfa7DanWOJww94tNdJStBfCmt2hs+qwy3kGq4Fxvyn
	5BWj+4fM4WCnUZHZWZzGzqmeUKv5VsIHlSDV7rAbRomhXSznZVKZQQx0pOtkiZG8IWqZcYOxWmaCQ
	ijU64Pp6rfYKxbUl7hg2ZhY+YHniwOyJQkQLqzMf0IA5a86q6ITNLabmzYQ8d81gGx/B2oUKWyrYt
	bJt4nDeyV4ZOjoTq52KedrWFntYo36ma4TvA7EmjjbJ5wfpTya5VObdPdkj++RrFHuhQri4vxUKZa
	CUwOF07A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3TDi-0000000CwCj-2IuJ;
	Wed, 23 Oct 2024 04:43:42 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3TDf-0000000CwBc-1b3X
	for linux-um@lists.infradead.org;
	Wed, 23 Oct 2024 04:43:40 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6cbe700dcc3so40320516d6.3
        for <linux-um@lists.infradead.org>; Tue, 22 Oct 2024 21:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729658614; x=1730263414; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=93PXesIwcFhvZDfe6eRFA29vAK8OHycQRWM18TUzsz0=;
        b=EYHobYQf7CZjjS6LHwNF8AMrFRBQFfn1+Rljo85OLDUUsk+/8Ze0oMLZ08GyX1R99f
         ix5rcf3t7iQpI77WUIVVjv1dGILmieV17fp/G52kxaWUECUNCMm0pkD0wcaYiBA4yweX
         IrugysNKQbhRu+v8hfpiQH7x9hD2gHxAqUtWCNwo721NgpycS0E5P2QgygY3I/DmYAwX
         /0Ylw4G4idcdiHauh3FDFrOFBMc6zCe4x8RdPdC9ywqLnuPFQgVE0Q4+ymCIo/6038ec
         6Kxcpz467JuVotYW+MBcJpstj9EUKgGmgcfKQFt7c9BflUZ5YE7yKfpXLgWojzeSlCfp
         uR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729658614; x=1730263414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93PXesIwcFhvZDfe6eRFA29vAK8OHycQRWM18TUzsz0=;
        b=DsgUpDelyxEaJ72Igk1hINQ5CUlnQgG0jnXnNy1fCkyV+ykMypuIoSEse1si+i0qWn
         6iZ8nvl9Avv6eI0HeJlzuwysv8B+qFTjsI1CE95cEYClLy6z+TdqF8PW5F5AY1LqaSx3
         k8zBXw82ffNv48/xpc+JvbBSMa9RDOqyiJy4zMa8rlxHc0zMfo+ND1PRzMXLoFKLzcko
         NRbeipXWLjo5ttT1fCF2fCioiPyC69sdxpdQoT5ThGLDuhkZ6td6XLdA03d13zE1OhR/
         VqUiEO4jN67o167eLc8yUu4D/3F8Kbzu5Jn3Tq121/IeOQa8KeVZz70C1AGrLMPwLQaL
         LGtg==
X-Gm-Message-State: AOJu0YycuZMtGUZCxGDgEhi6OvmZExJBkA2GlE4EScEM24vDZzv+n57d
	0isEteZPtr1wwP5PWxMT8M7vcMj1pjYKCVGIDbLxxtzM2WbZRCRa/xTtpkRtE1DPBTUnyHLYhgs
	ERF01TJiUzkhOt3/jB9x4z8APvXnw+pR1/oUY
X-Google-Smtp-Source: AGHT+IE55jszEgMI7k2TC/5aWq9RCYiaOqMEhOZw5LWOsJdxsPcBxrfaLD+9gjMk6KEWUJNXgjFMHukMb3DHDG5Qk1E=
X-Received: by 2002:a05:6214:2b8d:b0:6cc:1322:21d9 with SMTP id
 6a1803df08f44-6ce34203eb3mr14750526d6.1.1729658614266; Tue, 22 Oct 2024
 21:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241022120238.546980-2-johannes@sipsolutions.net>
In-Reply-To: <20241022120238.546980-2-johannes@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Wed, 23 Oct 2024 12:43:20 +0800
Message-ID: <CABVgOSkXF+iqiv+U_77_657+M-xSYBxM-fuUbfOfcOzgHv2VrQ@mail.gmail.com>
Subject: Re: [PATCH] um: make stub_exe _start() pure inline asm
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005212a606251d87a0"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_214339_480893_BCCEFFA4 
X-CRM114-Status: GOOD (  22.35  )
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

--0000000000005212a606251d87a0
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 20:02, Johannes Berg <johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> Since __attribute__((naked)) cannot be used with functions
> containing C statements, just generate the few instructions
> it needs in assembly directly.
>
> While at it, fix the stack usage ("1 + 2*x - 1" is odd) and
> document what it must do, and why it must adjust the stack.
>
> Fixes: 8508a5e0e9db ("um: Fix misaligned stack in stub_exe")
> Link: https://lore.kernel.org/linux-um/CABVgOSntH-uoOFMP5HwMXjx_f1osMnVdhgKRKm4uz6DFm2Lb8Q@mail.gmail.com/
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---

Thanks very much: this is much nicer, and works on all of the
differently problematic compilers I've tried.

The explanation of the stack space calculation is useful, too.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  arch/um/kernel/skas/stub_exe.c      | 18 +++++++++++-------
>  arch/x86/um/shared/sysdep/stub_32.h |  8 ++++++++
>  arch/x86/um/shared/sysdep/stub_64.h |  8 ++++++++
>  3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
> index 722ce6267476..ff5471986c52 100644
> --- a/arch/um/kernel/skas/stub_exe.c
> +++ b/arch/um/kernel/skas/stub_exe.c
> @@ -81,11 +81,15 @@ noinline static void real_init(void)
>
>  __attribute__((naked)) void _start(void)
>  {
> -       char *alloc;
> -
> -       /* Make enough space for the stub (including space for alignment) */
> -       alloc = __builtin_alloca((1 + 2 * STUB_DATA_PAGES - 1) * UM_KERN_PAGE_SIZE);
> -       asm volatile("" : "+r,m"(alloc) : : "memory");
> -
> -       real_init();
> +       /*
> +        * Since the stack after exec() starts at the top-most address,
> +        * but that's exactly where we also want to map the stub data
> +        * and code, this must:
> +        *  - push the stack by 1 code and STUB_DATA_PAGES data pages
> +        *  - call real_init()
> +        * This way, real_init() can use the stack normally, while the
> +        * original stack further down (higher address) is no longer
> +        * accessible after the mmap() calls above.
> +        */
> +       stub_start(real_init);
>  }
> diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
> index 631a18d0ff44..390988132c0a 100644
> --- a/arch/x86/um/shared/sysdep/stub_32.h
> +++ b/arch/x86/um/shared/sysdep/stub_32.h
> @@ -123,4 +123,12 @@ static __always_inline void *get_stub_data(void)
>
>         return (void *)ret;
>  }
> +
> +#define stub_start(fn)                                                 \
> +       asm volatile (                                                  \
> +               "subl %0,%%esp ;"                                       \
> +               "movl %1, %%eax ; "                                     \
> +               "call *%%eax ;"                                         \
> +               :: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),     \
> +                  "i" (&fn))
>  #endif
> diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
> index 17153dfd780a..294affbec742 100644
> --- a/arch/x86/um/shared/sysdep/stub_64.h
> +++ b/arch/x86/um/shared/sysdep/stub_64.h
> @@ -126,4 +126,12 @@ static __always_inline void *get_stub_data(void)
>
>         return (void *)ret;
>  }
> +
> +#define stub_start(fn)                                                 \
> +       asm volatile (                                                  \
> +               "subq %0,%%rsp ;"                                       \
> +               "movq %1,%%rax ;"                                       \
> +               "call *%%rax ;"                                         \
> +               :: "i" ((1 + STUB_DATA_PAGES) * UM_KERN_PAGE_SIZE),     \
> +                  "i" (&fn))
>  #endif
> --
> 2.47.0
>

--0000000000005212a606251d87a0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgKa8P7yUJKbO61or1UiduqjjftsX9
HcNN0YD43FcjCYowGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDIzMDQ0MzM0WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAC21NLgSTX6hwS/jjHgetO7BHCVj4z0Pw/bXxbwmNNBjR0Nh
qNbsF7l7tTLM2bvF4a/R0kcGZ8UmVcJazy7BtVnoiowiC8KFUukCbg//B2VE4sId6OB4xXPhVsmp
UklMDFV6un/WP0eCD7eNWp4a3qQL973+OX9Y+PRuZcve1MlqdyTVKWl7GCORIWDJArdMvaRky/CU
TEB3Wn9ovXBz5+1mlAwxj6ob0GuRwHxtS2sY6xg/CAOhywr297HykKEIb6/2Wyf5+dUDvvlT9VEK
QAUZ3HDLooepzZ/Dgk/2tcUDrM578zAMOHwJa7hqultM4GrP1IwRFLX+hofPwxRvCew=
--0000000000005212a606251d87a0--

