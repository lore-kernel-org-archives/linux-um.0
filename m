Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97EC369BD
	for <linux-um@archiver.kernel.org>; Tue, 15 Apr 2025 18:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dii88vxy+0kWYHHaG5dKqAQf7HwnhiHLf0E63iO/PI=; b=RBtJYSKxzjL254JMEypyeXTK59
	CaBABCh0OJuELIon5VpVQ8I5Ad+uevFr0FQuJ306t6MKHZ0lhtDO9J0FvbWgAtvOuEQFjXuwVFNhg
	4f0VvQ+KnVshQDYpDPbx3HDkb721dqYnjxDG/A4Mc/UPFW6yXkdY0ef7DLfP3s+3BWqa7calKPUTR
	yg91HrofKi16vsxV0W2YurV3PnrNeKgjr2SR5XXjoYfOQYTS3POcTYIgL44RLquS9olGIYC9FLtGa
	bf7isGJpepYXdX/EyUewXtfYP3SIaWwIrmH7E764Z2inuo5ujJbuyKlrtT8IchoimpFTaxz5pZMV8
	wdbyr9SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4khe-00000006frm-23Y6;
	Tue, 15 Apr 2025 18:08:10 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4kVu-00000006dwr-1nCN
	for linux-um@lists.infradead.org;
	Tue, 15 Apr 2025 17:56:03 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso67781485e9.3
        for <linux-um@lists.infradead.org>; Tue, 15 Apr 2025 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744739761; x=1745344561; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dii88vxy+0kWYHHaG5dKqAQf7HwnhiHLf0E63iO/PI=;
        b=NB9rOw3Z2brdiKCEeWGsrnsozWqBjylc4C4MEwkCO+xC/XYZ4f9DRm/qkd4HFxT6Y5
         +kfy78D65RvCSG4921lOtr/XmmRoaS5YqxuDKf98dtTRGuicQ/8biVkGp9TTr9fIcBdi
         A+QwjVeLeYykJRsd3IEtvffF14T6tQlq7FMk5bIDwP1RlyddyDTh3xn2Rx2H2GpvceGO
         Fk56XrA/Fjpw6XBXsZIK8WH/0NiuCK6RwlIoGWFiqc8nf7TC8iMSh3Is8BuTRgATVDT6
         7yShMcqREm6le/GZyxyJ7qXM1az06mvNrNKh2AHmhW88xZlyybwdkTKnos7j8ysEULgi
         X+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739761; x=1745344561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dii88vxy+0kWYHHaG5dKqAQf7HwnhiHLf0E63iO/PI=;
        b=VUTdMvwJp5m60amtYIx1owmvEbu8MHC+Q1hs3/x5ualEYp3Fma84STSW2yKyshbA6B
         mPHToebZQ+oA+3mH9eYMZmy4zYOcpu+BbAVZ4WGNnQsmKN7L35Sav0hv1Q7keTvJsbVw
         0B/jxIh2jD6uGOvGjtVMbgA5i9EG2FbBKefGYWcbiX2xf+0oLH1RStmNlFC9NkQdKELh
         aOj4CksAbeApjwGxEmqnEDzXqk7ftARwJDIsa0ehYsF83rnQ2mHgnwM4DV2om7+9Bsj1
         IrUT1p6slUtq05a9+DTO4UyrpZkBRLY0Lh480FhOivmJaplU3av99ctpiXnBokctDuEV
         7nLw==
X-Gm-Message-State: AOJu0Ywc24mGg+48Mg/E0j//c1rvRvb5YrlTptPtbdd9JavcEivLaxhu
	24jcK1KzQiRPQNzdneIILpuF9k7n2fykmmEBjQDBYYOwyso0YSg0
X-Gm-Gg: ASbGncuHUF79ZWBNrVx26ZFOjD+Rxo7wPqSvRK4DugdIt6BZR95b5tFB8S+dMFwDAaD
	dIjEBzgf0CFvbdL1lFbLgIU0DcnR081eBHb60oRXB3LgaUqjOxagT/zWiJzVvhe32knlaNk5xlU
	1dMZZ/dbrR4Lv1u5Ef1okxncmA+Bp3Q+Nmj0Qu6h+dx4LnD0C0h6TCk/64Xb+w7ff0JrKtaXuiJ
	DAux22SjM4xKt2H4fkTWiridfLikw/LaWeNFThIM+ktg1ppuxXMILVp/V+k1UAaBxotGsBOZaLk
	9TBOUEqdyhi3ZtwelBKanrilDtRA8bt7tffCPiQEcYpO3HLym1xDiyXO0ibDrNv89S5eoAuxWgL
	dz0ULLsD0DgtfcQ==
X-Google-Smtp-Source: AGHT+IGptWUhUPghhzbUlnMiXUjXKLkOLTWNhwNQRBrnxW8Pmu0xPEUxkmF80iqK/Ldomew+G/oa5A==
X-Received: by 2002:a05:600c:a42:b0:43c:fdbe:4398 with SMTP id 5b1f17b1804b1-4405a001461mr524545e9.6.1744739760718;
        Tue, 15 Apr 2025 10:56:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d069sm221245635e9.17.2025.04.15.10.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:56:00 -0700 (PDT)
Date: Tue, 15 Apr 2025 18:55:58 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: linux-um@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>, Anton
 Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] um/asm: Replace "REP; NOP" with PAUSE mnemonic
Message-ID: <20250415185558.112621df@pumpkin>
In-Reply-To: <20250414145650.10776-1-ubizjak@gmail.com>
References: <20250414145650.10776-1-ubizjak@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_105602_471782_B109F742 
X-CRM114-Status: GOOD (  18.45  )
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

On Mon, 14 Apr 2025 16:55:57 +0200
Uros Bizjak <ubizjak@gmail.com> wrote:

> Current minimum required version of binutils is 2.25,
> which supports PAUSE instruction mnemonic.
> 
> Replace "REP; NOP" with this proper mnemonic.
> 
> No functional change intended.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> ---
>  arch/x86/um/asm/processor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/asm/processor.h b/arch/x86/um/asm/processor.h
> index 478710384b34..233a7a0d29c9 100644
> --- a/arch/x86/um/asm/processor.h
> +++ b/arch/x86/um/asm/processor.h
> @@ -24,7 +24,7 @@
>  /* REP NOP (PAUSE) is a good thing to insert into busy-wait loops. */
>  static __always_inline void rep_nop(void)
>  {
> -	__asm__ __volatile__("rep;nop": : :"memory");
> +	__asm__ __volatile__("pause": : :"memory");
>  }
>  

That only makes sense if you also change the function name.

	David

>  static __always_inline void cpu_relax(void)


