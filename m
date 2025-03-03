Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39601C282C6
	for <linux-um@archiver.kernel.org>; Mon,  3 Mar 2025 07:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z3xf7HJyOLISUqnBF4lpknQTsncyxq6apcdgU1Q2bwI=; b=Uh4TlBE8ZvE6VJV0WTNSOrKya9
	Rd8g9DqNJv48UDfw3TH6KccyK2q4NGEf333p9NPD8kKobMnjIMZAReFl+68CAsw+odobZ4mcs9uDI
	eIjVOLgtP1LRqLGKraFSITJW824KIivCQR8KGTaZUk+5sdsUYEHHJyCUzcrN1f2rKblXddUEzF1Rc
	tpk8V4dSI1UXLDFrP4ZWJtA69X2GYahTqfVvl/Fckv2UoMl6Lg+IPhRoSqtQ3F5W+4YmR5M4IHx7K
	mvRaRZH6whcDFPJYl4IFz9U5inAF2/dJRp33tfp5eTZazKx82276ULsw5NPpS823+dghnNxtvV45K
	g/4bGYmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tp01f-0000000HPZT-2gFM;
	Mon, 03 Mar 2025 07:15:43 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tp01c-0000000HPXv-43fu
	for linux-um@lists.infradead.org;
	Mon, 03 Mar 2025 07:15:42 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-22349bb8605so77130425ad.0
        for <linux-um@lists.infradead.org>; Sun, 02 Mar 2025 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740986137; x=1741590937; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3xf7HJyOLISUqnBF4lpknQTsncyxq6apcdgU1Q2bwI=;
        b=YgvsSN9MJ+Lb1CDMHpW2gqq7DpanaebfUvcbHO0Iv7DIdJeLxmDvLzX4awjF/Lk8bD
         WqdrXQsVYiKVnvqQX35U74BzWw9mCsiplEZxilR5xoFyPYrt9+4TrHR7BhIux781WWaY
         XPk1vN3z4oiQ9BIwXlrHEwSXRus9/JD+lH7MsjE7yf/qnlv25VbVuui4ewBDCYdMeUIA
         WQWtrJceU5uLpY+dLNn2+FaqLKpHJRoJyfU6VSziK9rOdmOLdOKZlNa+aw4PmsihaW6b
         OdkgQ+IOV7mPsIGvI6Jqzqz6ergML3IjMyiaUdzyNvB/anXqVQP/uClDasLjjLpTJ1l3
         ZT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986137; x=1741590937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z3xf7HJyOLISUqnBF4lpknQTsncyxq6apcdgU1Q2bwI=;
        b=KDGg5R6g6XxixVInyzpgE1qfcpsZC2ON9WfqRoc1HnMe+L6L0rlZtz4esAb1QsBWzp
         lLjuy1T/mgpXvb7LY7WlSz0V1fdQIdqOAdJU/pV6z/QnKeZDyjB+oPni2XYUBZhMERvX
         oq5L0MboCnQLeWTmNzWuhtbyAQ7F/guO3nrC7Eo1HvM1zmmNrJn6qM0iCIt/M04G5/Nl
         dNpRzpaO3ry9K03JfeXJwgRBrUnG94BlxLJW+nYLA+9FI5qJ/t3g1VFgg2SNIcCt9O38
         K3b8ajtpawPJZW+5PkNxCo7m5v8GlFYI/E0GhVYm1x2VnJ6hiUWuaQW7N3c1/SOyMIAy
         G2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnY9rbvayF65fV+ALkq5sya3k+gUaoLxu7X0KCwDsh9zIejur4b9rsKqz/ntiLPMRGwGzeLHz6Kw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgjS8N1TANLs86UWJ9zWkQ0AeY6g6SsXOqFXBFZ5qw5pLxCJSZ
	csBposv/kvu/eAmZtYYrfvWOmDSZ0jVP7ph7MIaYwyOAXrDrIs45YCIDdaevZT0=
X-Gm-Gg: ASbGncvjC9SZx6RPKEyJwdxcX+3DTJtKOjYeRSFVQiCQnddRLiaGaSFD31mO4rBg0va
	ix8W/8zbS0C+fTJwUDx9vrvO2MGJS+7p+jgrKt+KsVy2PoXr5bSJkrBgSb87795fQvhUSp6B9qk
	jf2NQsMnv70umuPRdzZ2zLmwbaXlg+iAdV0v0asCr5uG79urcArPQDhFWdNrm05v8Eqy5Jp/k3K
	c90JqMRF566hUvctrhd2+SUi9y1V2E4E0nH+VrJxyjZg5opHjNMBLJx+z/zmFRccSnFWmOtW2en
	0D1eRQmKrQgsfuuGHnssWrJtN3o5l7dipYWOH126cFWVq1lmrB1IUpa3SfnJXAr7+BCcLA==
X-Google-Smtp-Source: AGHT+IFFzAQLESy+9XTrR371K4l9s8+Ug8zXVzf/oXiEIXCRNjxwSBTp4Oh3Iq6eaMxuwqzsZm0CFA==
X-Received: by 2002:a17:902:f64a:b0:223:5645:8e1a with SMTP id d9443c01a7336-2236926727dmr181629675ad.51.1740986137075;
        Sun, 02 Mar 2025 23:15:37 -0800 (PST)
Received: from [10.68.122.90] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050ce10sm71093955ad.200.2025.03.02.23.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 23:15:36 -0800 (PST)
Message-ID: <4eb93ca8-7526-4709-b43e-2ed9e5583e3b@bytedance.com>
Date: Mon, 3 Mar 2025 15:15:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] riscv: pgtable: unconditionally use
 tlb_remove_ptdesc()
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <9025595e895515515c95e48db54b29afa489c41d.1740454179.git.zhengqi.arch@bytedance.com>
 <CAEEQ3wnvgX=Bq=oAQV6wfg5a7H2jiG7f8P6trbC9agJ8D6t4pA@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAEEQ3wnvgX=Bq=oAQV6wfg5a7H2jiG7f8P6trbC9agJ8D6t4pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_231540_997781_63305647 
X-CRM114-Status: GOOD (  11.44  )
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



On 3/3/25 9:45 AM, yunhui cui wrote:
> Hi Qi,
> 

[...]

>>
>>
> 
> This set of patches mainly refactors the remove page table function
> interfaces. The comment "riscv_ipi_for_rfence" has been removed, as it
> was no longer needed, and this patch handles that.
> 
> Additionally, whether riscv_use_sbi_for_rfence is true or false, page
> tables can now be released using RCU. This patch changes the previous
> synchronous release logic (for !riscv_use_sbi_for_rfence) to an
> RCU-based release.
> 
> So, Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>
> 
> Based on qemu-system-riscv64, I tested this patch. The log is as follows:
> ./gup_test
> TAP version 13
> 1..1
> # GUP_FAST_BENCHMARK: Time: get:663365 put:117 us
> # ok 1 ioctl status 0
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Nice.

> 
> So, Tested-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thank you very much for your review and testing!

> 
> Thanks,
> Yunhui


