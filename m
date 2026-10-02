Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2D1CA5FC4
	for <linux-um@archiver.kernel.org>; Fri,  2 Oct 2026 07:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=; b=Rv7cw854QA1uUoUr4wA78vY7yK
	2tjVd/a/wO9ueU/wwshsy/+MAFn2FP9jm9eOEcDH0rzZK6HDGBMLbmAFjpgOeFlPN0K8WBzC198Ia
	tRdOEnsLI14yZZh8/6FYFSCN8MI2fp5Md3b9yg1JhlGUHRYu8kBYjMyCNdUvpcndBnUVWmUSywujs
	/HPlqt6WOAI7OHf5R6+FSTsts5thhV41MTnwIWEb1sWEFrIJgU952bdute1Fw+ZF9ydmNPdMEKtME
	3mXkKeniUVhzWQZhen2IIalaVGlcsKvBqAjEfq+TMY2/+uaUgbStlKOXwPnXhUbu+8bRus6CTLFEL
	056VHtPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXMH-0000000Am04-3wto;
	Fri, 02 Oct 2026 07:07:05 +0000
Received: from mail-dl2-x0c.google.com ([2607:f8b0:4864:38::c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCXMD-0000000Alyp-1g6Z
	for linux-um@lists.infradead.org;
	Fri, 02 Oct 2026 07:07:05 +0000
Received: by mail-dl2-x0c.google.com with SMTP id a92af1059eb24-14c96a4b7c7so517124c88.2
        for <linux-um@lists.infradead.org>; Fri, 02 Oct 2026 00:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790924820; cv=none;
        d=google.com; s=arc-20260327;
        b=NcBrOYi2vjkjQd6bPq5TP8V88B2grFxqegcAEjDMNBPiefjqIZka2AfqzElBJo5XXp
         K7MscFli5GDZ6ERd7pRBc56ZwYRKRrlhRY3PwsoKIZC5YzBKjdvwS+NBF3jG4PWYODO4
         0zEY3POxgi8TkI1QWT5XjvU5Df/OtCz4wVFp6ZB4wreomTjuXh8xSOhWqynAB4RRmUIy
         R0ReuBiGz6zr3fTkMhX1xmrd7BaZVcJ/Dgfflr6cV+c7kAqJuGf28EPIHnFwN3GefQQs
         lua1neWHL2FpqIgyBqeWQD6RyzCQv0TvJzHdV3fVmyu1zBZ+OzpaR0dlybVqLL5yGB82
         3mtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        fh=xb5+gUgCkZ2ouGyc1c3WmTgcYNUYhb1kso8iU8FeRvs=;
        b=j8X2W0hOu8XgycGZJCRgqIFnALK+SXVKWLLNmAfjNk4Nb/4MGYxS6SrFLymwU/DZZA
         RPlKCs4bQWO0EdRA7t2PLCUNp12Zi+DiuwarfvwYfwKXcMKyDccycyx9toCqhrJXLDyv
         G0y+8a3+E44rHtJs/VR0AtSU2PBCOyMvJLDP85fTHzzdiw4NOoEQNmSLdLh8BCcu9GXp
         0GUpjgNgzFONTlI77SiLwu7rxGMBLgkt9aAYa32x56bOf1k+n8ak7CPFvpIdlCbibONw
         dBO2nsDqVXwltjV6HRN0fELqdiV1Q2MSBS0t5FbdaNQT0lvxFIgfmpuwnuDQaLDqBTMV
         xLug==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790924820; x=1791529620; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        b=owXf459ylPw5q7XW1P4hxJkQ18rXiJWxsranerbdU1vxczvoV/d8yYqltNvPywETb6
         hUH40qO6gLlAN2yc5c+AcyYM4MatKlhNgSamB2QXwTAgwvFISQQwnD5oDG78kTMhWGqo
         HWPbae+e4ygbb9uTi+a7OnvFOmnd+JFF+6gO5bF4UxFe+lRPpgPJrU0Gz1AqWyHZ3Bb+
         ID8z9kZ+uRM76drt9dHeyrNX8m1lmHVUEmyXp10zeQY184C/g/9BhIk+d8bXtiRInc5h
         2H9z+ZIn/MkTWC6/DDh8rSJ73fVFH2GmOEQQOocKcTJW8XyM5RXwvgKp/iLnQsz5XNOg
         6SIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924820; x=1791529620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pi+Udzy+By3sZoElReOh3poO8JLX+wgGZCDTOhVncSw=;
        b=jOnw3a8zRf064e4j74+ts2rjkwe0xADTJxiuYu3/Xu6I8T3r6HmV21YU3crWtzYZGC
         TL+j0r2LfMB7GBYELEH75/hCr6XV27zqd5vsMmDRzdP6qiMOCDPquNAINnKsP0AgB4gs
         FRik/c0juMytMHDdgrFg/mVDF4Xh9TEwFN/0D5ToO0QR1foNlpaIVzCB/kJ3oGq/BU8F
         8oIFAxsNngzxRT2tzdC+zauSkzwsrnnUJBHL8LbwEVDvUVbrEIcc2BDGzV9MM2jx+I3e
         vueEAJVhc21x6CjbIpEJswSitY3Swq98bl9lYLaZ9JkaU7q6Jcu5lTBDV7qO5dU3lh7E
         inAA==
X-Forwarded-Encrypted: i=1; AKwUvBxMHxvHYTINLUSnUUr0D3roeoZNdLW4scIfu+NDCG/B8yxsCsI+3W1zrMNF/iJIsQfqdTIt0HLssg==@lists.infradead.org
X-Gm-Message-State: AFq9FYLC/EUEo1HZ6s88TqTSesuHRNrg5ZdAIW20fo5bGEc8E+Kaefrd
	dlixjetmX2VSVb87pwjv1JL9IkFWnYyaqFGxPMN1izyZ1ummx+TzpR82NCfju1RMNklVDret5Pq
	F2Vco2WPP/nWi64A2PoZZkq3RyB5hZ7M=
X-Gm-Gg: AYBFou1LLxduVklQC8g+6+cAGqD4kXakgAXHr1nYSWqNhaUkxUdBn3CzUWmBLpvJyF3
	BSZdIyrYAR26xTEP8AbhH0I1wKaxlhOyMT3rSZYRZwK7Uv9YYtMEM2Q5jcmOOHvhKTPAvsvh0TU
	O9UYfvpREfZvoi74k3hxV02yIpOPzqo/rz/5h27HYV/f1e685Wd6q2dr4cTRRBerFcgbbQIGUW8
	o1xiygDxErBjv8Rkfyft1HXwpxG78LGYTmI2Uwy9E5DCbbCWgw1Yl3cUc6doxzXyfz0ch1f3jtC
	h7JnoreM/zxV5kNLhrUhE1lThwaRwa7ezaQ6vcd5gt882LZyytCag8ykqa6p4xxB8QQkSn1J+nW
	yPbvFrf0NgpQiPm+vxwyAMVlSdWSJmdxqQq9UW3iW6qxh72O0ybreRzMNYPzdlRuS+y+cp6A3U6
	19HIuWbmUnxCuW+Oi35qtmV4n9O1mejeiALyKdW73v4TcqVYqS7f+8QfOktMMtEw==
X-Received: by 2002:a05:7300:4f1c:b0:34b:101f:cdaf with SMTP id
 5a478bee46e88-34f1501d239mr2860107eec.1.1790924819859; Fri, 02 Oct 2026
 00:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20261001123103.2198104-1-tomo@flapping.org>
In-Reply-To: <20261001123103.2198104-1-tomo@flapping.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 09:06:47 +0200
X-Gm-Features: AclHuK9aq6CWZxEjLyQFN3qCeoottkqFWF4dz3y4arkdWfxJVGxahHmXpJ6rMsY
Message-ID: <CANiq72menqxT-7Wv559u+=JQAxvucBTubs62=eN_CHCj7wtEzA@mail.gmail.com>
Subject: Re: [PATCH v1] rust: bug: pass TAINT_WARN to warn_slowpath_fmt() on UML
To: FUJITA Tomonori <tomo@flapping.org>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, acourbot@nvidia.com, 
	aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org, 
	dakr@kernel.org, daniel.almeida@collabora.com, gary@garyguo.net, 
	lossin@kernel.org, tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev, 
	rust-for-linux@vger.kernel.org, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, 
	linux-um@lists.infradead.org, david@davidgow.net, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_000701_444581_099F6F67 
X-CRM114-Status: UNSURE (   9.26  )
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

On Thu, Oct 1, 2026 at 2:31=E2=80=AFPM FUJITA Tomonori <tomo@flapping.org> =
wrote:
>
> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>
> On UML, `warn_flags!` calls `warn_slowpath_fmt()` directly. Its third
> argument is a taint number, but `warn_on!` passes its bug flags there.
>
> As a result, `add_taint()` gets 2304 instead of 9 (`TAINT_WARN`). The
> warning is not recorded: `/proc/sys/kernel/tainted` stays 0 after
> `warn_on!` fires, where it should be 512. It also causes an
> out-of-bounds write in `add_taint()`.
>
> Pass `TAINT_WARN` directly, as C does on UML.
>
> Cc: stable@vger.kernel.org
> Fixes: dff64b072708 ("rust: Add warn_on macro")
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Applied to `rust-next` -- thanks!

We should update the `// SAFETY: It is always safe to call
`warn_slowpath_fmt() ...` comment to cover everything that may go
wrong (like it did).

Cheers,
Miguel

