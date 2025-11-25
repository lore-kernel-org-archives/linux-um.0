Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCB2CFD315
	for <linux-um@archiver.kernel.org>; Tue, 25 Nov 2025 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uLAcwIkpI2/iwO22p+DYcdfgrCeZUc9i9/+M+aDCUeU=; b=Q7HJhMWExxEZkzgx8LncDvt/xN
	02Ji5v3ZN98lE3Bfk7wQoq454jZqxjIPp4mHWPBrADQiOD78a2vbtw6G+d3PxqTxCKyiLk/BviHm1
	hIhGlYPE1N0R1XIN+VYpdegPps/Bf7lMPwGRYSLbB8AdC2uS/d7pglUGskaNMm5dM3ZwnV2xkX7fp
	oWLkt9nKQigi+bA58VNK7ltX+CnbN1mP6TRSaa2vQYI/1a2HmqXzME4CR4HN4NZwKxcreeFSt2ww9
	L1ju+iwVBsXq73QqtiYj6qW2IHBf4H1JQ/zSZ3uEK9HBP1HbvSo/XT9D4DZajb1YcRd78Phsp/7yW
	Uz4lpmLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnbU-0000000Cu9l-04BW;
	Tue, 25 Nov 2025 07:36:48 +0000
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNnbR-0000000Cu93-1T4F
	for linux-um@lists.infradead.org;
	Tue, 25 Nov 2025 07:36:46 +0000
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-882379c0b14so38974936d6.1
        for <linux-um@lists.infradead.org>; Mon, 24 Nov 2025 23:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764056203; x=1764661003; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uLAcwIkpI2/iwO22p+DYcdfgrCeZUc9i9/+M+aDCUeU=;
        b=tofzjXlnyjcfkkuzq7iE/dQ2bQ/D/oCvIV7wygJBWH+YKfezQqOaFx4mzSuCQEG3jC
         5QiawiIjV9SqtxTDbJFGoT76ep6G9kqVZpiprolmAaKKLakBP9zCfhVkkNrtDRRDkiyZ
         nZViBc2vDCZxFARWvs0PPGGYm3rq7yI2cjlslJkfjhGFIGn1Q6GvOIXl0Ud/c5l0ogvy
         fMz2LFUwnXe5at0rC2TZf+1HqXIyXCqLcIIAKRoOv7pktWRRmSBpezlUE+qnuksZUD4Z
         qPlLomqTc3i1EF59REvQSYHXMeM80I562fTWZSl1LZJzRZWlumyLiXQ9MDV5sySMK85X
         dC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764056203; x=1764661003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLAcwIkpI2/iwO22p+DYcdfgrCeZUc9i9/+M+aDCUeU=;
        b=FRFjeRZ0W+r1wFiweXo7ECVwuU8/QkGgLM2bjsEW0R5ENoC5LNipkaf/MK21HNC4/h
         OF0LS2nQugeeuVr92zIMDTphFkOxoFg4S2zaOOib5QTa5uidxCr7PhHcttn+Iy/iWrdJ
         oxvBYPLN4OjCZKh5WWRiXN7ehxM5IUub35iz0IKkEH/P208hpLPYaha0fu24MqeYFB8+
         5TGPySx1xo5KFzpOAidN/wUbSEW2HykC3yccXQCf21DtIVrMOa+Fv00oK1fSFgVFL0vj
         D4XrFjf7aDNteyt4BtYJNB3dtuE3NzNM9C1zPLejS6YufVKsb6txNFIp4YsTT9ZlkiCP
         m73g==
X-Forwarded-Encrypted: i=1; AJvYcCVTgl914Razy8UhfVF2LvoQ0NPZCSGZgkw86oed3oTQzGq/WKWL4ayBWtx4C5Xu19A7AeHwGMWgng==@lists.infradead.org
X-Gm-Message-State: AOJu0YwsdBvVnTBzOQqfaiK89XKxAZVnwvG11RB0GOKihpyWXDWX3PMp
	GII/gyMLuSkl8jZDvXkg0wTx8aSLByyfFuwMMW/+4+DLbSA3XWELY82pmSjI1826AitIGcrUuzu
	UF1aqCEFJt3Rdbk8IDETuKODYRFWJnmsQNCnOOqmg
X-Gm-Gg: ASbGncvHoucqHnDaL1aukQ8K4/lYPMnKF9ZyhkEOrmb01HRaX/KrXbzshoEig6wVI/i
	yFHSn+3fmM0oYclBMwAfAD9SOl9j6c8H7uefrufGWvcNzdCJJfvZLHRsvvuK65oWgyN9gD6LBfZ
	9jTjwEwrNKXXXybEBr3zXLyEZPYOhaoLQ3cp7MzMmygiw68nAzXXs33totPeq8uQwpj81UrPXTQ
	4ydy0Ygtx9YdGXmyF2/Anr8p4GqQt6R6r26svaNEXENx281T1uRl7yVqdvNPhkzX365Kw==
X-Google-Smtp-Source: AGHT+IF+phdikrkK/jpDS/rOzqAPDUrWvcMEaOckuwa0ZT5U0yLdsB/659Bs/f/ihxMkSj7tKKOB3YpKs67rpftB5RQ=
X-Received: by 2002:a05:6214:c44:b0:72b:37ff:b877 with SMTP id
 6a1803df08f44-8847c5445bamr203959076d6.42.1764056203196; Mon, 24 Nov 2025
 23:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20251122083213.3996586-1-davidgow@google.com> <CANiq72=MXHZ2XswxkfzLqUEPwriNy=_sxAQpOYoYW8iNgyuJ8Q@mail.gmail.com>
 <bfb512e24f365695534313b375fc0c38d0a843b2.camel@sipsolutions.net>
In-Reply-To: <bfb512e24f365695534313b375fc0c38d0a843b2.camel@sipsolutions.net>
From: David Gow <davidgow@google.com>
Date: Tue, 25 Nov 2025 15:36:31 +0800
X-Gm-Features: AWmQ_bmm0rT9n7rq3rPJhu21Vgyqy2RCLBEjipltOFFJx3qRQyyqqQlJEQfbPZU
Message-ID: <CABVgOSmAGahEaa71_fOT4Oo9Wg91X6rN+1_KgVVvVzmd4vuMCg@mail.gmail.com>
Subject: Re: [PATCH] arch: um: Don't rename vmap to kernel_vmap
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Miguel Ojeda <ojeda@kernel.org>, 
	"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>, Alice Ryhl <aliceryhl@google.com>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000063a6a50644665788"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_233645_431658_43678165 
X-CRM114-Status: GOOD (  31.91  )
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

--00000000000063a6a50644665788
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Nov 2025 at 15:49, Johannes Berg <johannes@sipsolutions.net> wro=
te:
>
> On Sun, 2025-11-23 at 18:07 +0100, Miguel Ojeda wrote:
> > On Sat, Nov 22, 2025 at 9:32=E2=80=AFAM David Gow <davidgow@google.com>=
 wrote:
> > >
> > > In order to work around the existence of a vmap symbol in libpcap, th=
e
> > > UML makefile unconditionally redefines vmap to kernel_vmap. However,
> > > this not only affects the actual vmap symbol, but also anything else
> > > named vmap, including a number of struct members in DRM.
> > >
> > > This would not be too much of a problem, since all uses are also
> > > updated, except we now have Rust DRM bindings, which expect the
> > > corresponding Rust structs to have 'vmap' names. Since the redefiniti=
on
> > > applies in bindgen, but not to Rust code, we end up with errors such =
as:
> > >
> > > error[E0560]: struct `drm_gem_object_funcs` has no fields named `vmap=
`
> > >   --> rust/kernel/drm/gem/mod.rs:210:9
> > >
> > > Since, as far as I can tell, we no longer actually link to libpcap, i=
t
> > > should be safe to just remove this define unconditionally.
> > >
> > > (If it's not, we can possibly either disable DRM Rust bindings under
> > > UML, or move the redefinition of vmap behind some config option.)
> > >
> > > We also take this opportunity to update the comment.
> > >
> > > Signed-off-by: David Gow <davidgow@google.com>
> >
> > Nice, thanks for this!
> >
> > Yeah, I guess we would otherwise need to do the same kind of "wild"
> > macro replacement in Rust code to support this or conditional
> > compilation, and neither sounds good.
> >
> > If it is not actually needed, then this sounds like a win-win.
> >
> > It seems it was indeed gone in commit:
> >
> >     12b8e7e69aa7 ("um: Remove obsolete pcap driver")
>
> Indeed, that was just missed during the removal, we can't link to
> libpcap any more.
>
> How do we want to take this patch in, and where is it needed? I hadn't
> planned to send a UML PR to -rc still, but I guess I _can_ if needed?
> But if anyone else wants to line it up through a tree (rust related?)
> that has pending work anyway, that seems fair too. In which case:
>
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
>
> Or it's not that urgent because all this came up in -next now? I didn't
> really see (or fully understand) all the build bug reports.
>

I'm happy for this to go in via any tree. (Worst-case, we could
possibly take it via KUnit, though I'd rather not, as it's not really
KUnit-related at all.)

The issue has actually been around since probably 6.16 (c284d3e42338
("rust: drm: gem: Add GEM object abstraction")), but since it only
applies to people building Rust graphics drivers against UML, which is
not super common, it seems like it's only come up in randconfig builds
so far.

-- David

--00000000000063a6a50644665788
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg9n6QURtXdZlFtwypE+PDGHN7yKgh
re/hamZ5LkXKHUQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUx
MTI1MDczNjQzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAqV6558UFakTZ5MVjKYtHzfXVlu/ULMIUPb5svQ+0qb9lM+062tk1WoWOJZ2oLvko
pGJuq7HRTPhLrVoH+DOTN3knPiLoBttSU2ZkppW4FoDagMFa64bKOAThvryObrEx3UVmYZgikWLk
rjK/wEjumIDFr1CCDrWhQ3Ye+eGmjrW1l7KLwomIYH0Ndx3zAzpxOncu8VETdkUmlOlbtNqPs+9E
K1nWq8v3ddnEbGDAtxNDNmeLP5OmHfvjkrWJ00d44qygZBPnz/n3TdSENrmzvPA37thv+RD5vNDz
hQ6yENFVOXGbrOAR42bLZzm2XdlvN+rm2AVNJlIf9CIHr3XjVw==
--00000000000063a6a50644665788--

