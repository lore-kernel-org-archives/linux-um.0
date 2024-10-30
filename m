Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8460D7497F
	for <linux-um@archiver.kernel.org>; Wed, 30 Oct 2024 08:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Type:Date:To:From:Subject:Message-ID:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NglDNZ87Sx1pNdTq5ZJd/sX38yUWc0TPAFJwlACBMgc=; b=1zWOY8cWg9DtDHwp4UqR4wcROZ
	nBjT7C+Vh6GZq+OrzeZGgoOkNmsSVeVbLWu2JLYn8T36RWOMcme5J231r/NpNY5NAlERuujEbtk5+
	lxfnWVwDQ8XB3wmX3siY5Enmp2Nb/1fmi5kdFjCTNhH0JD4CZgx7ZWq8/88KEgmbPxjtWO2KXDOJU
	LDMBJVDGUwD/ScbkbTOindyMaD0+cN8T8eiA9xYhg6yzIlxTBl4rDIiIFitoHvORoxdl0WQuL733a
	ktLDjG1gP1mdqjkNxdkB6NTLPKAlSHEiddgYdMkrkbPdOQZiiLf2GZIYIbiLv0ftmOY/sl/YzkLPA
	eiJd4oWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63qw-0000000HFbL-2Wg1;
	Wed, 30 Oct 2024 08:14:54 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t63py-0000000HFUR-2yII
	for linux-um@lists.infradead.org;
	Wed, 30 Oct 2024 08:13:56 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so4587964b3a.0
        for <linux-um@lists.infradead.org>; Wed, 30 Oct 2024 01:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=researchut.com; s=godaddy; t=1730276033; x=1730880833; darn=lists.infradead.org;
        h=mime-version:user-agent:organization:date:to:reply-to:from:subject
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NglDNZ87Sx1pNdTq5ZJd/sX38yUWc0TPAFJwlACBMgc=;
        b=EKyPPP9WErEQEI3vUe2+uDwy7oLUChFMMi2z8EdXpm0NGwEwLNuLMIT6pcfnPKEC8h
         rSpQ2ksLlBqIiDkId7F/oPh6XBjAun/jfnsRHe3gHW+zK1cmJFPH7hL0s4j9Km6An9Yw
         Zl2d+fJ3vXMSZzC1FAcP6UTrpFGh7Xaa4h3K5b9m2Ci5FdNQrDYuqtLefaHzQQylOvyV
         32hREDm5IkdC/udtRVJDnTx3CuDGABeOpqCD/VmYYilVsTzFrVOfIT0/WHF5bgf0X1vz
         nLzdEPtvYfulzS98DH62Wcg2Bg11tdc0vnRPkeQjlw24Fxzd9MWt8HO8dwLmaGJKDaIF
         qj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730276033; x=1730880833;
        h=mime-version:user-agent:organization:date:to:reply-to:from:subject
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NglDNZ87Sx1pNdTq5ZJd/sX38yUWc0TPAFJwlACBMgc=;
        b=hoPV4yxks1zTcEZpgxZN1I7yDhHuK5prkOnZMLuOWG5ij5+3D3wF2paeeXxyajJcBA
         AiCNDoktJj1zes7jpT9KE61Qt/ePrbs/O+FzFtCvDPq66kBWVyYqf4pRpBBQeNHJoMrq
         e+7+iT0Zddh6ryegJxm+odBlh3KKkQP4qKhgTD7DiJ/bKziWCYn+k0XksB5qz+RCHrrj
         WhnDHwdX4Hwh3kE3qw4tkjGPXg8TeikP3u1XQUU99sds+89cDcYpHBGXPGgJtl5ytdCE
         7Xd3MYVxx7aOT74Rj5AU9TVV4y2RwkVxbJvcmfVEGOEd6wIjif1yDAgo8QvSGcVlMHT0
         aWDA==
X-Gm-Message-State: AOJu0YykGf7ZD0cileDmIBBY/7dYsGG17mMt3ci0JSDZugsJvsYnyRTX
	ZL/A1CuZjQqKC6YoT8GIthnVGCnvuKcbEzgM+y1k29Q293YEge/lrihRr+FB+9ueBzVzi9/zyer
	H
X-Google-Smtp-Source: AGHT+IGaIGjZBkyJ9X47zxh+isMUlLU4axnfXUnN2YdCTDsmYBQRJqMlw5X1uJwxQ1WPUevODST29A==
X-Received: by 2002:a05:6a00:3d55:b0:71e:3b8f:92e with SMTP id d2e1a72fcca58-72062f4bdc7mr20604979b3a.3.1730276032784;
        Wed, 30 Oct 2024 01:13:52 -0700 (PDT)
Received: from priyasi.researchut.com ([152.58.244.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057935832sm8795693b3a.84.2024.10.30.01.13.51
        for <linux-um@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 01:13:51 -0700 (PDT)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by priyasi.researchut.com (Postfix) with ESMTP id CA31E191C3D6
	for <linux-um@lists.infradead.org>; Wed, 30 Oct 2024 13:43:48 +0530 (IST)
Message-ID: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
Subject: UML mount failure with Linux 6.11
From: Ritesh Raj Sarraf <rrs@debian.org>
To: linux-um@lists.infradead.org
Date: Wed, 30 Oct 2024 13:43:42 +0530
Organization: Debian
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mQWxJ4zxraOglGfOLaz5"
User-Agent: Evolution 3.54.1-1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_011354_770674_A0327C90 
X-CRM114-Status: UNSURE (   8.15  )
X-CRM114-Notice: Please train this message.
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


--=-mQWxJ4zxraOglGfOLaz5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,


Recently I updated the UML package to Linux 6.11 in Debian. Upon it, it
reports the below regression wherein UML cannot mount file systems of
type hostfs

We have it reported on the Debian bug tracker as well.

* https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1086194


The mount failures report as:

```
Oct 30 05:57:41 uml systemd[1]: Mounting usr-lib-modules.mount -
/usr/lib/modules...
Oct 30 05:57:42 uml systemd[1]: usr-lib-modules.mount: Mount process exited=
, code=3Dexited, status=3D32/n/a
Oct 30 05:57:42 uml mount[814]: mount: /usr/lib/modules: fsconfig system ca=
ll failed: hostfs: Unknown parameter '/usr/lib/uml/modules'.
Oct 30 05:57:42 uml mount[814]:        dmesg(1) may have more information a=
fter failed mount system call.
Oct 30 05:57:42 uml systemd[1]: usr-lib-modules.mount: Failed with result '=
exit-code'.
Oct 30 05:57:42 uml systemd[1]: Failed to mount usr-lib-modules.mount - /us=
r/lib/modules.

```

As I understand it, the issue was first seen in July, around 6.11 rc1.

*
https://lore.kernel.org/all/CAHk-=3DwjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXj=
AUFO8Q@mail.gmail.com/


Thanks,
Ritesh

--=20
Given the large number of mailing lists I follow, I request you to CC
me in replies for quicker response

--=-mQWxJ4zxraOglGfOLaz5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmch6rYACgkQpjpYo/Lh
dWksrg/+LI024rGDy86Etgyd6K/eeInS8Bs2DNbbmdcaZGECdc8hNRasMVfYFBhW
B+3BGdL5C+3ZPgb+Mlv1SVTU77lrFXd6HWl0bvmjPobf/cq47foSuSeublZOZdur
/pK6CqULYFKeNRsCFqPwBICcq5CXYhnq5hyun1AKldkorrVcmKOV6AJ1W2uFe9xY
VyCXMpxur8IN4+lEGLaLKQr/d6vdzsbPx81avoq+ZcxB5XAtitd0TU5lYPV1eCVT
ZZ8mnlE9XvnEz1SU66RXyyXjfBlBDEIXRLxMcib4EjtNpJjf60/c/V1ivi7bOYT+
+ufw2JufgSjH88L32x3aPmzyeFZw2VYKdntB1PO1koxJuymktXAHbgz7vIVXOnTb
vszxiIK57NqLYt+SqpIIEOx/5s3MI9lATJ9LMzzjo0cMGVgE77ICt/ZeuVsxensY
Agqrc/xpXQ+keHZCuxClXnZozvjMMheRYged0g2eehphqKTVVNycwmmN2U4f+MRs
aazUCQPk4VSsjg/1+zf9Aer456ZHVAjOhLFEXQ1WOhNgcn1dsU/4PaPFY7iBYlU6
RsbCtZuIxSGh1hLIkcOxYhd0/xw3YgYpYU0OOGVikG6s9SQ9+y2Hxy0+8BH3cp9s
+24k7fF3IoBY0g5Vs+T5aYYaapYSJXqHjsnEJX+qrNRG0DX1Blg=
=adhH
-----END PGP SIGNATURE-----

--=-mQWxJ4zxraOglGfOLaz5--

