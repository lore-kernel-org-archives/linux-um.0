Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2551C2BD09
	for <linux-um@archiver.kernel.org>; Mon, 15 Jul 2024 06:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:MIME-Version:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=; b=ywchvNSGplGDb5IqNZFVfDHeUw
	Ic8ydI6fSZZZDnF3UXcGMyp8dizzlsVN+1rbh55iRQPIxT0w+wR5841a0a5zUuZRTjiyvS71CP8N2
	lkUJbjjgKSARhjE8yPGyt1ep7kBUAxp+ZCrBgwl62YVn4mq3dFV5/YydqWz2MkjQQqoD5sSVv+WEJ
	u6RLN7dwGp0bBlWZ3OlH5FtEH1g/thheCE4RhFLwyQ+Y9jIugzgiNa6y4PUgqI0Dw+lZucRVuCS+2
	MXRvaVwLEy9i10K+XyPlAiNS9dFsTWl9Ln/2poiwQ35C6xeTRc4pRsWGz+uwwf45yWkmE6/7/hUXt
	Sr6x+1oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTFSL-000000064Rl-1YAJ;
	Mon, 15 Jul 2024 06:45:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTFSJ-000000064QL-1Nb1
	for linux-um@lists.infradead.org;
	Mon, 15 Jul 2024 06:45:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721025900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=;
	b=Cfd1gwl+twnC4JTRwsMqw1B0HvQ03pcws/kSrY9x30pY4VAGknp1HlAXbmdCgpPwSBIxOv
	PM19EOtqnv1g3k0JXzDhdVZtzXYDubiohmOoLe+bBf2JbUqOOOpEdEdw+bN4t6LZbPpNk6
	AkpebS9z+ook5cdhlQ4W6zANECXDovw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-szTUac1GNaqu9a57bNzufg-1; Mon, 15 Jul 2024 02:42:41 -0400
X-MC-Unique: szTUac1GNaqu9a57bNzufg-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c98c453912so3072817a91.2
        for <linux-um@lists.infradead.org>; Sun, 14 Jul 2024 23:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721025760; x=1721630560;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v8cE6GGeNU+RD+Q2LQy+7INYApFI5BbZGukwj8FEdiw=;
        b=qWZm5Rykqke/mlffIODOfdzo5dtEkqIviSAcSOMlm7rnPKQFOdJZydqolGAFnWG2nS
         CZyDM46oC5LVXaAMBfhYdGvQXNKure3Sty+BAk2v/fd8UXTyUJOS4wE6KxiwTLQOmXbj
         ENREC3E2aKJ1Fa2neSJh4BxlBcJzK+doUTLTNzt7RieXp51CeBamf2hmS+Hc/LtRZKvj
         gbQUIeXylL1y8ObdR9igta4GaTC3p7A6S+wxa8cdVySokNXLoPNHUGJFNtBCgq6wkobQ
         rDRw4bqxEzn5lBEbMTYBTOKvAAd0igWWpijCKRnsRQw9UxnC9kNowQzjV7XIUPx4cNgY
         hK5g==
X-Forwarded-Encrypted: i=1; AJvYcCW7FM2XyGW0kNZPwGBC5oBATW+v5t8v0yRyFM7MV6ItPmFHicMG2E8RwR5OM0VMEuIUgBc5RYJwgX7Y5EG2kbbBT3KRurl5vk6bhgKb
X-Gm-Message-State: AOJu0YzFBNVW5px/IaXMMsJFwa3jggm22Y2IsZJ/mcH5TB9SmyIlfof2
	5iV7DRPKOzxjUA+i8YDjBsA1Ml2O/t92noMsfvXQw3kebm69ZhhyOcAtWRRWnkzj7glzWU3KAW8
	s5f4Dp7lQaTVDnnAx6pV5vnnZYvqDK+Y3VDhblfJewxvIm8VT3ghdp6ModYMCBGZtRhDtQrDF+h
	YLmDg16c6CU/MuHBMZtrM/83qGhVK2d6W9cSGL
X-Received: by 2002:a17:90a:2dc6:b0:2c8:81b:e798 with SMTP id 98e67ed59e1d1-2ca35d3c7abmr12065013a91.30.1721025760457;
        Sun, 14 Jul 2024 23:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlYTBv4RNj4wkh9vEElzqL2vBUU600T1kPQZg9cxT7wUn/6RR1ZSvMIcKwDjEReH6NpcRRBTOd7ZzJ9SSfMhg=
X-Received: by 2002:a17:90a:2dc6:b0:2c8:81b:e798 with SMTP id
 98e67ed59e1d1-2ca35d3c7abmr12065010a91.30.1721025760155; Sun, 14 Jul 2024
 23:42:40 -0700 (PDT)
MIME-Version: 1.0
From: Lukas Bulwahn <lbulwahn@redhat.com>
Date: Mon, 15 Jul 2024 08:42:29 +0200
Message-ID: <CAOc5a3PhrEQ_xScfCxf+kirKg9aBKwEV2NnyKGEDgaDPUfYnjQ@mail.gmail.com>
Subject: Selecting non-existing config in commit cd01672d64a3 ("um: Enable
 preemption in UML")
To: Johannes Berg <johannes.berg@intel.com>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Richard Weinberger <richard@nod.at>, 
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240714_234503_451439_94982B00 
X-CRM114-Status: UNSURE (   6.30  )
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

Dear Johannes,

Commit cd01672d64a3 ("um: Enable preemption in UML") changes the
select in arch/um/Kconfig from selecting ARCH_NO_PREEMPT to selecting
the non-existing config ARCH_NO_PREEMPT_DYNAMIC.

As I do not fully understand the change, I do not know exactly if the
change in this line was just an accident or if it intends to select
HAVE_PREEMPT_DYNAMIC.

Maybe you could have another look at this? At the moment, this select
command is without effect, as the current config does not exist.


Best regards,

Lukas


