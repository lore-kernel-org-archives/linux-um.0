Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F06FCA5FD4
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 10:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1BcgLlwIDQd7WDm8rTVE7lPjWHBuss1Gdr7b0jYHET0=; b=Oj57ynpU2t5qjYVLMmG4ssolBo
	2wztubPZ+393z/70V3oaDaAKG0oWx84gQzS52SamRSTsJwF4/r7NO48tb0gFslg1BiWXl1qIj3Deb
	H8S3gyZPHMato5iy2cV9S/qGnI1wDdVXevoz1VZeNRSe7sipUuY4fElzCz4v9c3p5hbTXHUMK1fEG
	3ed0LPVIbzdsD8tqNr13qZrlseUjHdQ7Y2Fs5d8UCZvKH59/oHn9MzOXKqtZFM2oVJBMo6SAQlKof
	9BVMDrnwf9IxNO6Tgg7JEUTUMaIUcm3HwkCn1wHmxGRivcBwyHwvfK5g1b+L6QzG/GREEemuj9jZD
	cajsv0Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCauw-0000000BOC8-2F9V;
	Fri, 02 Oct 2026 10:55:06 +0000
Received: from mail-dy2-x10.google.com ([2607:f8b0:4864:36::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCauu-0000000BOBn-01M3
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 10:55:05 +0000
Received: by mail-dy2-x10.google.com with SMTP id 5a478bee46e88-32be7127c64so902401eec.2
        for <linux-um@lists.infradead.org>; Fri, 02 Oct 2026 03:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790938502; cv=none;
        d=google.com; s=arc-20260327;
        b=l9+6UNT8ikh9yKK7dCYyJneeXxmHdrb8RwhIxA9PqKZkzil0j/4NfCngejK5zUTUFr
         seRgkue5HwVTdO439MBdtRDmycwPMM5z4aNARlGtPl/q3asjfiWC1YTIjX5w5RB7d5tu
         tlSzqoWfrKJw1UPCY/CUJmFbfWk+oMRZny5khTsP4IT1egaDL+hdarRk6knmCyB2K/YT
         fk2rj8/cYDpVvkfMucJlvOTVoMgzxETFKavvEmdjKf4HePuM7LVbSdOXvLTjBWh32vKB
         gaTvKOmrGvFQh1JhW6AO4UjtmK3hlJ4RerhGKNx2g3dyK4QSP7NqV9n7mkfZrDlpYEUf
         Ijow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1BcgLlwIDQd7WDm8rTVE7lPjWHBuss1Gdr7b0jYHET0=;
        fh=M/a2JyfonrSxL2m/8/p9Q4MVLZ38p98WlC4BjVXEz80=;
        b=mrS17vjTjHdUAELEzBuCsvjQufNs7/uU65y4JzWM080W9Ca5bph0KzWCQJ2luAHYXA
         6MtOzx6jJVQ3liA+KV+U32/Z4RsXGT94bjEAurUg+u2wpdQqb0wIkdg/Ycz9y6Onfy9U
         M+cKWHWahcDlp8QMXiKUeFGXSRlDCyg/p5GE17zp73U+nr5p37mYNWQi9pbsIN+VhVJs
         1gSf0fIM5qg8BH6UgC9gGLZ9A+su2IP7ygzdMZ1HrZYExNXl94VjuhZjOo/bbxFtr13z
         +3dnbS5x9R0O0J0g7Qw+aBtSPg9EopT9j3DYUffoDeKW2Ntf2PSjByY12v5p1xYem24D
         9jfQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790938502; x=1791543302; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1BcgLlwIDQd7WDm8rTVE7lPjWHBuss1Gdr7b0jYHET0=;
        b=nmyAecUjGO0hWtAKu+mpIv0+Sz/Kv7zy1hKCj6P8YCt57B1M7piKGQ1aHH6WlnsSNJ
         Po+3OQZ2VvvgYN6qYcv39Rp1biW+iJY/PYhB80jAD/Gf3kM4GEZUuhel3UxIO2qWiPEs
         XDSzHbf0cVTHSON6QU5PrR47MT+oml2yLfQeSlkhbcvLnAS9WHXYh63Wd7ndYWCFdRlM
         SNpfUcep2NeR8VECEo3cxH2uDhFsh4SoOGQG670aWJs8/W2a0Q6A1hKsraBOr75U3QX7
         fl4aB+1M5C7XZh9HDK34wLzkD7CDV5AOr1cUN7R7XpL6KBWZ4cSbNPY+B6qBEIzdt7Zo
         Cd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938502; x=1791543302;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1BcgLlwIDQd7WDm8rTVE7lPjWHBuss1Gdr7b0jYHET0=;
        b=KV8PPZ5WD1AA+5BXKg8DaXsna/MN8JEhtI/tSwYTGjXPN5ydUomOdi027/EC8SdwI6
         Z4jkUQ+ow43nY9RC64/tA2rIX+dCqlN73G5bmLhnNx0vlYOXNvwwHcl2HNP/n6iDFjOc
         Iy5jzwPh+y7jwLjYC67dterhuwtppxnSPO0C7j2l/HrLElb/TgF12ZfDBsbVrD+CBZL4
         Rp2c8sNkXHGkuA/zNfFYSX7bfYinfMdAsu9aRGxb5MfcGXhvMgpYJrii0AM6lR6MLkE5
         WqQ+I8Jj+/rHleeGlUkZYom0QfUCBfLzY00ujiIfV6LHIWh1IBOQmeZtnHR0z6MKLziX
         qV6A==
X-Forwarded-Encrypted: i=1; AKwUvByM+eTLWXgQq37zHSjvxuYaAVQl7KBQ1CUy3zpQEV7h+M8IOKcdEVQejz5m1t0mMDTEaM/XzRtPww==@lists.infradead.org
X-Gm-Message-State: AFq9FYIJFeSOAsOZvN0logh85zDGDziGbyh+loWbMQ/czaRiSzRYauef
	W1c8z+gm6qpyBkuJdy5zQeMkEuMXIsHdoy4fn2LwUOwzoiSEr9Um78k0P7URJThezO8ludEqaXc
	WKGqBJXG/4jFep5C4f58SqDt2dGkvUly+xike
X-Gm-Gg: AYBFou2Kbg+fxznMNWK7WbbbpaHnnyNh6VRT30XGvGXTHwu/CB3o+SA/C4M1FL5a2xU
	AULHqkEKn715ZTddVMKfe/mhAk04tVCPCyIcmruHJbF46oRpm06KNg14W3V6ZEG1pNs/1c7QS7u
	ylsDBtYhazHh04ac+xBsGWx8eFyQScaYFJcoPeYZzE7YjL8FlEExk7RSWTW6tUhZG9W/3zXHlqi
	q63RwFTOT9vMAVyawyPdEgNUBo/ACTppNYUrX1hmix1alP/FP1lUKaTbo4hXNG3Ddjb8XojgTel
	8QQjkcL5/jBcLB6Xnna4+aM8KsDv/+Sg6/kXslmsL5n6gG5thFXQRymWNOeIHpxWEdMEAsZ1oa4
	remKrmxov3IH3pSDY0nMIglANICaHK9OZAsWo6y73GtL4MHb9iTD6P/yntXwAXLVhm6C85rbA+r
	k5zwoStA/fusqYLhFiG+n/RKKbHBaWHzATXBYhhz0YOzniOMCXzg8=
X-Received: by 2002:a05:693c:8951:20b0:34c:15b5:b4e7 with SMTP id
 5a478bee46e88-34f1503d60cmr4177305eec.2.1790938501968; Fri, 02 Oct 2026
 03:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261002104550.2877930-1-tomo@flapping.org>
In-Reply-To: <20261002104550.2877930-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 12:54:47 +0200
X-Gm-Features: AclHuK_EQJEqNSG0UyehlQ3uYP4G6dyInoK_YrzSm866R9UGablAYdj1wxvktZQ
Message-ID: <CANiq72=i189z9iKtz0x8qR2YO_R1WEPLcRGr3q3aOTwXsEQN4A@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261002_035504_084854_5AFAC0F2 
X-CRM114-Status: UNSURE (   9.76  )
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

On Fri, Oct 2, 2026 at 12:46=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org>=
 wrote:
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

Thanks Tomo!

(By the way, you have been authoring all the work in this file -- we
could have an entry for the file in `MAINTAINERS` if you want it)

Cheers,
Miguel

