Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CE2E6688F
	for <linux-um@archiver.kernel.org>; Sun, 24 Nov 2024 01:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DiNvDPoyx8gdw0gggRgchRR4Uc18IkNUnJdWr+K4fDI=; b=bSYSRzdioLx3m8+ytT+PiL/KVI
	8ivGS0XADWw3QYYzkLi5TWdbOO8Iobe0TIojKEcXvjjFIewI/qmdIeZMKZ8uXFWPPlWzb6Ew5lUQD
	B8cAssU1vqZtZoS8NwVVLWr869Bo3II0A8SiFOn7kKyuYFPG5UHNKA6757hsDYjkMz1Z9Z0RYYwQS
	OICtztIklBj+TMG4fI4dlBWVr0V1fBHiJ1L6ZWr9OfBJ3kx5L8pD8n7V0lBxClzrBhiTbA6u7EoMt
	jFeBUzl2k0myBZUftwB0fifeJErCCiGfzDW02HoSDAjO8IEBMGKqBu1LvMoVJLbP7Pi/23gfbnXjy
	nqJXIk/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tF1N7-000000056xO-1Apm;
	Sun, 24 Nov 2024 01:25:09 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tF1N4-000000056wc-23eT
	for linux-um@lists.infradead.org;
	Sun, 24 Nov 2024 01:25:07 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-21262a191a5so29675045ad.0
        for <linux-um@lists.infradead.org>; Sat, 23 Nov 2024 17:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732411505; x=1733016305; darn=lists.infradead.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DiNvDPoyx8gdw0gggRgchRR4Uc18IkNUnJdWr+K4fDI=;
        b=TE7dKCXYEt0DkMDEhIAu0XnEc/3ruUlA+EGaq9fuBfj8LoGYE9/pjGg30qrBfhq+q8
         1Acz7hkzlXy/jAlvb7bH74tpbzzC0kih9r+zPNMa7cwKpzIBnpqJ6m7aU8xdeEq0XBdO
         eqM+kce9NqwBQlz1yaSd53sPfB225DhlqWbYp99Ny7HbQUy3h6j8XdRGxe/r9yyv/3P/
         1G4zV3FmNvrVM172tVe7cobFYQcBii3gLj81Mg9alcb/n/Gz7lTL4LBZ4Barh84aYssO
         6yTcNJAoByhHo9zygUe9wNrcZH+LB4fVSAQmqKlm+Jzasur0jOEBcB41r+WoD+epICjA
         Xu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732411505; x=1733016305;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiNvDPoyx8gdw0gggRgchRR4Uc18IkNUnJdWr+K4fDI=;
        b=dKPqF+8i1Iajky6xYehYmxUMXSDPMViYxyFOZy44VSrR5QHjxN6RkC4FG0JJRtCNZL
         1KzJhbyAPWwqtM156iQeItkoKAV1KOSBZRc6OXzhAGX/bYyqfK1BT510LiZmYQuPbxpl
         o7AYz0kkqL3nSD8+R+JW5zmcJy2Hqbc8YYfk7zaN6vdvg6TAjM+xPxWfU6Gqy0yO5Y9S
         ivBvPQKTObATF9PESNosy968vJQmxLzCp8Q8rQBDDDmtY6PS5omJ1qzCZp1SQs/+H0pi
         BbGFHzpV05/uYkDCKR1ln8Q1M22+MDMlv1jFd2304JqEDG40919GJzNlRFVq22y4E0i0
         txvw==
X-Gm-Message-State: AOJu0Yzl4yK4MlUjHXtdu6G7ulULme4z0pV7l/BBerxG2fsgrph8oYm7
	4x1lAQsKD9CPFslebIKDsvtzkiAmAWP2Yev2qIHJs9enRqSoIiFy
X-Gm-Gg: ASbGncvs7YUWcC1e230UqZ6P+NaQit/4u+4lsklt6OGvln+YT+IlTQDV2um5f1vGuom
	F5DIXOx8G4mqf6WO7i6oLz36EaBURbxU/Q9CHSZjSKEuSHG8bcZY97lIjf9jzSmohdAw29PE4gW
	hqRq86HChvlx2T3GgkJTZNc1d9bH8oqm0Z0it1eXxlvgn5sOJXlyPa2Om9YNMpQrC6KkgjX1+Z9
	COxtzvQZR9SLin67riVRakH9Jufl9VcGnvFDjabWhfdSJC1UZrqetK/j6scjgW0bix6FD7evw4N
	QbTZ1NP9HEBw2SXV3hn5mh5QwYdWx3b8wmJz
X-Google-Smtp-Source: AGHT+IECzwTtUJ7LtnOVip/6yKokTw0F+4ZCRuQRSp0vg1brTtCYKkSflOykjUdgYrYR1p3TFVaSuQ==
X-Received: by 2002:a17:903:98e:b0:211:898:7cde with SMTP id d9443c01a7336-2129f23e79amr141442365ad.31.1732411504800;
        Sat, 23 Nov 2024 17:25:04 -0800 (PST)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1691dsm38672825ad.217.2024.11.23.17.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 17:25:03 -0800 (PST)
Date: Sun, 24 Nov 2024 10:25:00 +0900
Message-ID: <m2zflpwhhv.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: davidgow@google.com
Cc: linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: Re: [RFC PATCH v2 00/13] nommu UML
In-Reply-To: <CABVgOSmejZH=YZ-2BEf1azCzOXXD5m2pKDwiOvfge=8kYF=qwQ@mail.gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
	<cover.1731290567.git.thehajime@gmail.com>
	<CABVgOSmejZH=YZ-2BEf1azCzOXXD5m2pKDwiOvfge=8kYF=qwQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/26.3 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241123_172506_548290_E9018F0A 
X-CRM114-Status: GOOD (  16.91  )
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


Hello David,

On Sat, 23 Nov 2024 16:27:27 +0900,
David Gow wrote:

> I had a chance to give this a proper try with KUnit, and think it'd be
> a great options to have available: it's certainly nice to have a fast,
> easy nommu architecture for testing.

thanks for the test.

> I'd echo the comments from others that ― at least for the testing case
> ― it doesn't make much sense to go to the length to use the fancy
> zpoline patching (as neat as it is) compared to a simpler, but slower
> seccomp-based approach. It'd be nicer to have a simpler, more robust
> implementation first, and if there's a particular reason to want to
> speed it up later, zpoline can be added as an option.

I'll start to explore the possibility of this option under nommu; will
get you guys back here.

> Plus, if we can avoid the need for vm.mmap_min_addr, that'd make it
> much easier to run the nommu tests alongside all the regular UML ones,
> as none would require either root, or an otherwise particularly
> special config.

Though I thought this limitation doesn't have much impact, we'll also
experiment if this (not using mmap_min_addr) is possible or not.


thanks for the feedback !

-- Hajime

