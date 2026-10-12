Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30411CA9EC5
	for <linux-um@archiver.kernel.org>; Mon, 12 Oct 2026 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NadqPd/uvs6B0lBY2MHcQwXAbbvTiPDymQbU6+UNoZc=; b=QwZmJ8/zMAIaB/eX86V/FeVMOn
	W0aFhpDTKI3Mur74bjrMYc7RzbwG8/l8cMh2KCTdkbzvbiIH+EkCGfxON4Pw9wCm8Elwulwfhr0PW
	SRwqf7gPNq/wcjSuAeNTB2uweQt/jFpSkwXcD22i4BieGDU+UftAPTx3KLp8h96EpW1qIy7h3PsOY
	Y8uGtsUJhAu2CiuQue5d6zl5p2oHJzh1HfHyPeZ9IRwOQF6zcLpeE+7wC0C1D3r8/UVrhBdztQ0Xw
	FNcbBFfTcGbt+fbrzH43wPdpyQiyLmxf5A4ZOyRJY+HOc3jUOI6cbEeRLUdnJmGUyXOQCCcUZ7jR0
	Z8tvw3Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHDS-0000000AiA2-0Jjj;
	Mon, 12 Oct 2026 14:41:26 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGHD9-0000000Ai85-0Dt9
	for linux-um@lists.infradead.org;
	Mon, 12 Oct 2026 14:41:24 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-33e623bd651so227753eec.0
        for <linux-um@lists.infradead.org>; Mon, 12 Oct 2026 07:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816065; cv=none;
        d=google.com; s=arc-20260327;
        b=IVMDdzAV+1vkuFsu98/0aN0UOjOACOXFlco+W3PTC4h+wn65gpp1fgu736vjstGANI
         5iXyyA++c15ZVQNMBlCoioPzruNPtXR3citIbaXR5OZZnrtM6rGgQ4UbQE9nRsaEzEFS
         0pUI+iglqs6OL2xpOLqp4daKJgwystEvC8F155xYCuEYbTB5HsLNvxc2ZKgg2tXy41E/
         UTNCvcB+wsjJGSmvBuMbRGYOTtpxouEOY2n1DMG9kJwA5nj8LrgoQRKltW+mvPxR6f9E
         eKf41OsJvfCQBcctwKFsPuT31ckkIo/Xme+qklZPSqUClowwRA6QDs7gMCvWDPOWpb90
         34yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NadqPd/uvs6B0lBY2MHcQwXAbbvTiPDymQbU6+UNoZc=;
        fh=JZbJufv72zQmt59nMqvTJiR1JQkvROLXEU+2W1hkdL4=;
        b=a+GWOMwf9DyxMy1aJ8N4EUvqdWrqMHWFGXWEKpFmZn19rpmf8+I5dfDpVvG9HrADgB
         yIYd2m5DsBpaghtH5Gb2gm+9bVZ/mVClJYOVq/Wb5MNMm/jTJE6RMGH7UnaSGWAdf6nu
         LuJYa6xBsrSHnZha/ce4g7463YE+1A3vftA6omRCTUZ3+sw0iU2oST17oDKvpLf+I7uV
         TbpTGZ76fGJ3tGg6L+l8L1ku3Rm7BiK0Z1BtF4U82OLhZXsIuVnEgtuOrqedvBixNvSS
         hW+AT9BzWT5otQhefFL9HGpFjRdS+HrlYlENI54i5kJMRpT1eHqSiCb127u0jtdOIpde
         TYDw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791816065; x=1792420865; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NadqPd/uvs6B0lBY2MHcQwXAbbvTiPDymQbU6+UNoZc=;
        b=TNR0JZN3APF6GKHIzWYg+NDTVcg0ahlz9vK5UU3+4JL9Euw749aoF4KMB442QsSeGk
         YyLJc1k2YPmnwdwV5mT81oXPq5xtA/keC0NlTmBA/P2WWvOqrsVqt4jJtgvEFHAHPLBc
         zy9EBNMg24V3m1TFtYRq36N6+pP73m1MGcG1OatNUMqe2QpZ9De8gF4b06tQa25UPTqq
         JN8Sybgv/cA+0+hxA8FdtzCRPMeus4kZD9m101C0RVapCa3MlJPNb3lnfzVqyd2ahnzJ
         7kNChxqCT/hnjJImnaUfoh6wdh0gxaM8mXMLsvLOsWCOVPAQ4WVlBdcDDfffegpRdQIA
         IMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816065; x=1792420865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NadqPd/uvs6B0lBY2MHcQwXAbbvTiPDymQbU6+UNoZc=;
        b=es9jLT953dnWScID+mTKh+bnY61gHv/4m2bunNxHoIkpqBugsO9zF/zleoSgIVkxYn
         Wom3JqjtxELtbGGjXnsxf6GqHPUlAKdzEWR3Gz1TbOIYFh52rzggL9EXsxjoD1BKkCL0
         y7MEEU4/neSMYttLmYNENxrk7MrA3Bqw9xuuMqI0XmpxSM7o9t4gkyNtxzvNfZtZrGU2
         rdyLu5LGL4xt8jBosU2oGd/X+Og0QpknPVc0QQuvI802zWOCJ0h5bLaTEddgP9HN1Pey
         YkYf81w2Aw+ESRm99KKyexvOF45OL3CbRRWqlWOWGHkW8WjX2qAh2I46FQw4km+1Xbfa
         E9kw==
X-Forwarded-Encrypted: i=1; AKwUvBx1/HjE0kfT1SG+gRGRbEdemOOdSIDD+a8FdB50BqtPVxjPXqIJ/9UfJdp0BG18X1+8WhnPFiCE9g==@lists.infradead.org
X-Gm-Message-State: AFq9FYLI43lIafcxY3D7aWflWCLumNa1BDMZbl57xOSzR+pGv+g7T92P
	HYDhaz4wMsnHUpmCcvKBc00VQEn0gYUNvY6EENpyNEwVjuq3A9HbohIeY0BfciC29VV4TtVIcT0
	Kn0J/y/mAwxhEqT4jpO4HyQcBTF81S8I=
X-Gm-Gg: AYBFou3HLCoXQ8IffG9dAohVCGOG9kxHgU5UC0jjqg4056xrSOVRHOsOrGaKRpbFk1f
	8LQglmbfiCPDJ35xYHN2MgGNjZoLO8X2T6VA0/QFa2FAyNdJRgNwk/ZLpEEZ6g/AAItNLsG1CUI
	KAmdgFe9gQYfNvE+9Vop5uZkRi4QH2AdEiXgCP7zrW3Qtitudgpx9HmxlfGXPGHEG+YSAv6BUbb
	EztVgX88AMQbt7P7C8DhOOvPL6W3R+4KMksz1XJONO4R+Oa58fa8fVi+zFJAgNmGODMoWr8zsRE
	Z++H4nRHpvsjvdV8MBmhsFsDAlLzXABgOLDrtE2uy/NhZk3ixhFlSwMEkidBePbM282byBwPwZr
	rCqfSFlOfu0bMFba3YgqjcPJ9lIK8Gs/ygPDswRkqjlC2zlvLh0RaDtxf8KMtjmeX2O6CZ+sEqr
	pyw3dO6HuUb3yOK7gZv+2YvIpg5jNnAGrCdhT21nHDW1EYT8u+HklTAn91u7oFXDA=
X-Received: by 2002:a05:7301:428b:b0:358:7ed4:a049 with SMTP id
 5a478bee46e88-3587ee40938mr14086041eec.0.1791816065173; Mon, 12 Oct 2026
 07:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261004121230.373216-1-tomo@flapping.org>
In-Reply-To: <20261004121230.373216-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Oct 2026 16:40:50 +0200
X-Gm-Features: AclHuK967sNCwIuE5Qfb6l_lpCmzHVhHAK0gIHkOXAoJD5bt4FEZJrItXK8pbdk
Message-ID: <CANiq72kEM1Z1yb6SVSCrEBfFVim2R-fXfSSJG2xphPGABq0H5A@mail.gmail.com>
Subject: Re: [PATCH v1] rust: arch/um: Fix loading Rust modules
To: FUJITA Tomonori <tomo@flapping.org>, david@davidgow.net, richard@nod.at
Cc: anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	linux-um@lists.infradead.org, lossin@kernel.org, tamird@kernel.org, 
	tmgross@umich.edu, work@onurozkan.dev, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_074107_104576_ABA8E8FC 
X-CRM114-Status: UNSURE (   5.95  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Sun, Oct 4, 2026 at 2:13=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> arch/um/Makefile adds -Crelocation-model=3Dpie to KBUILD_RUSTFLAGS. This

Hmm... That was intentionally added by David back in commit
905a77077573 ("rust: arch/um: Use 'pie' relocation mode under UML"):

    UML expects a position independent executable for some reason, so tell
    rustc to generate pie objects. Otherwise we get a bunch of relocations
    we can't deal with in libcore.

So it seems David faced other relocation errors (?).

Cheers,
Miguel

