Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4640C5B543
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 04:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WY6E+zduU4vx3u9nR9eNzIX152kjLRnHhlhvHYK9bkU=; b=il670dgw/A/2JS71kIuEclv99n
	ClrhJwhKEVC7JdpmhgSIGw91ECGghk1qYgNEGia5CPAQuEUuYLLIG0MGxOhq5c/IBbiTQUt+D34tt
	ZI0vXDltgBYqFkfMvxidRFch6nHQBop7M7OiSSSLsH42Ek5LhggLDc7BZmzHk5fgr6MAP7tTBsaqQ
	SXMseVSRCyGF54q9BhT+4wZZ3DJL1whdZalKlUIfsA/YO1I0tmaDv8burzGV79IDI6H27F1//53sB
	GDBwVNzfXWAcD6dZdXmHayXaX1YoDHdkVY8mcB+0VxPuHSfGihi2wm5pf2IEQdEgx1IbuCptWDtvM
	znANuJ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNl5C-00000001JOy-2CMg;
	Sat, 07 Jun 2025 04:23:02 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNl5A-00000001JOb-0anc
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 04:23:01 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-313154270bbso2865375a91.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 21:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749270179; x=1749874979; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WY6E+zduU4vx3u9nR9eNzIX152kjLRnHhlhvHYK9bkU=;
        b=AnAnkjiaM3pPZK77cxi+OrJKydq1G98m/VwMMkvnsaH4C6ReDu1U1K4sVFaiI6/LE6
         FIL8wD9j87LU/eVCDNn9jUxzgROWtACieYctH1UMrScgzDzB25WXeb+M6jWlS0KI/N/b
         +8b6PgAr45gr1wkmG5s1cs/nZnmEyXTAPUlUI2zHI98jkd1Fym9dFsh8nkjS18htg+xy
         XBxwbfEOtDPEZeHvn6pqQBZduQuvxfKyWEYYaxo7heKxtD7BEqCpPOYdEydPU09KbWED
         dAlx3T+5XVslI5Lt568h3rNecjUr7n0Dff9zWIs00D8JH2XJ276Gm5PGhKswZMGw1MXz
         g2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749270179; x=1749874979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WY6E+zduU4vx3u9nR9eNzIX152kjLRnHhlhvHYK9bkU=;
        b=keaJADA3l4v5xZFo/A5s6zAVAO4j28G829yEM/z9wqeaWpjtQAFWatkpUPZkI4oLML
         2uQtxcawg0H02CH9WaXsFS4zPMft4SXUFOFFjZy3I0upOFkp6qd9AGk7R1rKoMd9W2fd
         r+WQPcwfUmYEqVMtxGNvfdGNEDUmrKw25KvoWpRGZe1eqlrbeNFBYgwuj0wnlscwVTpA
         JewqYexDiCVjfDsLo5gQ9KwkbEG430+I2ShD4imU/z6QgRHROZVca7kKsezeSqPz+eKV
         ipsUKVFFILkyyVY42HKWonJxbf98r+cQe8eIWxqEYsYj/WCZRI4obB/tJfohXIOET7yN
         V6pw==
X-Forwarded-Encrypted: i=1; AJvYcCWf2nkcib9w2++eEiirzuhQ8XRYtU1I8i/Aa3pVY7HZ1xfB/6zmjiKUTUQnX3nroda8rN8E1FXQUQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNiOJltgdmN/1nRAcZqqcwITtT004FFuGGOEnjLkw+3/6RwBAA
	8qrFzbNHXLd76u5ERprzpZdCSco26RQ+z/MnLhQPpopt7JB1Ggfy6Psf
X-Gm-Gg: ASbGncvQzyqXExy/niqNX8xl1FbHZcfQ+tgBrYHzL/r3wPZmtyphpkWFue5En7SAWQt
	myOZwUWs15FrVfirzRdzZ9OxmLXwbXDs5SuZpEf+MsNs39GDkckG2iFBPJbbQw7mumpKQxUg/PZ
	oYbJuND+J+SfdMLy7NvOyafcYRRwTYnu7SQW1h/gW+wO3OaUiPZxAT82CPAemFLM/K4utEo4EXo
	3WTJwN9WLvaGCoYeZYRFb5IumQpkiNlHSHdw13FL1yrCdX8PyYBfrRTY/Bz6t2+Tsdmr912ohn/
	qxaqf8PZhlJUvj6ceuC6g1vwFa94zR8VsQE+/Jjba4Jna4sgf3/aIinyvY1fjAdcY2B8V8kbl3q
	4Aqf4OEEHJujH4V2n
X-Google-Smtp-Source: AGHT+IFI0vda4xVwTcBATzfW4g+XC+JUI6XpRkBNXgb52PNdbStiezMWS4PTJtaoR+HGMLJfeYmwbQ==
X-Received: by 2002:a17:90b:57cb:b0:312:959:dc4d with SMTP id 98e67ed59e1d1-313472c062bmr9340866a91.7.1749270178558;
        Fri, 06 Jun 2025 21:22:58 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([240e:3b1:36e2:a421:c453:d067:b47a:6e72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31349ff7e14sm2312063a91.45.2025.06.06.21.22.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Jun 2025 21:22:58 -0700 (PDT)
From: Yonting Lin <linyongting@gmail.com>
To: development@efficientek.com
Cc: benjamin.berg@intel.com,
	benjamin@sipsolutions.net,
	linux-um@lists.infradead.org,
	linyongting@gmail.com
Subject: Re: [PATCH] um: fix execve stub execution on old host OSs
Date: Sat,  7 Jun 2025 12:22:48 +0800
Message-Id: <20250607042248.87877-1-linyongting@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
References: <20250112140736.1fcb25c3@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_212300_204566_08B6E9E3 
X-CRM114-Status: GOOD (  28.03  )
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

Hi Glenn,

Sun, 12 Jan 2025 14:07:36 -0600
Glenn Washburn <development@efficientek.com> wrote:
>On Fri, 10 Jan 2025 17:13:05 +0100
>Benjamin Berg <benjamin@sipsolutions.net> wrote:
>
>> From: Benjamin Berg <benjamin.berg@intel.com>
>> 
>> The stub execution uses the somewhat new close_range and execveat
>> syscalls. Of these two, the execveat call is essential, but the
>> close_range call is more about stub process hygiene rather than safety
>> (and its result is ignored).
>> 
>> Replace both calls with a raw syscall as older machines might not have a
>> recent enough kernel for close_range (with CLOSE_RANGE_CLOEXEC) or a
>> libc that does not yet expose both of the syscalls.
>> 
>> Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
>
>This change fixes the immediate issue, allowing the compile to complete
>successfully.
>
>> Reported-by: Glenn Washburn <development@efficientek.com>
>> Closes: https://lore.kernel.org/20250108022404.05e0de1e@crass-HP-ZBook-15-G2
>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>> ---
>>  arch/um/os-Linux/skas/process.c | 16 +++++++++++++---
>>  1 file changed, 13 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
>> index f683cfc9e51a..64e89921bc7f 100644
>> --- a/arch/um/os-Linux/skas/process.c
>> +++ b/arch/um/os-Linux/skas/process.c
>> @@ -181,6 +181,10 @@ extern char __syscall_stub_start[];
>>  
>>  static int stub_exe_fd;
>>  
>> +#ifndef CLOSE_RANGE_CLOEXEC
>> +#define CLOSE_RANGE_CLOEXEC	(1U << 2)
>> +#endif
>> +
>>  static int userspace_tramp(void *stack)
>>  {
>>  	char *const argv[] = { "uml-userspace", NULL };
>> @@ -202,8 +206,12 @@ static int userspace_tramp(void *stack)
>>  	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
>>  	init_data.stub_data_offset = MMAP_OFFSET(offset);
>>  
>> -	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
>> -	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
>> +	/*
>> +	 * Avoid leaking unneeded FDs to the stub by setting CLOEXEC on all FDs
>> +	 * and then unsetting it on all memory related FDs.
>> +	 * This is not strictly necessary from a safety perspective.
>> +	 */
>> +	syscall(__NR_close_range, 1, ~0U, CLOSE_RANGE_CLOEXEC);
>
>Was this intentional to change the fd parameter from 0 to 1?
>
>>  
>>  	fcntl(init_data.stub_data_fd, F_SETFD, 0);
>>  	for (iomem = iomem_regions; iomem; iomem = iomem->next)
>> @@ -224,7 +232,9 @@ static int userspace_tramp(void *stack)
>>  	if (ret != sizeof(init_data))
>>  		exit(4);
>>  
>> -	execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
>> +	/* Raw execveat for compatibility with older libc versions */
>> +	syscall(__NR_execveat, stub_exe_fd, (unsigned long)"",
>> +		(unsigned long)argv, NULL, AT_EMPTY_PATH);
>
>I think it would look nicer to leave the call unchanged and define a stub
>function like libc does, but only if we detect that the stubs are
>undefined. I have a glibc specific patch for this, and then realized
>that it should be more generic to cover other libcs. So this patch here
>is more general. I think to have what I'd like, I'd need to add and run
>a test binaries that check for these functions, like autotools does.
>I'm not aware that this is really done in the kernel build system,
>though I do know that there are binaries built during build for
>generating binaries to be included in the kernel. So in theory I don't
>think it should be too much trouble to do. Basically the idea would be
>to have a system for testing host libc and outputting a config.h which
>will define for instance, HAVE_EXECVEAT, if support is detected in the
>linked libc for execveat. And in process.c define a stub around the
>syscall() for execveat if not defined HAVE_EXECVEAT.
>
>So perhaps for now, this is the best solution, but ultimately it would
>be nice to have the above and ultimately reverse these changes.

Sorry for my due enquiry, I don't want take a new thread with a patch.
It is just a short question.

Currently(119b1e61a769aa98e68599f44721661a4d8c55f3), there are three pieces
of code calling to syscall __NR_close_range:

# grep __NR_close_range -r arch/um/* -n
arch/um/kernel/skas/stub_exe.c:73:		res = stub_syscall3(__NR_close_range, 1, ~0U, 0);
arch/um/os-Linux/start_up.c:269:	if (stub_syscall3(__NR_close_range, 1, ~0U, 0))
arch/um/os-Linux/skas/process.c:331:	syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);

But my host kernel is 5.4 and fails to compile these pieces of codes because
there is no this syscall in my older kernel.

I was wondering if you are working on this issue. If not, I will try to 
make a draft solution to review.

Thanks!
Yongting
>
>Glenn
>
>  
>>  	exit(5);
>>  }

