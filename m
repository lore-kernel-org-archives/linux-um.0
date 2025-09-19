Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF72CA1013
	for <linux-um@archiver.kernel.org>; Fri, 19 Sep 2025 00:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hI40T119u35xMB16MFk6zQZpzcNd2m9zwdEQjzTmVk=; b=h176LSUxU665PdlLEghUi8q82/
	0rl7UqL2rBYg5BifNY4GsrHsGPZbQ7wUe1NuzzKI0WiwqwNE3XhgWGow+v1HMyYclkx0ChkM8Sn+7
	8tyU+EMKfJMGjJkJXIKk1xGm1G6b5/T2HMQVQFLYN3feW14x2AR38Eu4rZDyr6EskjeVX3FjxPCTK
	CAVkm2MVZfJNYEavxPqpTmtcddZIcW6qocJWWJ2zj/0FvlaKFQzLOXU5HyY7XbUhUrbDIcmHLnXOX
	gV7numd3edMJ6w3EE4meO/Anmi6/X0UBOvybUOHThB/ut6SlzmkDSjBV4X69aYC5MjA5CUxHwRLd1
	yRKAV5hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzOau-00000001UdA-1A0R;
	Fri, 19 Sep 2025 00:03:20 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzOar-00000001Uco-40fL
	for linux-um@lists.infradead.org;
	Fri, 19 Sep 2025 00:03:19 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2677a4d4ce3so16570355ad.0
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 17:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758240197; x=1758844997; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7hI40T119u35xMB16MFk6zQZpzcNd2m9zwdEQjzTmVk=;
        b=Axvp74QGaHQSxmAw+SRLPMWhGKSe2FoEPMrtUrxUDC+LETkcJAmV2NEGWhbLC9M9eP
         vFKhPxVBZxreBCAh8l6DGJxu/4g1oViUlAH86oUqtZyeG155SA4M0LYsVvlASwWjPQRG
         kpv1cNZF6CDHX/Mel+FZPOixuICqWC40SMzK9FePFqk2YcEAN3Tv7RTvH9DCspb8H0mZ
         ASbOU9ivN7mSN5+bjopxqRUWxHHQmKS2KbNO9hYG+S3cbUYGpxHZDvMoPgTelsmWR6MO
         2QzdclnRScNqRHDrJwDojFkjipJrA4nbRwJkgOmxjQPpFSY1fv83b2fxKcYwAHniuvpr
         Dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758240197; x=1758844997;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hI40T119u35xMB16MFk6zQZpzcNd2m9zwdEQjzTmVk=;
        b=WVGBXRUNa8Q+XjtG3gb+mdOIpJuskg6MGsamul/QYyXbfZsyA+yZiC7BNMe/VQYt7h
         sbhdu5/L4KV7NeDppyFAMgCt3bb84ienagXypebUGLvR4BSYJpT3zP7odWEJ87mrqwbb
         961qAKNQAYaxLlEHUldCqDYLUp3iCs3eACkLhUKUMxG2BD8N+3lQvrlfA5zx9NEXbgsR
         DvTWTMxX6RyfW1PABX8lZRktoH2mDuYl96kjBQWJdNZjqW3lGNaTg1YBa1N/7Ne+tAd2
         KSNFsGKf9Zj5e6TS4mGCiQKAi+f6wd/EEreqE/UaE38k0LSlilULfFUZnGiQ+y30ualz
         aFzw==
X-Gm-Message-State: AOJu0YxZg5bAb/AWmwpzW9qRQgSLNu2H4FMLqasCZ/Stvdq/cnxgVvIA
	j+SBkTvnB+fNDAqCsD9/nXjSHDkGn/m7bv5sIWsDQs/OxDyXqaLs+RWg
X-Gm-Gg: ASbGncvKdgNf3HnlX+LWjI3lg4521umEBGeQDK5q9qbWBYfOC527ZKVDx4ihZcJwbge
	3WcVqRdXKANMamktpt/l1i7NI5rKZxzODFL+bLEK1w7YVCKuulEvuVSIuKfrV74700PBfYjIF5A
	fJeH9xRXIepW4cags2IFm2+FKM3z/XrfCyle8qicgKgd0KYThCPwWBsT+3oQbbnReSTtwB5d/0k
	jR4BUJw7rQC21uqkKNalNxL4Wkj8ksGi6xnbnyc+3hBXNHDQorkejne1XZTv3h9ULJQWLx3gN9A
	rsCjvRi7w/GdrWCCjwvNlYnM0XXaFWNLzOKQzdtxy8Y2QEm96YWWch6jrEqJaIV20TGZKBYxbNN
	/+lSOxLji5DEafJ14GmO3/yfz6JXzby5RDwpSmvBnVYzKON8wsY8qDliE1/eGnRmdjaS1+EyTgd
	DWDYlyXnXU
X-Google-Smtp-Source: AGHT+IE4CCFgX6WgpfruOqzSmBceJrAO3FeeVjUEHkbLe2Vz0fVtKjVcqofxxG2CJYN54iLsGj3qsg==
X-Received: by 2002:a17:902:ca91:b0:269:a75f:e9d5 with SMTP id d9443c01a7336-269ba5628f2mr11631335ad.42.1758240196866;
        Thu, 18 Sep 2025 17:03:16 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff35aa47sm3388607a12.5.2025.09.18.17.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:03:15 -0700 (PDT)
Date: Fri, 19 Sep 2025 09:03:12 +0900
Message-ID: <m28qib8g1r.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_170317_997525_42EEE1B1 
X-CRM114-Status: GOOD (  18.52  )
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


On Thu, 18 Sep 2025 17:30:22 +0900,
Johannes Berg wrote:
> 
> On Thu, 2025-09-18 at 16:39 +0900, Hajime Tazaki wrote:
> > The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
> > PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
> > drivers over PCI devices (e.g., virtio-pci), the current nommu UML
> > doesn't implement it.
> > 
> > But without PCI drivers kunit complains as config for kunit
> > (arch_uml.config) defines the dependency to PCI drivers.
> > 
> > This commit fixes the issue of this compile failures when building PCI
> > drivers with nommu UML.  In particular, the fix is to undefine the
> > constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.
> 
> This doesn't make a lot of sense to me. Why would we even want to build
> PCI on NOMMU-UML if PCI in general is dependent on MMU now?
> 
> It's not like ARCH=um with PCI and NOMMU has any value even for testing
> if such a configuration cannot exist in reality?

totally understand your point.

now I see that we don't have to have this work around by using
--kconfig_add option to kunit.py.

# like --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=n (in addition to
  --kconfig_add CONFIG_MMU=n).

so I'll drop this patch in the next version.

thanks,
-- Hajime

