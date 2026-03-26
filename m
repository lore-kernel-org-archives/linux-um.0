Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80D510A88ED
	for <linux-um@archiver.kernel.org>; Thu, 26 Mar 2026 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ht1ydNu1umiMsWIVEKZmUkwLuvps5HNVkVlm/tB0atg=; b=iun6rhjfOsHFnL91TB7KTbx3kC
	AcyKln+pGNDq69hoVPdP5w5xbRwyUlJcQ7a9Akf8uuBvYEuI5ApjL2Y+DBbFKEYy6tKR++BnZZfwb
	GvcPb0gQSh40flcZhh+E6/LxpWOlUDT3LJcq6HTOm4uo/D4DSpPIS5LoUkjroeyqvchkVPt3ylC2f
	PSwF4oVyE7cOpev4lTF1k+LXZUadOKUDf2DqAAQf8Ev6uPHPPYxPuFukUnU1O3k1FyqaNqpamcZyj
	RMRv2SU+xjrGBQJ7vAH5+8WIZwtF58Y0JeoWqToxzYN0sTo3vwx3ZQDKwQH6nufsKxiuaLuExpfL7
	dcAujzyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oYS-00000005x7A-16EM;
	Thu, 26 Mar 2026 17:31:36 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5oYO-00000005x5k-3mDj
	for linux-um@lists.infradead.org;
	Thu, 26 Mar 2026 17:31:34 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-127148c2112so102975c88.3
        for <linux-um@lists.infradead.org>; Thu, 26 Mar 2026 10:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774546292; cv=none;
        d=google.com; s=arc-20240605;
        b=WzTrUqwNdZkK0Wu6zZ5UNM/V5TZZDnw9fG7XWt9iQBBEtao3oaJJjrXRm7iixDnBnc
         239BNz54Q6A9ZA2J+TiZ3Wyykz0YGVbYJVTT8TXbWIB2MXWY9GuPwh0+4GoC6fVlupu9
         tC2UeIA54dWtZ8SweSCY00HcZ69APFACHlrlpYZP8Y3N2Cy91FGAzf//T2ICbuV4tsQ3
         NxENWflBOOE4cTB4M4SxsOKpMZt5rKlMk6GVsycS3rLWSyJwTyGotnjtbdLiqe2gYVer
         3obuC2YTBAUrQOrpz5m6h3TSKehPowqeOagESNgCbAR02Gj4+fwC7BTRSQqeE9E4D8Ol
         FzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ht1ydNu1umiMsWIVEKZmUkwLuvps5HNVkVlm/tB0atg=;
        fh=6A4MUblCsQwXGi57CFW5RU+T8zgxyfKOjqp3fcmEVus=;
        b=TRlDSEHYnM9eBIaVsJZg3RgDBbm+OPWkNwqMU0/d17gzYQlXvGl/9ZpJgb71YfTL2L
         iEynH8B7i4jscmfAHoP8oU0MokBuBedpbCKZpfN6itBc5x111xPPMPP4kPPfVorwAwbD
         v70YTR4SnXpcwRqSrZdrTil7HsxMU6IrRpfrDVmM7c47eVoS8OId5d4zPZx9ZcKWlnlc
         svUR2DTN0GVBHagA3oQsTCP7qLSuuEVmgo5re1jwHMzeJ5x0ElnD3+B/Y8GrV12D0Xlo
         s9ibLH33cO0RnD6ZFQ4YuQtVoG+JSwMlzhEbHDc6/WXBzlcxUUQz6Z0FNN8sSsZBibrm
         Y8bA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774546292; x=1775151092; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht1ydNu1umiMsWIVEKZmUkwLuvps5HNVkVlm/tB0atg=;
        b=MRrvansRJS1w8Ewvd7iUduhweyqspRRutRjPO3lar4n2Xp5sCiOR7HSepY/nEXvcfq
         3fpSugXKNj7SBEz7zACjnEHn9+lGDgVos4FdYsQTH860VKrfmnayR4rWSJkc33Ors8+S
         uMuIDxufEL5rDBb/3AoPe5XiLYahB6CZBOqNa5oOtjV6ugJ228tM7muvOqOjmXFFcglh
         ragtXr9rFOOiNZrud9sMjePe0e42/RnLtWSUiCDLCZ/RpS15qa1JR7JZYdVAdiWzHhHA
         8LG9aJOyDmwwid8BYB/7OTNa81PjbIY1G6rvkViKMwoeVAwt/Hdi0nT+rqYgQddrnPpf
         WgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774546292; x=1775151092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ht1ydNu1umiMsWIVEKZmUkwLuvps5HNVkVlm/tB0atg=;
        b=SQVnZh7eB5174YjJ0F5j0lZoWpTWDfXmk6gImUmiPwS8oEN+lf6zVDgOokm38H2CRx
         JH/pj0YXPfl5qIDfa0HeXtmztHDzWY2GlOdhv4AezFm7EW9EhL5pZL/CIba3I+nkoeaz
         8gsv1ACkrHADMRgsRG3Eje1sAKOX3QUP2nPEtMk80HFcyR3E6yWtMVb4ht47pWD2eNre
         kcbCZIv0nyLAlOCrcfJFHtkkj7DUbAsvDu6T5wqMyj2Ylymj1nEBofncWaKqDzuoc+Kc
         rAY1RkZeGC2Ydal6VtJ6noqeGV1cevnHyNecUIQNWFRo/TBDUrGGG5YnDHsXV7zIZnOo
         zGJg==
X-Forwarded-Encrypted: i=1; AJvYcCUwrK3thP1z7mJRtgeSG1rwT9Nk+0cyWrJYQMN42smHDG9XUbdWrlzK/P05d4NKRAQTc9cKvpe6pw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgElaXuSn7zrAPaDRyPTBVdjSiw7Kf6T0QTWyPJJ3rM+00QaEt
	Chzwip/U8HeO+ua7XNSQnjLq0e1koO5fGhuDqaHu8niMxFHlGdqhsrbEfPklrEoVRUUWPLGgecd
	CSYz5YNUooLY9ohms9DDf6MJJzgbs4Oo=
X-Gm-Gg: ATEYQzyXKjGgJxLG3hn60SVWFMytV4/cn1KOcImwtgsFzqnxDbWvv7ynseNjVkKqbR1
	r7IpUG7nAEwNi7eHds4Y8HCO/JpKH5js7d1gSBtwJDWx8WxgyfaHMY4BiOcJNAoDSKsJL+0APOu
	b3AL2AHs3qZDaAF7y/RZS1vTlRcWNazG/XjMceG7gF0uFhtLjU8Pj7kD4ATYUx7LVogCpTUoWGW
	YkXYMPsDjY4Hsg4fp+0Bd+oPe0yRffbb3QXn1GIU8QsTgRgwsK1bibSjiM1wR9xKo979D9veyoX
	H7CK0U+zX9T6att5CdqSKMcYge7RKKVhoLYDYxpeKV20+YXBsnuROdJUE7rslU2edeiuSBkq0jN
	37szsfHA/nvIlb9GRXezoPhc=
X-Received: by 2002:a05:7300:cd8a:b0:2c0:fec3:fd2b with SMTP id
 5a478bee46e88-2c15d3eebdemr2110432eec.5.1774546291859; Thu, 26 Mar 2026
 10:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <20260323000327.111235-1-ojeda@kernel.org>
 <acEP7tl8pqFA3tK8@shell.armlinux.org.uk> <acUGAsjYvNvTEO92@google.com>
 <CANiq72mzPpkELXis1CiSbKUmBXNQYMiMmjj-7-sYiLh4T_JSOQ@mail.gmail.com> <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
In-Reply-To: <9cf5a94c-0f37-446c-b63d-ddac5674d220@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Mar 2026 18:31:18 +0100
X-Gm-Features: AQROBzAY2TUlph37K4tdyrXW3PnWDmlLF1E76Ca3evvsqWc92x8ByVyN4OKTlu0
Message-ID: <CANiq72=fm7FnfM2iqOLvsgxxx7X4LBkr7XU8=LWYqSzQ7zjJ2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>, 
	Miguel Ojeda <ojeda@kernel.org>, a.hindborg@kernel.org, acourbot@nvidia.com, 
	akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, 
	david@davidgow.net, gary@garyguo.net, johannes@sipsolutions.net, 
	justinstitt@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260326_103132_938713_70FAA342 
X-CRM114-Status: GOOD (  11.29  )
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

On Thu, Mar 26, 2026 at 3:31=E2=80=AFPM Christian Schrefl
<chrisi.schrefl@gmail.com> wrote:
>
> It should probably be fine to use armv7a-none-eabi. I've mostly used
> arm-unknown-linux-gnueabi since I though it needed to match the
> bindgen-target (which is -linux-gnu for all architectures) and
> because from what I understand clang also uses arm-linux-gnueabi [1].
> Also when I selected the target I thought that we would also support
> armv6, but since I had no v6 hardware to test on I disabled it.

I see, thanks for the quick reply!

My current thinking is to enable this only for x86_64 and arm64, so if
you/arm decide to switch the target (and/or enable this experimental
feature), then that can be done without a rush, independently.

(Please take a look at Russell's reply as well about the short enums thing.=
)

Cheers,
Miguel

