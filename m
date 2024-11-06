Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3343CD44D64
	for <linux-um@archiver.kernel.org>; Wed,  6 Nov 2024 13:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cFpojEnN31E8c/jbNjoaX1ShR1nt45miTw6rk7Wlxl0=; b=2Thcd4tMDPaFsDxvTB0a6vOWPS
	oWNl4OnlZTYo7eNNdEOuuzyjuIg62uIpoPFRlhMJEcPX4ldsjcwjfU+RA0MKXXNFhfkyZNJr6zac5
	Q51IMJAtM7Ojt7M90pIgzSFVu7+RzvYIPje3F2PnLWOHoxoyA8jwtd35O+gUmqkI8OST0w0iCz05b
	1+yrM8JJfZihktk8IxEpR97zT8+laZFHuNdWRiPsDyPwBNYFg94C9fcqFIJzGNhi8ng1by8D+Lj5J
	i3t7aW70zju0yPNnrax9PguENHmHwCCnM98o+pYKKj17tyvEIlXIrUvbooJLdjkmP/OxhNcr8MkCJ
	EMwCqXGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8gMg-00000003TW6-1K1G;
	Wed, 06 Nov 2024 13:46:30 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8eaX-000000030g0-3xAS
	for linux-um@lists.infradead.org;
	Wed, 06 Nov 2024 11:52:44 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-20cf3e36a76so69074105ad.0
        for <linux-um@lists.infradead.org>; Wed, 06 Nov 2024 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=researchut.com; s=godaddy; t=1730893960; x=1731498760; darn=lists.infradead.org;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:to:reply-to:from:subject:message-id:sender:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cFpojEnN31E8c/jbNjoaX1ShR1nt45miTw6rk7Wlxl0=;
        b=Kigc7wsq4oCVJ3AaS5N5T/Y5keG6ClKzwUATmXYve8GIZNvZP0MuwvEO35FEKcD1NQ
         6AJSDSrBszEECJRCtmgEXOWzg9Dxd/iNVVRIG65OgNveJZn6RdFQKn77bkptECtdGXrg
         3WMYR4iUIPf619MOQhIhnVimbHSsVi5EyXkQrc9lG03etAz9SY9X1N5K1RGrCc4qjdbH
         hbUp+fC4uoFZPfdcJoEPFd7cpB/+xpE+Pq/CaGayWL1orp6Rj+rpEatjKhWfAAknES6v
         Jt8LHUQZ0JWo9h8lTjv8fdAV6xPEINvnLlZRqDIjNMzBGyIF0xzGmavjkNAHO/bDpkV2
         Bj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730893960; x=1731498760;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:to:reply-to:from:subject:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cFpojEnN31E8c/jbNjoaX1ShR1nt45miTw6rk7Wlxl0=;
        b=HMeD4+mz+y/HlD/1rzfxOEa1mUelSxQALwZafT8buVSlKUUsPwsDKa3jyl/LrgpZN6
         J8I+OoMGzuccAEDyzAxsNO2fIYU0/a4ZpEB3xupSJ728uIiQfelWUV9pF/eW0FBdkhM7
         Ush5+M1X720bRVpdbti1YtqmemayQDCfTJlyfq+Nxg6EYMjy97uIcxWAWgW7gwEq30AZ
         LVZ9Btj8XTmfU7zvcEJoRpWg+rUT3kcPOcV9cmFrYrH4zrT+JQHowS8J081/sPUEfbin
         K4R1xmWutBDsRF3P5tzar4XJPZlFuNthYtqaB+5Fm19NGp5Osm90e7AGU7/OevmB3aoo
         PqDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6/gIswTyBLz7jF5yYZGeF+PSyUWDtV3jQOunG53VyZ+fmAmEbDhIPn6GYOQJxMadSJpyBXDL19g==@lists.infradead.org
X-Gm-Message-State: AOJu0YwBrx39ae7Y1DtAFFcFOn9geCvLsPZRworSOMyB0wXGceL8bZKC
	lyFavkSE+mt2HZG8/FPHlgntF9Tuqv45+9CfXOw/5nuqD4WOF19+uywpdonLeNKj0LQkzkB/mhs
	L
X-Google-Smtp-Source: AGHT+IFKgE8cUzRR9lqC+XzLZukoKuORK8RHh3WhKtX29ZF4IwYCs0eU4Ps7kN8+8TQGbTa146YTDQ==
X-Received: by 2002:a17:903:40c6:b0:205:3e6d:9949 with SMTP id d9443c01a7336-21103c8c193mr293808425ad.52.1730893960307;
        Wed, 06 Nov 2024 03:52:40 -0800 (PST)
Received: from priyasi.researchut.com ([152.58.195.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057bf377sm93391155ad.184.2024.11.06.03.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 03:52:39 -0800 (PST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by priyasi.researchut.com (Postfix) with ESMTP id 98045195A0AE;
	Wed, 06 Nov 2024 17:22:36 +0530 (IST)
Message-ID: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
Subject: Re: UML mount failure with Linux 6.11
From: Ritesh Raj Sarraf <rrs@debian.org>
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
Date: Wed, 06 Nov 2024 17:22:27 +0530
In-Reply-To: <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
Autocrypt: addr=rrs@debian.org; prefer-encrypt=mutual; keydata=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 5oIBpsKjqBklceYHJBnU5+4Z6BpCYck/SeykxBvLW0ula1KMQAtoM8YVEbWzBN32nlYe4pJdghiCh CC8isB++DRi6kiRhV9xYb6bgQiV8RV8QUE6ahoCFHOm/jCxgc/YM49jqs1A/vnMCT7A4ikTJojarB 76CjuadCbU1QQMQeoBn5VWjYGI3au5fjDRgfcf3S0/auVdtxqyrLdXzuLLazI1tgfy2D+g3UWFVLD
 RoADdVOvJ/JcPx1Z7qDVC491K5hC4i0GM2jL1eUlD+h16bb+FkkcAwDE7wunACQU5Bwx7EI6kK7Q1 Uml0ZXNoIFJhaiBTYXJyYWYgKE5ldEFwcCkgPFJpdGVzaC5TYXJyYWZAbmV0YXBwLmNvbT6JAh8EM AECAAkFAlQYBMYCHSAACgkQ8vEcI/AKK+aNRg//Tmiii6Szi6geJx87EuqKZYeI+zwpWEzCQSaikE HS9VD7awdRv4RYQiuT6H/B7K5s2CaXiLDqwMtnIjDl0G0LPAV9Y0TclafSCKHcW43KY1i2Sq+n1eD yIeb8AkijB6o8N4I0Im6Flkak1NK+TDaQGbmxY62MVbewspZ68Y4q+ApFO0D/G9sR0zz1WiHvc9Sp hDfuvkVnpjZiUOBWfhxCSaDcftWO2hLy2uQMICX9ADuMjS1/XfKWYax4q/37zIagnxDuh7RqLh4wP IzYox9Jo60gN8U2n0a+9sg4jr5GUo6ncRIgwKk6L6owFr9rxWoL3NjfLTVhmvm7um9s9j66r0gCeL Ypav4B0GGDqDME66EBByC3c08vRZt5T17sn5KCbwazmI2sqhnmpioSxq2WY8sqQW/wOWOZwCWLq63 +KNvJaZuU6doduSdrYpyQdV5UcG23t15wDrliERxzj2HOpx7h7xGmWYao1pjmk8IdnOI71L/7cj8v GucFrrtDpHoBNlin2arqWj/7/Qfg8NnA5q4oNJ5NvqrKont58174MisJgz6ZS7hdOHdNheurXItTR FxJcjiqBnb11FYB4me3Cu8rVF51eSPj4MNc9Jh8G4giPG/CNZqTClq9nQSoffuYe4SaOIRPZFtFRQ GLm3iNvKcp3jcy5I+MuLOOjF3C0mW0NlJpdGVzaCBSYWogU2FycmFmIDxyaXRlc2hzYXJyYWZAdXN lcnMuc291cmNlZm9yZ2UubmV0PokCQgQwAQoALAUCS98yWyUdAFRvbyBtYW55IGFsaWFzZXMuIE5l ZWQgdG8gdHJpbSBkb3duAAoJEPLxHCPwCivmJRoP/ipPsLJK2ZMPFIEuDu/wfoX+DKRkpyA8HLNjM 8cSHmbTj7mwXabvy/b6hg6bKYBEYw1RyFi990gV5rOHcSaZZPjQJfR4JYxCs7Os9SAad/qjXzQtyw Mb6W0gpIA0tDb3Hjews8iuCRfm8KHAOIgttZDfhO+zcPpyh06NmSem5OayedS5+oNpjzAgWuD6t0+ Cx8trn0z6SoSMYx3rFnYWwwEX6uTicnVnTyiB6nXyNE2e4z0yZ6ByRa5qAB5u9O0SPcrSla7pn6q5 fNtLa5JZUVh96uOzLjPMLCak09FriaVDQf39+08nuggfu9echgNt8Fj9j2UpaYvE+bm03xNO8kr54 ajtVS+1qRk1u8f1oXavT/auSsdfkxbH0JTVoKZ0QJA0bbv300CaHaT3R0VFKeVsxIMMEf0ffVfFwe R1/x7X+0X2VLXvjkJ3JPQF75SErT4OjoA71uKUC/d6bnon87ZBt+SKncWDKBxaOqbo966n7+MKvxI LQpMv4J2FF6JVGtyvYJ4nPd9rmO9SbRtP8ItH5yHsEQUKxPY8cWgj3fQYJOrzTH8Iu4MohjbjKAds dStabnAa9aV0aU+TpgbI8Fmq8xo6eWgAyEJ7eV2xMfIqvcLF74HT+Afpt7JTXlW4tRJ/KUB+t7lxq 1AtFg87E2+WfyE3i6yF5UnDNVtLcp4XtDRSaXRlc2ggUmFqIFNhcnJhZiAoUkVMSUFOQ0UpIDxSaX Rlc2guU2FycmFmQHJpbC5jb20+iQIfBDABAgAJBQJUgHfVAh0AAAoJEPLxHCPwCivmIOoP/03D23X EzImgps7tcmh0pLLQbNoaMeYdeAyr10XIUi5a+3kCLFUqubMernnYjm5agyrLL9ghPRdRMyZrnnm/ /MMW88JM1CmvbgFIsSebaODb0b4xMQ+3nxYxg5SrwlSgTYxTihpT7QgB7QfYD6cLudb9SeHoSvlpm qUfBTBZSTbM9w2QfRwM2eka+ZNWQFEoe9LSRsx3nBupP4I4JiAY0WIRpT9KXZ2Mc3LPveVFPxZfkG utpRQ4cHMmLphpR7G7hmrfWViS3oG+lY/mvtDitKjFIA/o+FRxkKmUHuxpYetvaOiTg2EcKaaTlqn r/KrOgGXySmebxWH7rQTsE9/8TYCfob2B8ODFFMnnETP+t7JoJi1Lw7CEc5mhHgVX0z32lR/qd9c8 8nR0eXCVpR1L1TAZbMTKO+SAyE15zMYKJYxqG8Pa5Ku5idiShhnyPtPykB4hMZ4xXIdN9+3CDlrAd gwWtuoVfYw8TStN3Ua9KkeRnsqvfRwwKvT9RV6b8dmVHVLWhMZmAavFVl3UHyoz6Nh31xg11cSifs WY0KFQ0UpuUwUSWCyELVsR7MFGJmiRBfTJsl4IGcouAEakrkRCtgfV3ZFTsBVXaIuEkX0cJkca/ql G1xqtFMwzNK0Y7/uXHZa6tqF4gPPIQrQt7IAvonJZXnP5WEYhQfi7kgR9ww6e
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-tg05L/QYL25sImQUPFSq"
User-Agent: Evolution 3.54.1-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_035242_012036_E36587D7 
X-CRM114-Status: GOOD (  20.95  )
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
Reply-To: rrs@debian.org
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org


--=-tg05L/QYL25sImQUPFSq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Benjamin,

On Thu, 2024-10-31 at 11:07 +0100, Benjamin Berg wrote:
> Hi,
>=20
> Newer kernels have become more picky about that with the new mount
> API.
> This is relevant, see the discussion about "Unknown options":
> =C2=A0 https://lwn.net/Articles/979166/
>=20
> We only use hostfs for the root file system and in that case it works
> well if you pass the path using "hostfs=3D/path" on the kernel command
> line. Doing that avoids issues when remounting the file system later
> on.
>=20

As upstream developers for UML, what would you conclude it as ?

We've recommended using hostfs for the UML kernel modules as well. What
would be the alternate approach to ensuring a proper boot for a modular
UML kernel ?


> I suppose that currently it does not work to mount hostfs later on.
> No
> idea what the right fix is. Maybe the host directory should be an
> explicit option like "hostpath=3D..." or so to make it compatible with
> the new mount APIs.

The ability to mount any hostfs mount point was/is a feature provided
by UML. We've used it and integrated with many tools like debos,
fakemachine etc; the Debian bug report has the details.

There'll be more reports following once UML 6.11 hits Debian Testing.

I hadn't expected a working feature to break with a newer Linux
release. :-(

Thanks,
Ritesh

--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-tg05L/QYL25sImQUPFSq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmcrWHsACgkQpjpYo/Lh
dWmo3w/+PkUdvvjzCWAqGqIOHhsz+C7ZNdks8Cl8hyKl5UIsV5AsY9wnz6FEb3zW
TaZfoW3RJUCouHFxS7pFx2+X6ziceK4C0Xb30wIE+506/W/hKqP/E69Ol6S9rkhp
UB4l1fN5aaFzI2S4VuJJL0C/PNwspQoe9WI9RVZXM4p5VuYImWwqwP9FB130EFPc
n7jER1R+4TGGmApbEamKzViIunqcmv8s6m/edX0KPE7BW5yq1UWyAkRj3t8zVhYw
ZTT4BSwuJa3kYltrYQuBm4N4lmEu1FPXWQ+t5Y9OfR55wGmWllLwZ8hcpz9+6OjP
EKo8do3v25R7e9/WyBtYw6k6D5aJApAisdcbXQVEG/NF+wy9uyvS9+kjjXxznGJB
KQkhZFaJX7xnXe905DXXxtN03HpvXu5S7NFcWkm3Pkag/Cp6bewu2Q6h/tuRL5u8
knoPkIPtaBu19XEi/54vSQLcdXKfYB8ZuGS1v+eypuDDMqj+Uf3bbOHKEhY+pkSn
zMZLk10ZtTC1+8RNGBwSuhVMZdW8QaoikoWehDMhMywvfW2JiPPLRX3Z6JHz0KSu
FplTQOk198fbDgivp8xN7Xo3J7D3xiaTJdqI/XLOA8gC/e5fKyw4r2r4dtXIL7+z
zEvDWEBcRbxwiJNnOev6iVTrLGqjaGP1b9RLx8PRlPB+BJp9Dt0=
=vEk3
-----END PGP SIGNATURE-----

--=-tg05L/QYL25sImQUPFSq--

