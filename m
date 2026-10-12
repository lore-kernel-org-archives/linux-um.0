Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF53CA9ED1
	for <linux-um@archiver.kernel.org>; Mon, 12 Oct 2026 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPjrtb7l936ef5b/bGwD+WeOePZE1NghsYuXVPIqEwQ=; b=JRY8+bjHqt0M2Zbfcu4wWJgmzO
	K5HGp0DIBvHNmTD778Q9Gi/ol+81LfOBuke+cQnqgaEfp8fbIdvmFbSQnRyXldDVknwYyU4WaW+cj
	0QamKW/18X9gQiBxdNP6HYr1MLIrHwlv4+1/DeZ+qJJIlNUIBZ5Uz8rstILoSYT82UOeOOal78Vnw
	icZ5BNGFV8bd6Me80yW1Oa8bPB0frtmP2ubfbT0QZbuJ0Sjk0fTuazKJ0L3ZMeRkyJTParnVr7eHS
	Vbp6vWJTB7u5B9xj580Ombh0c6sGtbzLHnZV6c+EXYTJv8yZDiyu8WspSbBcBDSJ0DNptUOUORtcl
	06x5SWjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGI3u-0000000Aoq5-2NOt;
	Mon, 12 Oct 2026 15:35:38 +0000
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGI3s-0000000AopV-0TGo
	for linux-um@lists.infradead.org;
	Mon, 12 Oct 2026 15:35:37 +0000
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-33c30fcf33fso267288eec.1
        for <linux-um@lists.infradead.org>; Mon, 12 Oct 2026 08:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791819335; cv=none;
        d=google.com; s=arc-20260327;
        b=H1JRPtkyre3puxJHD7QGnjaGaRez2rkPAIeS15pckJOjq9lhXr86IfTiRJ/Rqs29X9
         wtB47E44g5sagcmLGf3O+2ibDvBUu3A4AbSW1y/hd/CoQc6OakmfOONp9iiPFxb6im9y
         mF9u35OtlmSLGrhkPyPRr3z25slekIlzt+ohIiw2a0D8PPH1Va1lhGeL9QVul2nSUkws
         5tL6KBnONfSaY8J0SBf3n4j9x/w45PW48ed9uqrWMnKfbcPnuZJOxVhvwEpdUP899Eet
         vS5u1OPbJA+mf0B+QhMnL5iEEe3z+UpJQ/Me8Cy6ZQiEk7i3ab19jk1gfPqZD7YAhbjQ
         9tWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RPjrtb7l936ef5b/bGwD+WeOePZE1NghsYuXVPIqEwQ=;
        fh=F9hT2gBi7msldlmlBK7nBGKFqcCwF+AG1BIIL1JecdI=;
        b=pOELql+GTX+RWzg07XhitKR2zwScxfRDmJrmk3Wp6sezjGYfArCGvJq0xhr8Rf/gDO
         3g+beHEUMVxbCFKQIzTWJ5JxzSXh8XysscmB06Sk44sjJIObEVqv0xs/PuBrzXYtr+ye
         d0grI6ZN7TZ7Gl3AnpDzcq1JuHBSnEHDnz8PX7pdhbZWTqBXqcDz+5h7oD8E5CbQ8mC4
         VSnNzBsr332Q8OGSi/c/LNsPFu0oe1c0reeEA38ednkYSuu+Va/xvfuzhgamXPB+DwO/
         3oKtlpB9lvRK4cKeITIdaE5+RnCjEsMcQ4kxpKifVtNCrfpykwwjqOWz4ghdrZWyvlcK
         BlDA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791819335; x=1792424135; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RPjrtb7l936ef5b/bGwD+WeOePZE1NghsYuXVPIqEwQ=;
        b=cAkfOrHnIGF01ZKDEQ/9QQqiPd0O8B68yTHTD9CW1FCNSJCs/OCGzLCiKyFBrLuKtr
         VAy9Oxt6kGMYPtwzGK+wNCKf4QkuKuw/iGiRQ96iplZ8/WTwlkPjp3KK25cQdT/dO+f/
         fU8b5errJ8TSxLzrGwdbTtN893RQgtpV7WlFFsRXBQSsLrCKIXlJZYli6jrJEbZhZg2c
         YyEwqMx5QPsaNLt1HSd2MeNXEt6QyYHHpWDO+AGgm6JX2Z+Aedb3g89W3b3rNBtaSLDP
         t5W85nJy4DnL0cSCIdg+L8za9yXKGOhXUmzewkMvgtjF6p1TFzKIy0HQJU9MSGnLZUlO
         v92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791819335; x=1792424135;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPjrtb7l936ef5b/bGwD+WeOePZE1NghsYuXVPIqEwQ=;
        b=jioFsBtzSLM7In6v90bUtrOKVLHK3A6N853jS5GvIrCYsoMJY1IlkBfCafLLezTEaO
         33ZltZEHTo9mbTZBxSMDY1UgiCDdHeIREfdHWrf2YtUQAMPUW7TUmkneLdeAFOinApkK
         4LTAGS2z8Ak86cPmzj7FxvUDKV8W772zohAYdQnuWAKiZq+Dstlcpy4v0roMXIDtuXZH
         qkkB4fUCmCaFminLiaQf3Kbz5g35kBGVO7X2wsxD9GQMlJXwjnxg/3UrqKvRevvI8nGk
         Ny4o+Pg35FI3FGkj5mNGFcyDV+Nh8ia1EIJqsowEO90JT0mQ6yxU1ZAi1SA0MoPndhoZ
         S7ag==
X-Forwarded-Encrypted: i=1; AKwUvBx9wcda201MonZvlvHFhjDiQK/2io0++C6SgHupS/9zQPmRhdeuNCsDZ/bdyn8289L9MCu1JSGHJA==@lists.infradead.org
X-Gm-Message-State: AFq9FYJ+b8FFV/IYukY/XYbcOfR36N5sbQFMQQQh02uGBtHLFPdY/dgw
	AaI+a/WA071Lg+FjmL9ypzs6vXsT0Pcg3DPsUdXK7fWjr2AchiYJqWUjtNATayOVH5WaHqPcXzn
	oRA0K4FQ8i6hIKQ8hR0CsUGDf5PV/w4OjHknV9ZINSw==
X-Gm-Gg: AYBFou2V8kE/OvEM+pdmStlMXREm4SleobT28IHWmhFKx/9GOiQkVEr3kYKJ+5b7nLd
	GlpxdF9i699vvkfvysgdtRCA2hdpVp6B/l+/CBjFMHCD4+8Hb7vMYFsxD0uNsxFZ7ER70g9apeg
	+fDhYlbdtZHSCfzRYQoozwaj4cZ8RtMLtYjX/+yyLheR+nUTDV82nLHvOZ1MokfB+VMJZ9BtQCt
	iNO7Nq+a6h/ariSyPlxyg8vL6QCX3lwoTXuNFrMe+nCGzVCBDsLLXpfjha5VNk5kzhPwNmYopNU
	lwyZghh8iuS9oVNMGQvEoTCCsEfOMTVXoUPl8LlOTVrumVbRxV3ACpAQgU4UbgYtEUE0ZmTkBAO
	pqXlkfL4vjNeFm8qf1IgPRXVhVNmSI5DV12/pfnV8yH/7lyLGwtXILAuCi7Grpzh+lCe3hqteaL
	heh7NrdKgZE6z29HmatA98RizUPEYPl4kRlq4NThfDGnwO8Vems43UoeKKRjHCLQ==
X-Received: by 2002:a05:693c:8810:20b0:35b:cb5b:c71e with SMTP id
 5a478bee46e88-35bcb6b1c6cmr1545025eec.1.1791819334971; Mon, 12 Oct 2026
 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20261002104550.2877930-1-tomo@flapping.org>
In-Reply-To: <20261002104550.2877930-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 12 Oct 2026 17:35:21 +0200
X-Gm-Features: AclHuK85Pldtr0ECoOLRtFhNaahZKiLNXk4rmJudeZbxydISuiGxggKATO-0hgg
Message-ID: <CANiq72=pvipUs95sjkyk=NTwHK3AT782VB5BACJzuruW5tSzZw@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: update the SAFETY comment for
 warn_slowpath_fmt() on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, anton.ivanov@cambridgegreys.com, 
	bjorn3_gh@protonmail.com, boqun@kernel.org, dakr@kernel.org, 
	daniel.almeida@collabora.com, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, linux-um@lists.infradead.org, lossin@kernel.org, 
	richard@nod.at, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_083536_156481_C455EE6F 
X-CRM114-Status: GOOD (  10.58  )
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

On Fri, Oct 2, 2026 at 12:46=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org>=
 wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> The SAFETY comment says that it is always safe to call
> `warn_slowpath_fmt()` with a valid null-terminated string. This is not
> true. The taint argument must also be a valid taint number.
> Commit 951d09ca450c ("rust: bug: pass TAINT_WARN to warn_slowpath_fmt()
> on UML") fixed a bug where it was not.
>
> List each condition that the call meets: the file name, the taint
> number, and the null `fmt`.
>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to `rust-next` -- thanks!

I added:

    Cc: stable@vger.kernel.org
    Fixes: dff64b072708 ("rust: Add warn_on macro")

so that this goes together with the other one that actually fixes the
issue. It is not really a user-facing fix, but it seems to me that it
makes sense to put them together and to avoid a de-sync in the
comment.

Cheers,
Miguel

