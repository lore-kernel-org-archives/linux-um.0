Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42179C47073
	for <linux-um@archiver.kernel.org>; Thu,  4 Jan 2024 23:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBrAMlim3r+duQUKHf5gxI3/96whhQjT8hqM4vJwaJA=; b=xgR7zh4nYVGEnW9Q8X5QYdZc87
	kqeTBsSq7m0oX+2tRk/899w+qMC9tjP73rKWqd2iPXHORe5QXnmESxnh0SSdIlVLpdYxx1dEOpAue
	zQVm8TONF6oCu01VZx1tQM6m2vrU4ZatcXy8tzpP80Ab69hN7tMLINWQ/9X7HceoIhqaKJBDXExXq
	QIZ8iQ20jpIYRdPLDharBVtNkrDcr3fv1/ZTZtmPvGmF5u9HoIbJYHhYfuqt0pVl+gxHCahwvYbua
	Mzjw1lvVibY6/zcCz3hQLxZChoNO2wOd253gDz+SKrRJSvwrhv1ZkJeXFunzADLPEFRvdDhF4fdeg
	AZLvOyRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWmV-00FPil-3D;
	Thu, 04 Jan 2024 23:05:44 +0000
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLWmS-00FPiT-2D
	for linux-um@lists.infradead.org;
	Thu, 04 Jan 2024 23:05:42 +0000
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso1127007e87.1
        for <linux-um@lists.infradead.org>; Thu, 04 Jan 2024 15:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704409538; x=1705014338; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBrAMlim3r+duQUKHf5gxI3/96whhQjT8hqM4vJwaJA=;
        b=XM3hC26ppPfC2fGhPBvuPE0vNeQ8LM+ysui+NbwmdpOcW6C9gwDE6drLGi1hO5Z/CF
         nbi/l3FMnO0GamUZqOBwv18m1ZBhS+F2mHnX52B5r+AFYB883Lh7hy1yrLOSUcYqU3tm
         TKokJU+DWuFQCj2WFD5dBo6tUgjF0iYobRqbcSlfsG4iIpDg0dzo0jS5aXH4G9JEhj0+
         tHZq2u+s9TKrGQDfBxAtS6M5DsQWBpN9Yfnp6UBENuDh+jMJcKRZ3nvl2xwxN/IXlPrC
         6tlVI6ddfLocyH/AtZd+O6VKeHK1cXdnNeAOxmsqWCsoFWifds7m+17+1v6ob7+Ue8YA
         gD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704409538; x=1705014338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBrAMlim3r+duQUKHf5gxI3/96whhQjT8hqM4vJwaJA=;
        b=byj8GorrcFckiVJpQhZN1MxQ6QrmzEgcvkuTXvB8S1c92qwdeI3DozrelqwOgrsCnc
         rmJC4EAHMTv0Y9zlq/FPIGAwWBKhDwA8xfSES1ZRJAyI4nLMEoG3H3nffSXCAiw55FOw
         wUXj0Dm4BBDMLLkh575URoR1RZfdvOQVTaeXWlAPY6EttMgxK3MVjKJ4goTfwjun3EQC
         PqEBbOyz1c4uKO+NfUaP/RfenT2GUN7uN1t9hz0PZggkFqkmUkBTyfVqAxFAf7Zyvffv
         F1akKHQfbuHpIzujGeueaIFt5pOheDraLdGWNFHTZMugyGInj881gpPZ/a8SGIgMHQ/h
         sWGA==
X-Gm-Message-State: AOJu0Ywtv6w5DwXZdn+OBluX7UJO+FYHNgOdYzlJ4g0coXBCqFsk6/aN
	4ONAzHC4jWL8EKq+o8vKwjj5+I3Sc8+yv5HphVE=
X-Google-Smtp-Source: AGHT+IGPHhi2z26rjTd33xwrCmdtUkpqxbh97sY2vbqul+KpmGz+nQ42i0G+Yl9F5DXtflItOgrYNITfE3bqS8VwmFk=
X-Received: by 2002:a05:6512:902:b0:50e:7212:5db5 with SMTP id
 e2-20020a056512090200b0050e72125db5mr309034lft.80.1704409537620; Thu, 04 Jan
 2024 15:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20231110110348.1815612-1-benjamin@sipsolutions.net> <20231110110348.1815612-10-benjamin@sipsolutions.net>
In-Reply-To: <20231110110348.1815612-10-benjamin@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 5 Jan 2024 00:05:24 +0100
Message-ID: <CAFLxGvx6zVDy8pjacb8Dq9d884gTjpnPUapJ61GZAMy_39wGWg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] um: Rely on PTRACE_SETREGSET to set FS/GS base registers
To: benjamin@sipsolutions.net
Cc: linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_150541_467879_23C55214 
X-CRM114-Status: UNSURE (   8.96  )
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

On Fri, Nov 10, 2023 at 12:03=E2=80=AFPM <benjamin@sipsolutions.net> wrote:
>
> From: Benjamin Berg <benjamin@sipsolutions.net>
>
> These registers are saved/restored together with the other general
> registers using ptrace. In arch_set_tls we then just need to set the
> register and it will be synced back normally.
>
> Most of this logic was introduced in commit f355559cf7845 ("[PATCH] uml:
> x86_64 thread fixes"). However, at least today we can rely on ptrace to

Do you know since when exactly? I don't want to break UML in subtle ways
on old kernels.

--=20
Thanks,
//richard

