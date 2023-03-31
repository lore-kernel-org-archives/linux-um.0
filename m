Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F89C6FD18
	for <linux-um@archiver.kernel.org>; Fri, 31 Mar 2023 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:
	To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R53Vu/b01k/D0AC3DdTPmWvmhLWEcl0L39XEt98rSAE=; b=Vuy/09b/8UqjvWUyH9ezA2YjI5
	axHcpfvAiBqVgt279Xgc5hPEZ2ksicRUTDJh3CLcxDoG2NAERkhrolnDTPWMa6xBualUyrkYBV+0Q
	KogrZOTt3n13aAULQZ9STZg5rzxzTfS45swV1dW0tfuDUK3CuSGyMj5X9chFKkfOpb/H8JhLw7y96
	ht0jHh20XLQ3Zn82G5fvonkSG7X9VLRx1HGVbH3tIohbdu9sTLyHhCDGozqaTNpGoGaReuevqtN/m
	RFMNPKLKrmXtbyfohwW5UJeqfrM6exrN2I/nJgJVgAVakSj8y8gHUY2DXNzclXKqkaFB1PuDi4sqO
	QlTFe6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1piA5S-006NRH-2A;
	Fri, 31 Mar 2023 08:26:18 +0000
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1piA5E-006NCi-25
	for linux-um@lists.infradead.org;
	Fri, 31 Mar 2023 08:26:17 +0000
Received: by mail-io1-xd2b.google.com with SMTP id o12so9427712iow.6
        for <linux-um@lists.infradead.org>; Fri, 31 Mar 2023 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680251156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TckmEwvTCjgccKVX874EIk4LZPULQL/OVtp/raPGhzM=;
        b=aIRVGG7nIMsJn//VAWrq0sTp+P5POlS5V6oqzukeNNnvtMgmQVXSPSw/4cwKAD91B9
         rina+u5sh7KdIODaSNNFHncog2E1sSxemUxDTEI9NVaUPyHlA4A3HwO9pfbXdt786a+5
         yxUtgeUaylD1O3g5VHb+uLZ4B4E9Zt90Aa3Xa5/6KP8S6AMxJ6arkzmh+KuPfJ/7tvvW
         baz/vPtFPIEvYWIqRa/bWM4+CzLHfh/+qflflB5dujNW6F89kt8Yq1Lu2fWT+QNEUr0m
         G1C//4j2ZCXC41CJAgSnyRFZJicIZem87Gm720xNXIqbp59+Kl6xGrvoMyYKeXw0bUz9
         Idvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680251156;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TckmEwvTCjgccKVX874EIk4LZPULQL/OVtp/raPGhzM=;
        b=0yHDm0Um0ns/fwuGjbGMpbRSRi8SCIM1EJPwnxwjK2U8tKtzNs88GB7PZNR+tSSXdB
         2k7iVzUCIMylxOvEntZLoBiUsrRqZMThmXTkmZvxzJXDwRvMeZnRrZ3glh6TTEDYg25c
         oO1kHr6OBIADa4xdWknb4ngbjfC33K/QuHbKGwxPHDENlA06cphOvJ4eXTuG8SNRS/wj
         nobRZ15zIrB1PmOKD8LUAHAp3R+eHY4KAADakH5GtInd+ByQil8BZrXRAK1i4PqjRQNS
         oe5EN48liN9h1uEr57u2XWDaJyUl5+XumKI21Liqpa+RB0DL30Q29a524TDMdZJpvz8z
         Cjyw==
X-Gm-Message-State: AO0yUKVMMC7mA3Q+qAhlhbR5pWt5fdCjSml7+BsIPKOpuy6qIf6OJF1+
	axJej6wl70W2ZdHh7uhL68odkGI8G+J57UGBiG9eJw==
X-Google-Smtp-Source: AK7set9HsDsjzLUfY2IRLL/Ht0kiBRiOauKgNp7tr+AMax573o5dCK2pNORhhGysUsjJ9eHXrekfrjSQ7kafSyKwlpw=
X-Received: by 2002:a02:85a3:0:b0:3f6:e3c2:d4be with SMTP id
 d32-20020a0285a3000000b003f6e3c2d4bemr11295973jai.0.1680251156168; Fri, 31
 Mar 2023 01:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230318041555.4192172-1-davidgow@google.com>
In-Reply-To: <20230318041555.4192172-1-davidgow@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 31 Mar 2023 16:25:44 +0800
Message-ID: <CABVgOS=pr=jXq4qRrKaCy47xczDaFXFKCPanVvaZ+MfQmtwK8A@mail.gmail.com>
Subject: Re: [PATCH] arch:um: Only disable SSE on clang to work around old GCC bugs
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, x86@kernel.org, llvm@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Nick Desaulniers <ndesaulniers@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230331_012604_725612_E9C371E3 
X-CRM114-Status: GOOD (  17.85  )
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
Content-Type: multipart/mixed; boundary="===============0638803529999601291=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

--===============0638803529999601291==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000517db605f82df54a"

--000000000000517db605f82df54a
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Mar 2023 at 12:16, David Gow <davidgow@google.com> wrote:
>
> As part of the Rust support for UML, we disable SSE (and similar flags)
> to match the normal x86 builds. This both makes sense (we ideally want a
> similar configuration to x86), and works around a crash bug with SSE
> generation under Rust with LLVM.
>
> However, this breaks compiling stdlib.h under gcc < 11, as the x86_64
> ABI requires floating-point return values be stored in an SSE register.
> gcc 11 fixes this by only doing register allocation when a function is
> actually used, and since we never use atof(), it shouldn't be a problem:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652
>
> Nevertheless, only disable SSE on clang setups, as that's a simple way
> of working around everyone's bugs.
>
> Fixes: 884981867947 ("rust: arch/um: Disable FP/SIMD instruction to match x86")
> Reported-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Link: https://lore.kernel.org/linux-um/6df2ecef9011d85654a82acd607fdcbc93ad593c.camel@huaweicloud.com/
> Tested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>
> Tested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---

Any chance we could get this picked up as a fix for 6.3? The UML build
is still broken with older gcc versions.

Cheers,
-- David

--000000000000517db605f82df54a
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
64VRg2IjDI2fJVE9RD6aMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQA2lZLYRLu7foeR
cHo1VeNA974FZBiCm08Kd44/aCMEzdTJvxAE9xbUJf7hS1i6eW49qxuSp3/YLn6U7uatwAcmZcwp
Zma19ftf3LH+9Hvffk+X8fbPKe6uHkJhR2LktrhRzF159jj67NvXyGQv8J4n7UNeEVP0d5ByvRwv
tF2bJwlOwRGLoxasKSyDHIyUpwTfWYPq7XvjoGqQ/tDS7Khcc5WncJl0/ZEj7EKjtoGbsDbLdXEF
m/6vdcYKJzF9ghHewtV3YIU4RE3pEM4aCWWRtJwbExzeue6fI7RqURbNCAyQuSpWv0YQvzsX3ZX3
c1otrs50n1N0Sf8/rfJxq7sWMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABxy1wm0tAmHKHFkLS9RWPMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDr
jJKREEYbbcKycWTSOiTmoE4j3QQvDuC6CNLfUfH2mjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAzMzEwODI1NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAm/lMnN4eGBckZMdu1fel
uKcGJxRJGV0e9ATijhuuLe6VFzANxmXKOub8BJUnD+0985ABkRQRkLzN7MGKmDmKiM/eD/sV6mbV
Vumf807UBjT1eGvLjuxyk8kb3/JQqLIxtXi+bzlQWBqmLlkwYiWzs89WrLRHolwxKsYuuxR/NAu/
qdWSL8fPhBMMqnaFCW7IEDluszozDUPrht1PBe1Xp1ueEK+JEAAcRr5t8mCVRFToccWxO4yhjr6Q
IKNeluB0lTcUtWAyVrED8MkAiBwL3zvQpKX/k1bGgNL51VYVQfrZIezxvvkQy4ZCnDeKyNTgoJlq
5Sv6GIE+sOJ4v0+9ZA==
--000000000000517db605f82df54a--


--===============0638803529999601291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0638803529999601291==--

