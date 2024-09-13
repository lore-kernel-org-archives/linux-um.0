Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500FEEEE27F
	for <linux-um@archiver.kernel.org>; Fri, 13 Sep 2024 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HWH9M4UJqrJf3rT0idbSbbMprE/6p0CH3pO9dW+PNd8=; b=AvIWt1zqn1770llHdbr8pVAGK1
	zjSHfLCcdfsjWkh4Gsa8FyX+ewtHs5kU3E6ftQ6BVMV1tCEi26kGR+FlrHfeZBMtDaHutvkmk1+cE
	mHqnXsXguZX0LQ85FsR1GrMZsjsl8LOcFRXhZ5yJ5kKrm3IiW/YhdKs0X9JfsQ+qh9Bgan0DHajnW
	6l1Ptq8CGiQpvLp7g8XwkzuOKWFjtu9Z1yBYfMwQp0Q2EvKheQJX1PxXbD3lNvUXRypYf7NLr6XrJ
	Tgj6n2hXN76E/BFVERBnZlSsCMGkb/Nhwa2Le9wue/53v1rDGhKTJJUT5n/SVGeJjnbfvRTVpQWRZ
	YX0B3wTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovv5-0000000EjDD-3rJX;
	Fri, 13 Sep 2024 02:20:23 +0000
Received: from out0-199.mail.aliyun.com ([140.205.0.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovv2-0000000EjCS-36TQ
	for linux-um@lists.infradead.org;
	Fri, 13 Sep 2024 02:20:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726194014; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HWH9M4UJqrJf3rT0idbSbbMprE/6p0CH3pO9dW+PNd8=;
	b=mvp+liqyNA9VKc7kRgZk4QdXm6670lrm+Ggou27xB2/QDKn+tEY6af8Ag1GhH7P8NslwQEP4qXu3R6C/NT51UGILNwW7FaBK+Lz5jXM1VCSQjwpd1DBYagAaHQJImkfvL5qfAkvhQOikIYOCeaxRxXuPkaV8F7fM/CA7mGXLOD4=
Received: from 30.230.92.212(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZHr0TbG_1726194006)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 10:20:13 +0800
Message-ID: <e259385a-ddc5-4c93-9251-395cd1c44429@antgroup.com>
Date: Fri, 13 Sep 2024 10:20:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
To: Richard Weinberger <richard@nod.at>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
 <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_192021_299851_C9912366 
X-CRM114-Status: GOOD (  10.65  )
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

On 2024/9/13 02:51, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> Von: "Tiwei Bie" <tiwei.btw@antgroup.com>
>> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegreys.com>, "Johannes Berg"
>> <johannes@sipsolutions.net>
>> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Tiwei Bie"
>> <tiwei.btw@antgroup.com>
>> Gesendet: Mittwoch, 28. August 2024 15:51:40
>> Betreff: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
> 
>> This function is expected to return a boolean value, which should be
>> true on success and false on failure.
>>
>> Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>> arch/um/kernel/process.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
>> index be2856af6d4c..3cc2b663aa78 100644
>> --- a/arch/um/kernel/process.c
>> +++ b/arch/um/kernel/process.c
>> @@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
>> int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
>> {
>> 	int cpu = current_thread_info()->cpu;
>> +	int pid = userspace_pid[cpu];
>>
>> -	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
>> +	return save_i387_registers(pid, (unsigned long *) fpu) == 0;
> 
> Why a new local variable?

Thanks for the review! The new variable isn't necessary for the fix.
Will drop it to make the fix more straightforward.

Regards,
Tiwei

