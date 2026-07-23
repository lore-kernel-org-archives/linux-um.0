Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB66C531F7
	for <linux-um@archiver.kernel.org>; Thu, 23 Jul 2026 19:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BhAw1pO/vcwIfCJXJ/ge1eU4ejwt2PUuCJ6tf2RMGvA=; b=BPMASBwiQfKqAN+a7PyWHL+wGg
	iWEyZuvyX46yGeFnmr541pFUYGRa2hXyir5RKEIAyd14KYhYaYwOffyIOoyZc9cAvQM2hwEN7ATfT
	hn8etOD8JcMlXsGotTbMN9gmwynUveXxVt6XIklzb3qT/oDAbgS5kANxyPI7XgVMp1zLl7OQ0+5RZ
	xYvzaAsHqBg+N+Z/2vw0fp7Jqwt2YYonsXlxWZlNUSq04OCN9ghM9gm9exp568rU0PEDkroFtjd6l
	TOJV3NFxHzIFDEtF87/TY8cnRTHVaraR+I4TEiPbXyusYxtB65nuQFJ22GpwITmTgOjik32fy4AH7
	qWWkm0YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmzGx-0000000EyZi-3lTI;
	Thu, 23 Jul 2026 19:39:59 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmzGv-0000000EyYd-2D33
	for linux-um@lists.infradead.org;
	Thu, 23 Jul 2026 19:39:58 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-381b831d535so1137093a91.0
        for <linux-um@lists.infradead.org>; Thu, 23 Jul 2026 12:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784835597; cv=none;
        d=google.com; s=arc-20260327;
        b=cJ5uk9KuIt/zA4TpuXzOwrKOcVwiVKQqIjl/V5htTtX7hQKtXgj7+3cXYgY4ZjGFFp
         MahIBx6dw6qyspXtbojsokzUCX8Y/R0k7DF34sTua6rN0POE589JPUIvprLuw0+k+rO5
         9TEp5ylQvnWOZMIlktKCVDjRbECuEtmu7+KydwEIR5mE6OaCC7emLJgbUJ9WkTmvI5Wq
         4fqMcoYSkGHSCeVEvAeMgHqfh76sLT70/oZtRAxOMauvz6R45rEuVt2ImH5b5NgHpVxw
         lYhLmqMy5pWQJjmODKcr2e6rzUUu5VMs2zAIMP0pa5tskRfICJYb0GMdp/sj5yKpJbk8
         WCaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BhAw1pO/vcwIfCJXJ/ge1eU4ejwt2PUuCJ6tf2RMGvA=;
        fh=GHWGq1Yp4lNoMaHuvT8wEYC/R5MG8plXsyeH57Tonq8=;
        b=MqMiN4gCxbuCTnV5LoMVLgctTxgcxK2XNCfZqSKGURMLB+tH1CZEbHfc0jVjsDzhMe
         d44yHH9yh43IT1boRpk5Ni7VNpLk/NjCr++vEcgtxFAKwYR8W46AclzVanqirV7uRQTf
         5ysNGly3/1tElJrPEsTmMIQeRyIGx2co7vP2x6wgWaaL3ORJ064XCfv5srau8HF7hK61
         KSYwUVANFvz8T6IAQK7srQRitNJccHg6CTOeMZ4XF+ek5a+d0Q8HWpHrCAT8BsjpBHeo
         +tFLNtxpPaFVPIs8D14l6R9eOkoBPW1DU25UVhJuHd4lURkMyfjHayWhJpXqEQe8sskw
         qCfQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784835597; x=1785440397; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BhAw1pO/vcwIfCJXJ/ge1eU4ejwt2PUuCJ6tf2RMGvA=;
        b=RhrR/y/v5n7QKsvNBv9L4lJD9EPDs3TJUJvwM1iLQ1zsfU7fos2lwTG2JQv85C+laU
         tCTyGePgRp3LSHt0D8Z3+c5pCPFZIGyOO2B7bV9IeKPKZiNcloJmTZN4a9AEvaQEmQUN
         LOkDdfrOaf8zw4lAJh0tYvYJbs9YBDLyBmglxDDQKIbG0JVk38WlFekUEmpKhB/STCX2
         5zFJEx15geN3o7MJSQsvI3LV+2bpzFXegys7llytXxngjrRU8AqmF+sli0Z2RoruUJbn
         zdHVEL4TlJ9lUQMWV52bVVH06xkJphRpFvxasy0Sy22yq3walxQsTOkKydJXydRgSm1f
         4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784835597; x=1785440397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BhAw1pO/vcwIfCJXJ/ge1eU4ejwt2PUuCJ6tf2RMGvA=;
        b=WVyCz/aQvJFZYGPILuqQvfiG0dC7JMfj47PEGv5/EPqdxUXzdYm0s80IUUNMhyZYzv
         TQiBYzCsLp0FUO8fnrnapIKhx18X67xTsqnpjDrE5dKXN2W45yhPuee+TUN9GiUnVi6B
         tla5/JU23fOYfIdB6Bb4edBwwPBc12zL45yeuvDLphvROy2V4V8YtK3OOn7TN/dGTNk8
         XdoTEQUrtNcDWFiva0ZtgV5mTA9rFm7J5ZbBiyF7w7VU9mZlMJk90263XsYz910PfiuA
         SEqpJhP4ceOaJyzlNhMDeBzqQIw07G3+diemHcrSURT5MGXPbAzCZYfLLgq0ZTIcGdLc
         Xbew==
X-Forwarded-Encrypted: i=1; AHgh+RqPPoA0rGEb158gxq+3TlzGtiKJtT5ASxXLRa0hxvqDPHd5upGRUrMcUWUbFR2wPZ0f6WvoAhb5Kg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/B+4/SNUc93dBhrbpNRqwZB+HulizzPxEroKc2tL9SU64ddFZ
	DVJTrrEr4QB5th6lDukGDnDApSJpd+up8tc2m/zwZxGlYSMbEDppVB6b19T6Xz+mikvDGOywdV/
	PNih0DuGEsoFdWjoqhvmPO7sqefa1b94=
X-Gm-Gg: AR+sD12XdI8R1RGHWbl3jqSTCcZfgWJ7FFjVxZRimGLxKxJuRpx/6H4BeS0RR0IX9yK
	BDqPV/91I1N6vmAq+rG0fdcUyGS3OEWi2gfK6O0TyG3ibH0OkUs8d3yLNqUegjPv0ccG0MvTYsc
	LoOQKuuWNQtWjSSgo+gkYvWAraSzETVMaX/kn5L4VgdHgBGyq3i4HHeqmTlLF5fzD+rRuD/50xI
	1T6IIipNaTGGhjBJdre/uNnwGj2CZZxeSgeZH2Ju1SMM2fXreg2KiXXJE0FBb5pE5NsZqOr
X-Received: by 2002:a17:90b:1dc3:b0:381:20b:a9ee with SMTP id
 98e67ed59e1d1-38ec6575b04mr4646288a91.14.1784835596555; Thu, 23 Jul 2026
 12:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260622124722.1694157-1-michael.bommarito@gmail.com>
In-Reply-To: <20260622124722.1694157-1-michael.bommarito@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 23 Jul 2026 21:39:44 +0200
X-Gm-Features: AUfX_mzUnmgHcwXG5HqzFmVyghZ3tBr8_N2XtyPCKkAMFVKF0X4XbUJThHbKKgQ
Message-ID: <CAFLxGvz-MasgYTjF52abSu8PSD3PuyUVs7Se8g8C9BxuBw09Og@mail.gmail.com>
Subject: Re: [PATCH] um: vector: fix use-after-free in vector_mmsg_rx()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_123957_574473_46D83A5A 
X-CRM114-Status: GOOD (  19.84  )
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

On Mon, Jun 22, 2026 at 2:47=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> When vector_mmsg_rx() discards a packet whose overlay header fails
> verify_header(), it frees the skb and continues the loop:
>
>         if (header_check < 0) {
>                 dev_kfree_skb_irq(skb);
>                 vp->estats.rx_encaps_errors++;
>                 continue;
>         }
>
> The normal and short-packet paths fall through to the bottom of the
> loop body, which clears the consumed slot and advances the cursors:
>
>         (*skbuff_vector) =3D NULL;
>         mmsg_vector++;
>         skbuff_vector++;
>
> The verify_header() < 0 path skips that via continue, so the freed skb
> is left in skbuff_vector[] and the cursors do not advance. The next
> iteration reads the same slot, gets the freed skb, and frees it again,
> producing a refcount underflow / use-after-free in the RX path.
>
> Discard the slot the same way the other paths do before continuing.
>
> Only transports whose verify_header() can return negative are affected:
> GRE and L2TPv3 do so on a cookie/session-id mismatch (raw/tap do not),
> so any peer on such a transport can trigger it without authentication.
>
> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> Reproduced on a KASAN + refcount-full UML build: bring up a vec0
> l2tpv3 device and send frames from the host with the right cookie but a
> wrong session id. Stock kernel logs repeated "uml_l2tpv3: session
> mismatch" then a refcount_t underflow / use-after-free in
> dev_kfree_skb_irq_reason() <- vector_poll() <- vector_mmsg_rx(); with
> this patch the mismatch is logged and the splat is gone (0 underflow, 0
> use-after-free). Full dmesg and reproducer available on request.
>
>  arch/um/drivers/vector_kern.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to fixes branch.

--=20
Thanks,
//richard

