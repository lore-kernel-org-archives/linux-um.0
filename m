Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1990CCA5FDD
	for <linux-um@archiver.kernel.org>; Sat,  3 Oct 2026 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Subject:Cc:To:From:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/oIu14jUGCFAHwNtKrIHGbo5GeSCHJZDG7wMHq45NE=; b=X4LcSvTom2KP7900qR/oO7fiwd
	z335RMrzDTj8pPq49wh4BI3BIdVGPqaXeS+NmUzmc8h8OltZg6/dnllilTZaM2hJbfKv+I1IzWn7t
	or9+QF+jE6onkPapF/DpFBuK/as06e3afb4Uz+HYRSfRG1hvsZrlKODAS5WjDa6ZgAdlUd9tomvkW
	CEv9hlQ0QgnUg9pEAcEG+DcWN9LJ9tmx+ac/UZ7B0ABTSNUKpViV1xtTOBlGzZuxSI18+5FNUNPqb
	HmfN1aBpPq0ADET2ZtDMVcNqTUUAtDmTYKWfiDsWQ3flkdYeIvoTC1p1ww779tM0i6cuhxzPwKm+L
	QaO9je4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD8Om-0000000E8Ab-008B;
	Sat, 03 Oct 2026 22:40:08 +0000
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xD8Oi-0000000E89T-0Tug
	for linux-um@lists.infradead.org;
	Sat, 03 Oct 2026 22:40:06 +0000
Received: by mail-pj2-x11.google.com with SMTP id d9443c01a7336-2d8fb334e72so1679055ad.1
        for <linux-um@lists.infradead.org>; Sat, 03 Oct 2026 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791067203; x=1791672003; darn=lists.infradead.org;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n/oIu14jUGCFAHwNtKrIHGbo5GeSCHJZDG7wMHq45NE=;
        b=FlZhXW+P/b8AG454bAw1FC3UyXdylMNAmdBXqNNs7Ll/Lm3pLwxtv4C6aE9SdRm6Vi
         dZ6aK2fu1fs6j/K0VKoZqvhuA+flbK9N+k4vCId5zeFoJNdpz9Tleh+bKwjnNaJTA7IH
         SyICMgyKxVZeNLf6oK+tUDxtQP76TKTAIqhOLG95pGtbBBWcL5sNH85g15wcZWgJY1vy
         8IppyJQNMN1r3LQaw7QR30OSIEIMkYMQuUJxz6oitGMJsl6X68MbMZE42vQwSWZptQcM
         hK0YjCFgbJZnJgT2sw7gAjJefyInpPcCL0TgSylCWwpdPb1EtaOcjlff8V3wP2Ccj0rX
         hNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791067203; x=1791672003;
        h=content-type:mime-version:user-agent:references:in-reply-to:subject
         :cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n/oIu14jUGCFAHwNtKrIHGbo5GeSCHJZDG7wMHq45NE=;
        b=c1AClES1OUzS1GiwqvFF5XmSVSY/WvuaE8rBZ6qwRnfWmaHL5/qDl1VkCokO9uHl54
         hmlO6bpU6zoyYwqsMFMIL/OG476O/vaXSr/9PdcbskXx6JVGjqFRwAayurnFGzjlMHCj
         kkK0Vjkc5EY9yIZXgLkClcOdpAPfQQNpwR2xErzpbQj1KsuALIk4y16A0NBeFmQmMPMN
         rLbM0Ty4rQ0wwa3HSL1knlt+7vQW9qahveFAY6kmZLLe90UJ/56CQTmxcmQQTKUc4nTV
         x6k6pP8APbz/u2FncoP35nM35bOaFKXiB5xWVkAlqjVc+3EEF/EX48cXaQ6oM5p2w3G3
         5dbg==
X-Forwarded-Encrypted: i=1; AKwUvBxV1MIE0p0/UtuGper7KT+NdD3NIdSc2LdKhk0y8XNl7UezJUWnOnlLOgSdGGb6n/S/rCjneDjqWw==@lists.infradead.org
X-Gm-Message-State: AFuF++n8E7EzUipUwwlde7Ln8QiytmnRBWE8FWbUfQuGKrFE+E63GPnC
	bd255YNu5La5eXWq0nCLA/Qd/pDSRlHh19XnvAdX9H4g8ErvHvaegj6eJFX16GyTuXE=
X-Gm-Gg: AYBFou0SXvm8rMv+DjL9FpF6LqXThe1C/B03uw6vxXIGfrxaQOGOiVYlkXxTwA3jKo1
	4DicuCbbDX/facK+t4/bftG8T+neVn6+lnLcCbUe7PArrKfw6j3VH01LVZN2KOfHsasHIV1x/v3
	ZzdjJA5gtZb6vMTxgFW6ynv88kwf4Zv1klejnsxWCPn61dyNyhzHs8J6vvPTiIyGN09qyocRg4g
	reYCNBBuRXgWWgFLL4NtJ4n2VePt2RC/YXNz0iI3/3kzHEyVMDzqcoml3SC/V1Y3KLwavTuXs9P
	rikCCb3V9oaAs6eZE7kWeiR5koj0AOyrMjQdhI6KpzAiX52GEOyUHgw0M098YEDzGXWruy1Ykiq
	QiqJ5brJaBXVuCiT2q/Qv4xVyuWQZH2yiaAXkrW5bfXEz/5BiF3W16Q8ZAxo7AHb52sz1FMFY9f
	INb/AMCjRuO6LpeJwoU39ds/xrMOdNAe6SAGu8up4He7m7IUh0heoSOlBSH62ui/FCCA+TdDR1A
	Q/sHqr7z0JCRCgozxnaUQp5v6qkXNr0wQmEubKRvadShPbJzTspcYFR12SJqd52lLHI/3Asd25N
	jvMSw7rAyAVPHEM6OwfqPP9jBfAwWKNBSXbLD1Sx8n03HI+6qblZns5xRs8YCOXjpbQlnO1DrMR
	QuoJg5nPsPxk=
X-Received: by 2002:a17:902:d506:b0:2df:84e0:9034 with SMTP id d9443c01a7336-2e49a7cdc18mr57178595ad.7.1791067203022;
        Sat, 03 Oct 2026 15:40:03 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e49f7339desm19297455ad.81.2026.10.03.15.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:40:02 -0700 (PDT)
Date: Sun, 04 Oct 2026 07:39:57 +0900
Message-ID: <m2qzi62yte.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: david@kernel.org
Cc: ljs@kernel.org,
	geert@linux-m68k.org,
	johannes@sipsolutions.net,
	linux-mm@kvack.org,
	liam@infradead.org,
	rbm@suse.com,
	akpm@linux-foundation.org,
	luto@amacapital.net,
	brendan.jackman@linux.dev,
	liuhangbin@gmail.com,
	corbet@lwn.net,
	kees@kernel.org,
	broonie@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	shuah@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	wad@chromium.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-um@lists.infradead.org,
	daniel@thingy.jp
Subject: Re: [PATCH v4 1/2] selftests: run tests on nommu architecture
In-Reply-To: <d6ee0a8f-e7a8-4fa7-88b8-62fb44bfc863@kernel.org>
References: <20260929235711.2287931-1-thehajime@gmail.com>
	<20260929235711.2287931-2-thehajime@gmail.com>
	<bda5eeaa-7868-4d4a-9026-9e99347afd7c@kernel.org>
	<ar4br2vW7yZGd3gt@gremlin>
	<94759bed23f00d2044005e36be6f72f297e092f0.camel@sipsolutions.net>
	<m2se2o3jyc.wl-thehajime@gmail.com>
	<a65f4431-d225-4535-b921-00319ceeb2a2@kernel.org>
	<ar9ldn036SgT-bq1@gremlin>
	<CAMuHMdUKcUxHZKhTEF1gwWrU1o8O6jt6N3r90V5hynrLFdwY0A@mail.gmail.com>
	<ar-bIzYDdlOKUqla@gremlin>
	<d6ee0a8f-e7a8-4fa7-88b8-62fb44bfc863@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261003_154004_159815_88AD5095 
X-CRM114-Status: GOOD (  19.87  )
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


Hello,

On Fri, 02 Oct 2026 21:21:53 +0900,
David Hildenbrand (Arm) wrote:
> 
> On 10/2/26 13:53, Lorenzo Stoakes (ARM) wrote:
> > On Fri, Oct 02, 2026 at 01:38:31PM +0200, Geert Uytterhoeven wrote:
> > 
> >> On Fri, 2 Oct 2026 at 10:10, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > 
> >>> But fork() -> -EINVAL or -ENOSYS = nommu, then just have the child quit and
> >>> etc. should do it.
> >>
> >> fork() is not strictly an MMU-feature (you can implement fork on nommu
> >> if all memory accesses are done relative to a base address register),
> >> while I think mprotect() is an MMU-feature. Unless it can also be used
> >> to change the protection using the one or two BARs most MCU haves?
> >> Anything else that is a real MMU-feature? Non-identity mmap()?
> > 
> > Does any nommu arch implement fork() in linux?
> 
> I was about to say, that sounds a bit too theoretical for me. IIUC that is not
> implemented, and if someone would propose it we would likely just nak it.
> 
> In the unlikely event that this would see the light of day, we could always
> change our detection in the selftests.

thanks all for the inputs and review.

I will try to implement the detection with /proc/meminfo.

-- Hajime


