Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2601075269
	for <linux-um@archiver.kernel.org>; Wed, 25 Mar 2026 01:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=; b=UuyFznESwi9TGSnnw71mJtEwdM
	ZcvS1DDIsqt1V3+86rcLLb8P0twMb35feHB9RtgslxFUQxU448Ue/F8ji7qh4tIjrOHVgns0jOW4b
	+I9LqmZbSXKAz7ZlZBN5BpPm7GIr2QEAtgw4J1Xu/8rgyQAHRCtQXA7dSUZWLjnkF9KQQuTt2yXr4
	HQRxl0WoCtD6wyOISI7zVRyZe6jrMnchgT8BqLNc8p+kDvUodOcz7IW5GeaJMyZwNzIJaC/x114vY
	Grme2CNmrZIcgKQVMFFEdP77ZfZkoYbrpFetJonwBjk02oOxZXxFANElGjKjZHl1CzN/neX5g6n2a
	7ek33Rtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5DVo-00000002TiE-2n0W;
	Wed, 25 Mar 2026 01:58:24 +0000
Received: from mail-dy1-x1335.google.com ([2607:f8b0:4864:20::1335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5DVm-00000002Tgv-16bb
	for linux-um@lists.infradead.org;
	Wed, 25 Mar 2026 01:58:23 +0000
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-2bd5658b901so244880eec.3
        for <linux-um@lists.infradead.org>; Tue, 24 Mar 2026 18:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774403901; cv=none;
        d=google.com; s=arc-20240605;
        b=Pac9YLcQTK5+t18e9OMfj/jTVBst2JHyZW/Arn1rDNAQWf6RZTlxqw4qksaIloBZNy
         FRhQUUAzPynV074Fd5arIKoYRSVIEh1BrbONOmyPJvS6wRHd2IAdYpUeSVzFzMu49wbk
         bw7bUtbPVvUmrmDGUoxk64NuOqHbyIx4qYMiVuHDBueRxhF0T5k8TaE7oZjuvQ3z/9PO
         M4N8t5ed83HHglNlTz+2MVLsal22o45ImloFpV42WF78h7nibTiM51/U4kUYf2PbSEih
         FWy4qFtb0reBhgP7GhdITNIZUHdUIUJbUTtrx9+jmW1R39Qtl6SsV11ZJ8ZsEbw+tthn
         zeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        fh=IEOm4Hkt9jXDgbk71nvqTjwrgBfMav83ul+XSaOj5g0=;
        b=R+80Bc7yQI1kd/4T+kh7Rvl4hqalhqMCqhYcRIUdM7JQamtvjaCE3dmkC1eSrrL7Xk
         x4KcEfKxKYa49OcZZPY3b89b46wODd8FEySuGzHCKgrBSDOXSeK4pJEKUHHCnn6FCCL6
         B7Jd0MXSJtF/KRSUVYiTLytzFrCBY1oEb95AEAJvCqDOYgi+0RE+0CqJQ+R+7lKOWJFJ
         j8tv3uDfBR86WrVTVXx0vVL0T5+UOBLsr40d9eOMBNjYciXsIIgarUw58/5DU6uw4nNF
         gp4c2t0O9eT3gnFjjvaPQ62xQR8bsHlK9hYKDyshZz3PGBU7aH06hOrXwGwzWec6//iW
         B6Rg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774403901; x=1775008701; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        b=ZVq1VAVRax4nvcvrdJmt4askuRt/n3KON9qe+p+Ly+fMFhiNINmNSC10loCa2WgBEQ
         9VokU+F1HHdjBo7QBItheb/JuX5mm8+h3Wjhya6jW+rulTbk+zX6wTBj0BXtN0R9yzxx
         Ww27yNFnHfoPOnNIJV401ouozvGh8k+HAld5Yp2zgdDLLnHHU+SbL9tsmLLX0V4P7I4L
         QOHh5xAkOWpEsNbdfRIT+8qlJdK5qXqqZOskzNa6PUHVUkv/RmSSluPyOxw+RzS3807Z
         mMkRCX2jAqSaST8l/6HWyyoAncJcINmBer5i5v7tth9wAOJqWdckZP+0+05UzPHVl98z
         dRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403901; x=1775008701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uATiCdJVNXsXbqp7wQweEzFd+VzHCHpWD2sO0E9ZBl0=;
        b=LGk/I4+Xlh82Vpi5aDdU9a7c8ghxbQUKajS+HZIfYIsacjgJ7jWvM0WZHF4yap5/X0
         eNlWwN9OVdUgifTCChGpZYzqSRQfR+pCzHJVUoWRuxmLadbFJuwiYwgE2vEdzPdy462V
         EXJMojJCLiguzzzx7JGx1oSJXFc9Bd1kECy3XrExlupOI074TK6b7dt02517QjSp7nH+
         YFzldo4Fc1cD3kVBz1K+13Sbr/nrfACdRXo4TdshtPw41DuOfJOHcrrT/xPopR9kvS4W
         749vQABloVSFuYymtBhg32mPYYcEw3xFYmdDDYsoUDJ+9lDZxw1EsFu275MpqlC3P8Ed
         6O7g==
X-Forwarded-Encrypted: i=1; AJvYcCWfOnz+SuY4q5POqmG3ecr9alQOE67pyB6h1TLNC5B5vRTle1BaZn/+2j1g13bw97fqb5TVefoINA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw/TmfjmpND+kPKqnKDVuq5ovkHqBzH2HBeqxs5GFwJCTHPzdPO
	0BOwJ5MmkmXT5s4Fpd0VZphYqRLkuXaogBisiB++j5Po4Gt7SuabQKHzibnaZZwnW/e+QZGwuD5
	ZoHbKY927/fBNzQxymr0CErZ2EgupS/jUaSYOPXHQcQ==
X-Gm-Gg: ATEYQzybKXO1TPGxp7Do+HvSLGhQTsAeQkFx/bMp3NlK6f0jiOVxzeKza00A4ajy7A5
	YOTkYNF2a01B8ftlwXG6f081dQZVAfa64m8HEMTFMOJRJSDW1GAfanggtrJ6OuYVrOwtHcWlJKO
	5lnvwMzpGUAXWBt2lMadyJje9MfwYo5RUKNVXr+BgnU2UQhe4FsheYtJbsiS7kQjMGAXd6CX3GU
	0oD2apoR6/yT+QnAZAKze4ADA8NNmFFtrR4FpBFsIrEhmNQNU9oW7EdJp3+C2z726Kg3Y4aVM3i
	msqkTZfNk5KQ/kTxWL5xyLFFE0HBYW23GcATSl+F+sIOgdARU44GdzQ9VokbElDKRqIADejFacd
	TA2cwkWO3D8x0YZibhIH0a6M=
X-Received: by 2002:a05:7300:dc10:b0:2be:298c:a11 with SMTP id
 5a478bee46e88-2c15d3a8a70mr394983eec.3.1774403900918; Tue, 24 Mar 2026
 18:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260322192159.88138-1-ojeda@kernel.org> <CGME20260322194701eucas1p1f72625f53e50806fa4f430550f291e76@eucas1p1.samsung.com>
 <20260322194616.89847-1-ojeda@kernel.org> <1c4e429b-f30c-42a9-8de1-71cb2cbbc114@samsung.com>
In-Reply-To: <1c4e429b-f30c-42a9-8de1-71cb2cbbc114@samsung.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Mar 2026 02:58:08 +0100
X-Gm-Features: AQROBzAYV4sPQIbCVLLNfW-UqAw-p0H5kvr5leqfcWwqgBKVIhpQi6sU039YVRU
Message-ID: <CANiq72=UPiXc7JLracLeC6k45ToByJWZedp3B3j5=5mAnyKZmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Danilo Krummrich <dakr@kernel.org>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, driver-core@lists.linux.dev, 
	acourbot@nvidia.com, akpm@linux-foundation.org, aliceryhl@google.com, 
	anton.ivanov@cambridgegreys.com, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, david@davidgow.net, gary@garyguo.net, 
	johannes@sipsolutions.net, justinstitt@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux@armlinux.org.uk, llvm@lists.linux.dev, 
	lossin@kernel.org, mark.rutland@arm.com, mmaurer@google.com, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, nicolas.schier@linux.dev, 
	nsc@kernel.org, peterz@infradead.org, richard@nod.at, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, urezki@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_185822_299647_2FF84FD8 
X-CRM114-Status: UNSURE (   5.66  )
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

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Yes please, this looks like an oversight.

https://lore.kernel.org/rust-for-linux/20260325015548.70912-1-ojeda@kernel.=
org/

I hope that helps!

Cheers,
Miguel

