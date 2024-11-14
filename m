Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92361D65C79
	for <linux-um@archiver.kernel.org>; Thu, 14 Nov 2024 11:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcRtZRAtklIfbX452cq3UuL4sVx5Lq8L0ye2jnnDq/U=; b=BZ6VdABr+GeX0cR3N/2wpVauR4
	aIf00S1xsSbXXDHJQyLOlRqMmJCeonwMNOIOtXAIf1MB8Z0ro1Y+oWhwIgH52lHTnpkkYYmkRixH3
	R2MfLXkvZSMIv4yne1z8LsO1dBwRH4cbtsH3olkUNBmj7U23xO9Zo00bO5BCxN1N8ttg0UEnqTSHj
	e9BgIKg8jhfSf7gdTXdJkRpgY8pwak5TqNct2YF1q+xBViQyqo0ushRg1Pp5uoPZkuDAsOxRJuHrO
	2jLcXs2kYpjd4LGWCKU+LnUtnqMs0Gc/4TEB93i6qDkSxrODWcpdns1nwa40EyFjjReEvzgQm+HJ9
	32f1fv2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYEr-00000009lZf-2GuH;
	Thu, 14 Nov 2024 11:42:17 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXII-00000009aEI-1hr3
	for linux-um@lists.infradead.org;
	Thu, 14 Nov 2024 10:41:48 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2ea0c38f0fdso149275a91.3
        for <linux-um@lists.infradead.org>; Thu, 14 Nov 2024 02:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731580905; x=1732185705; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcRtZRAtklIfbX452cq3UuL4sVx5Lq8L0ye2jnnDq/U=;
        b=Dmkl6iEjvZ9/C8Kja/IMEOKNzl5A0SD/sdPcJOn/cKZjZrHR6HUGWOcQelPoWIsgn/
         xR2T5zGnO7DyPjoppxd9xTzTEp1knRiX5Mkuc5w9KzVgAEwe8ytM1ArT0XuOaC3HAClC
         1yqSaOoufc005QlfgpPodUC6YwXDwaZLzTaHFG5MzccSEA/ivOGjW2M7oQAhRZOz7VG0
         Ekb8pPguu6Fqa9HrMMSS0Fcd8HKLY+Jbu9/8tSfpZGmqMuN3YmZ9LiLCj50u52kGEmnw
         yY+rSWzVeCzMI4y/uXAHxruc66qo25mQPI0rpalJU1DeOtMgRjunALdik26XsXgB5WvO
         xO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731580905; x=1732185705;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcRtZRAtklIfbX452cq3UuL4sVx5Lq8L0ye2jnnDq/U=;
        b=YCbijHUbbrsWf/IWOplWf9w3aBXswXC80bXQFcyILEDnejn5LV8CoeokaRpm0RyqmC
         Jy17JPkNI0t8yKvp28bh6ySSovtTCWqw7kI/qK7DoifDFfMEB9HI8E4tsSdzInNoo7AL
         WeDyf3GCogzuwP3N6xoOUC2ezMKRuxkbSDMRhTj3jRxKtlfJtBI0gNVuDOCyJULyKtaZ
         QjmNVjdT8/7wdGJnQPdI3VO9CCT//GLPowHaU/rSLjn1n3luVmJ/U6+LOQg2wbIjZ5em
         tbufISf3xNMGk5M7BPl66Jb0/Q1VKVZbZxCk7WMKm/Pk9uwC0/boMMSwkbsgRioum0xm
         Hr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhwSVDyrcpZ94em7krZKViIAbsylhBNYSW3Ou/nzbwykzKe2DYGX+cU1VfGgmCxCFL+F2+JA0CpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywo9ReSk0S792NhxYYoD0kJGwZ9pKhkth5xpjN7BJtO7j5QzRFG
	71Q9SpBAKhqnmLHiYZNc7FI8e883z3bfkGv9lf0oYrjTpdLsk5DU
X-Google-Smtp-Source: AGHT+IETO0T5CdPmBixIh/jL5AuC+2KzjP5/EEdAOtq5cp8iWXa+uieiimcZX5nA4JZQrpMEgBBSCg==
X-Received: by 2002:a17:90b:6c7:b0:2e0:5748:6ea1 with SMTP id 98e67ed59e1d1-2e9b1797ba9mr29895862a91.37.1731580905114;
        Thu, 14 Nov 2024 02:41:45 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c6b1sm885062a91.32.2024.11.14.02.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 02:41:44 -0800 (PST)
Date: Thu, 14 Nov 2024 19:41:39 +0900
Message-ID: <m2frnuf670.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: gerg@linux-m68k.org
Cc: geert@linux-m68k.org,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	ebiederm@xmission.com,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	dalias@libc.org
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
In-Reply-To: <7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
References: <cover.1731290567.git.thehajime@gmail.com>
	<ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	<CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	<m2pln0f6mm.wl-thehajime@gmail.com>
	<CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	<8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
	<f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
	<CAMuHMdVRB46fyFKjZn3Zw2bb8_mqZasqh-J7vse-GQkA3_OQDg@mail.gmail.com>
	<m2o72jff2a.wl-thehajime@gmail.com>
	<CAMuHMdXKAz0bxBGrbbHD6haeCbhYh=pCb4stox1fOifCvyCwpw@mail.gmail.com>
	<m2msi2g15z.wl-thehajime@gmail.com>
	<7290bc34-d398-4ea1-8e52-193f1021e114@linux-m68k.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_024146_473580_3DE373C1 
X-CRM114-Status: GOOD (  10.16  )
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


Hello Greg,

On Thu, 14 Nov 2024 10:40:03 +0900,
Greg Ungerer wrote:

> I was only interested in the ability to run ELF based static/PIE binaries
> when I did 782f4c5c44e7d99d ("m68knommu: allow elf_fdpic loader to be selected").
> I did the same thing for RISC-V in commit 9549fb354ef1 ("riscv: support the
> elf-fdpic binfmt loader"), limiting it to !MMU configurations only.
> 
> There is no need for binfmt_fdpic in MMU configurations if all you want to
> do is run ELF PIE binaries. The normal binfmt_elf loader can load and run
> those already.

Yes, my motivation to use this loader is run elf PIE binaries under
!MMU environment.

-- Hajime

