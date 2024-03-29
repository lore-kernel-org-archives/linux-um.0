Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4ECFC6FD1F
	for <linux-um@archiver.kernel.org>; Fri, 29 Mar 2024 04:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjyFrTWiuSDbqffCtgabiwtFrJl0nn6TPVE2ErBhTuc=; b=Mnnms2QYc3DPAKTzpTNe7MGQNn
	JhOMv33RQ0IB0AIRqFRNhJy2fu7DJ0Bp36/ZULEYdIN2qBSxxwFPZ+IngXcWOdvAmh7IiwDh7tahn
	INEaK1GsVynlLKb3BCGXC7/SXp2aLplIr7UcNdCLxoot5DWEZ6SpdDpEeS/Z5T+IMKy++iBjskIqT
	zJ8U5AEmxq8uR0eIQXrl8rkIGmg/PAxQu5egP+YkjB6uS0PNM/l6mdtv6lyQLyxJyTU9lZ8qO18bi
	pSQ3FycOqI4QUrCK6VKWbCbjO7gg2OBqkRrjGl10fx/OWsdi6O8q4s+vhEFXMR0gzi67FlfJxP58N
	p44vn4bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq3jH-0000000Gkha-0nWa;
	Fri, 29 Mar 2024 04:20:35 +0000
Received: from out0-211.mail.aliyun.com ([140.205.0.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq3jC-0000000Gkfk-3rjH
	for linux-um@lists.infradead.org;
	Fri, 29 Mar 2024 04:20:33 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047208;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.Wz6JxcY_1711686014;
Received: from 30.230.92.186(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.Wz6JxcY_1711686014)
          by smtp.aliyun-inc.com;
          Fri, 29 Mar 2024 12:20:20 +0800
Message-ID: <57825fac-d4d1-4f8e-acb8-f2e8af95bd5c@antgroup.com>
Date: Fri, 29 Mar 2024 12:20:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] um: signal: move pid variable where needed
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240328100640.d3ffb37dc64b.I2e2e713d6a78ea24e6508db9d3ef2882b88861da@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_212031_199098_58768260 
X-CRM114-Status: GOOD (  15.56  )
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

On 3/28/24 5:06 PM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> We have W=1 warnings on 64-bit because the pid is only
> used in branches on 32-bit; move it inside to get rid of
> the warnings.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/x86/um/signal.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/um/signal.c b/arch/x86/um/signal.c
> index 263e1d08f216..16ff097e790d 100644
> --- a/arch/x86/um/signal.c
> +++ b/arch/x86/um/signal.c
> @@ -155,7 +155,7 @@ static int copy_sc_from_user(struct pt_regs *regs,
>  			     struct sigcontext __user *from)
>  {
>  	struct sigcontext sc;
> -	int err, pid;
> +	int err;
>  
>  	/* Always make any pending restarted system calls return -EINTR */
>  	current->restart_block.fn = do_no_restart_syscall;
> @@ -201,10 +201,10 @@ static int copy_sc_from_user(struct pt_regs *regs,
>  
>  #undef GETREG
>  
> -	pid = userspace_pid[current_thread_info()->cpu];
>  #ifdef CONFIG_X86_32
>  	if (have_fpx_regs) {
>  		struct user_fxsr_struct fpx;
> +		int pid = userspace_pid[current_thread_info()->cpu];

Tiny nit: might be better to move it before "struct user_fxsr_struct fpx;".
And it will be more consistent with the other change in this patch. :)

>  
>  		err = copy_from_user(&fpx,
>  			&((struct _fpstate __user *)sc.fpstate)->_fxsr_env[0],
> @@ -240,7 +240,7 @@ static int copy_sc_to_user(struct sigcontext __user *to,
>  {
>  	struct sigcontext sc;
>  	struct faultinfo * fi = &current->thread.arch.faultinfo;
> -	int err, pid;
> +	int err;
>  	memset(&sc, 0, sizeof(struct sigcontext));
>  
>  #define PUTREG(regno, regname) sc.regname = regs->regs.gp[HOST_##regno]
> @@ -288,10 +288,9 @@ static int copy_sc_to_user(struct sigcontext __user *to,
>  	if (err)
>  		return 1;
>  
> -	pid = userspace_pid[current_thread_info()->cpu];
> -
>  #ifdef CONFIG_X86_32
>  	if (have_fpx_regs) {
> +		int pid = userspace_pid[current_thread_info()->cpu];
>  		struct user_fxsr_struct fpx;
>  
>  		err = save_fpx_registers(pid, (unsigned long *) &fpx);

For the series, feel free to add my Reviewed-by: Tiwei Bie <tiwei.btw@antgroup.com>

Regards,
Tiwei

