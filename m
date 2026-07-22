Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDBEC44536
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 21:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=loIgHIiDiKh2ASqxMf9BO0772/5Ma4/yo2/S1oF0ioM=; b=Y+hulyfCGaYJzUIZMVC3rJsTwX
	dEa7JTQZ+JRTMJdydOsKp5uknD29VLhkNW6BZwZ4oWgmYWSRMZlMadKOnv0tkB8RXB1dLxOutas6L
	OVGwAw5KyijRkMmrNrDee2M8MqVeduFRjT0jvrFHZyu0WokjSW7L6Hsxie6HduoeSCtH2yv2JD3uX
	uZin8CnhzohHEO8+ZWvBeznJPow/MNd7GBybWmpqTljyndk8u/0T7a2SylX83uLkqzS+0eg+azV1/
	NTByfz7AtdvImhfc0zzsrzcpClz4LMJPcyg8psKbN70aKneXDtWhJ8w9I3RkfbaUQn8+IsRRUDqbb
	8d6Rlu7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeGI-0000000Cn9I-3vnc;
	Wed, 22 Jul 2026 21:13:54 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmeGG-0000000Cn8q-1F7j
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 21:13:53 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cedda2ce6fso83620555ad.1
        for <linux-um@lists.infradead.org>; Wed, 22 Jul 2026 14:13:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784754831; cv=none;
        d=google.com; s=arc-20260327;
        b=YsjEA+BuDhSy3ncMFfDalZeWX4hvMxwFafhSh3sqaCQ3E8XsBuq1dFcTKVVnkRALfY
         5sZKlS7yNzPLvbj7+ngo7KBgCD14VMJI/5pCt0mTJh8C9dHvL7ZPhLWtRUSYJ9u5bojC
         92fLNLRO9+guBHN1W2Bqv9fOSjJiM5/WSPGHrArI8OdlMsSiBxOuypXNKS0W6dkMzayY
         QIPxvB3LhNHpOPX/EgwYahLw5HwNJhOjdXcYoQFSwmEaMvPe5dFPnGBpMOJg/aA+XRa8
         xaJ4ByEWlhTQdwFsFuQYQDoeSNyIFchLPVRph7nzX93rimYjxBLdhtzFoTgFGD1NoxCS
         v/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loIgHIiDiKh2ASqxMf9BO0772/5Ma4/yo2/S1oF0ioM=;
        fh=/1MPHRTxTTcTT11GU5rLGFEZyCyaTza2TLDzQOO3GAU=;
        b=Nr8qyWENwWRs7gAE7DPRG1F+ZDz7PqcMaruEwt+d99t5Ai37yeemZ3Yn0GRy+imTuv
         wJxWteOfRnMSJ4kYUVr/pDQgnk/jPR404m3G8iXdKKj0OlcI7Tz52z/uJ1GntnPs58/m
         z0zabvsuqAUgo/Dert/ctV55XMXeUyAb6znmIRGxRnRCs94s7dWYXMRn3OGAgMYtAb1d
         WR1cmAg0FOZW1F5z4X8RuEaGuCy8tABah3K0s+lCzn5t49mPhZq9H/xlEG75f0Aj2Xml
         89YmI2G+xoIf4k6TCPHwct5j2PuK1eHnbo6c1hCb/qDvcGCJKxMGj0xTqEI65NzK/UfJ
         Enmw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754831; x=1785359631; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loIgHIiDiKh2ASqxMf9BO0772/5Ma4/yo2/S1oF0ioM=;
        b=k0vYIO+4/MMyJd25ebCK95/LJ3J+w2w8sIc6xxETQxPDtcS0EjpBBUx0D7i3Q1Vh1P
         fVIlrGT/7wTlxNEvCv6VixwxX8nbRg5cdmZ4y1g0Au1YWbjtVtieM+CKbFTGUZs5Pwnf
         fVi0YCXCnePSQ820fDRQuWL5TylOaZpKrNZKqla81b1Rqb4s7xIcuGzqAutEsdgus2vE
         1jkuOxN/Ogt8SR/oHNo+kUrjSRZaCOEBGcnIJg6ZbQ1FJbkczh+s+xXnVZ0oC2tIuM1y
         0qSN2crCijqcfwZO/OmAueugdUE7ssAqVqAXx1MoQp67vq86dKeOr65tOJhHouKzHaIB
         DtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754831; x=1785359631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loIgHIiDiKh2ASqxMf9BO0772/5Ma4/yo2/S1oF0ioM=;
        b=F0L99p1k+fZwxRzUmemU+8BcEhjdOmbmu30WjZ9Y3Ai3EB5vbfgcW9JiuAnYbiPNkW
         KAan8THAVva75Rl6yDs2NHY9m3iM4Xu+CSVm+HjLiKkjYJyeTtL+S9mgPEui4SLj04M6
         8EedBA08OraRWjGxZhgBQ3MXw/VSZIpfeXVRMhtxUD4cUvI2LuUpc3+N3B24ZQ3eUuwd
         jPEzRvp3VQ1j130RUHSR8nQ41Ksg/sHkgraQFGEd5BWJ8wNbW8rWD/DxrwBw1pEJJyT9
         MDKD22vuY0ARGihP0Xg3lCwYvI+hzBFyNBnlSkYkbF/7cF4avW1XQq2tMjaFlyVSGlDY
         43XQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcIErcLZ+OKCjg6j3yV+jpFTTwIEA7XZR5SZxrn6qiT4yjIK1GhNEWorhNR3vz46wGitwbSlkzMA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxLv476k3+C7104tuzSnIgX1+kUxDmJQKNDz6WjZxADDa9obOQE
	Y5yhDnCqMTwYF5ERKbt4lg5ipeTJ8qpcVSe99IyoEnHCaNuDF4zlTbG9RTSO0tX8R/8RwrS7eTE
	nfnpCUwIpQViNuiRt7ZOz2b9qSeng9vA=
X-Gm-Gg: AR+sD1060oHqyMJJDgS8nybiCvOZAIeYQ3n7kzoGW4nNrSUwsQ23rwypYHZG0foOkTz
	MoXT8atsZ95n8rwpsft460ebc1WCC1lgKJmNafdRdI33P4ZAmrldXNsvShXfG3ZfLxNezSTNR3k
	1EF7uL9RbzclkgeT2hU0P0iEFrYgpaiIk1gUk4/KcXUFI76CJfT0BGdOvVHhzWeemFTbdCqJ3gL
	tUVlwbuISJDFzVelMEyfbdv2fiMFLFpxd4Bi+8UHi/D5WPjf7T+QorW+fi5Vw==
X-Received: by 2002:a17:903:19eb:b0:2cf:477f:57cc with SMTP id
 d9443c01a7336-2cfa6a43f6fmr6065235ad.4.1784754830995; Wed, 22 Jul 2026
 14:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260622124722.1694157-1-michael.bommarito@gmail.com>
In-Reply-To: <20260622124722.1694157-1-michael.bommarito@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 22 Jul 2026 23:13:36 +0200
X-Gm-Features: AUfX_myTKtzNHr0eWFJllju-R0QMq_3h12wP1jMaXrwGCBcvYSrcGw1h1SK3p2Y
Message-ID: <CAFLxGvzLku3V1v1aEZU0v6ZhRE0UcUUbkfj1H3vzgtE9LEQZVQ@mail.gmail.com>
Subject: Re: [PATCH] um: vector: fix use-after-free in vector_mmsg_rx()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_141352_341019_A6353DF3 
X-CRM114-Status: GOOD (  23.77  )
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
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.=
c
> index 2cc90055499a5..8a70b3a625537 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -995,6 +995,9 @@ static int vector_mmsg_rx(struct vector_private *vp, =
int budget)
>                                  */
>                                         dev_kfree_skb_irq(skb);
>                                         vp->estats.rx_encaps_errors++;
> +                                       (*skbuff_vector) =3D NULL;
> +                                       mmsg_vector++;
> +                                       skbuff_vector++;

Anton, please have a look.

--=20
Thanks,
//richard

