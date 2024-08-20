Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCFEC3DA4A
	for <linux-um@archiver.kernel.org>; Tue, 20 Aug 2024 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=; b=yXzEbHREqyu+my0ZGw4kVAPbri
	/YnL2G/wpr4F9TXDIhiIm1IiljYE9R9X6DU4xTT+xhZNKBl08zq+2+SotCFl9uO4Z9h6zxQLo90Cb
	dXLxhEhNbO+PGvbLgk75uWPCJHxhtngtoF5ZkF45WyY6Ln9naeTaQ8ELdz5zeKQpWjQrkG3VeAR6i
	E9S9taIFVVcAYS5m2B0bwbvg/+1VVzFKB/Dz0ltikyA2c6boD7WOECcHAKCq/xQjULiHYsMey9cVC
	nyoQuQkXNGkZkh3HmaYcx/NO20qGr6LM/Qhdnh/wjtVhlFrhKoUysRU6BtS5S0AyTOmV3hKx0f03z
	nEdIC/xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWqG-00000006k7e-0wSh;
	Tue, 20 Aug 2024 21:56:40 +0000
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgWqC-00000006k6X-3dBd
	for linux-um@lists.infradead.org;
	Tue, 20 Aug 2024 21:56:38 +0000
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-44ff6f3c427so31501331cf.1
        for <linux-um@lists.infradead.org>; Tue, 20 Aug 2024 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1724190995; x=1724795795; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=vjcsL6ozH8t5TLAhiip5QjfG7XFKXw3Asneb+061PW1W1UzCdbgr5J+gQhuAIyVHEr
         58nGy5GZU/NCAAGgH8J68EJCETOero/986q/uAXK+ygRFSH3d6YOjMiD5JN8P8PWJUYM
         +QB5xaqYmE3p+zhjxJlfnrgfb3oyV4cSQJ5qSv28txuzIhrawhc7hB+iI3Mw+F+mRwx6
         3RsGwp5ElBCyis1TdSsqItmSnUyz16MGXtNL1ho81cd+uUzqfTVGNu/RZYKxa/jSXg7X
         t+1za929UXy+sufOB/5BwFUyaRy1ZcaL0lncSC8L4uUeIun9m+IueCskd8ed92ywDVgj
         tIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190995; x=1724795795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=KPFdHK9UPybkg5x3XoOjQae+WTEu3m2pcWEnHe7oRzlnKqYxxxVRfHNHZzOdlalD0p
         WgWRublP2eADAGXwwDfyOeNOHMlv6Y3kVicuV61Ez/+XK0XqfKC092+ixPyDBunASrza
         UwewxtdsD+6y/pR4H+xX6vPOQKfs3YoBLnTwyMlt2dEzXT3NYoZEajx7lTpT9F7ggxgi
         T3E9DRaE/5WwPiNheP+kgf53/ap/NCutH7YJr78b2Qp5NjmdGdk2s0eHdBFOYsmD6fQT
         PEy6gvI/CwNenbQNSdMGoABbOIZC6gKm0IPu5BVhLptkovR2iTBUh5kBb9BAz8KTHHhG
         9LVw==
X-Forwarded-Encrypted: i=1; AJvYcCW1t6OUqI1uXES8M4DhY+n1v/MGhRC+PMxNQuMJdeIp6i9xUqMZ78RE7pvXxWD0r2f2H94VsvwcIg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yye/wIAHwmrO9mM/vNt95OYbFm+A3ozFeTW3tmy9Qjy5GEud1Oh
	W17yQG+R5y8N+w/NV8/nXM0BQSoo/RMiN0cjAmm7uRX4HJZ1Gu0UQOhSph2sivQ=
X-Google-Smtp-Source: AGHT+IHXvZQTYbODvbtiWMvtKaWw7MfhUsJrv1XSsVar7SrJFLG58wKSOeDH8tFL+40SZRU1vcMC1A==
X-Received: by 2002:a05:622a:260b:b0:454:ec22:dd79 with SMTP id d75a77b69052e-454f2218babmr3430781cf.24.1724190995315;
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454de4fa40esm18021631cf.21.2024.08.20.14.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Message-ID: <67108df9-7374-a64e-ca82-8c46d67fb55b@landley.net>
Date: Tue, 20 Aug 2024 17:10:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse>
 <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
 <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_145636_940466_BCA8C0B8 
X-CRM114-Status: GOOD (  11.84  )
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

On 8/20/24 16:31, Linus Torvalds wrote:
> On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>>
>> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
>> somewhere to at least smoketest...)
> 
> The '&&' is just a typo. It should obviously be just a single '&'. As
> mentioned, the only testing that patch got was a x86-64 UML build
> test.
> 
> Fixed locally.

I deleted the extra ; and arch/sh4 built and qemu-system-sh4 booted to shell prompt:

Freeing initrd memory: 556K
Freeing unused kernel image (initmem) memory: 132K
This architecture does not have kernel memory protection.
Run /init as init process
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Type exit when done.
# cat /proc/version
Linux version 6.11.0-rc4 (landley@driftwood) (sh4-linux-musl-gcc (GCC) 11.2.0,
GNU ld (GNU Binutils) 2.33.1) #1 Tue Aug 20 16:45:25 CDT 2024
# head -n 3 /proc/cpuinfo
machine		: RTS7751R2D
processor	: 0
cpu family	: sh4

Tested-by: Rob Landley <rob@landley.net>

Rob

