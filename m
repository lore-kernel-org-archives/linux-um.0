Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3B7C25B78
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3y0rd2CnUNU+u2MqfrobZKeM8+VxIWWtCzpKyZI905g=; b=eWabeNuAsLKDGW70ZmvHHGsIkI
	QOkrYfo8WrBhoeNXaIqr3UZMigR0rbBc/CljmK3lvNj8A7HBxZ/AK1yXnkmbwQPU/jPmV+HeEI+pt
	OsInlSjSVEqDub36J1jImWKqhtUaGi6R+QhT+LF7leBKRl2g2Ab8Qc3hNEewqdJLtK79NB+39LQ5l
	tdGSEafoqfwIxBKX9NIW7Ihdq4kJYKO7NVw7tRzPfPTcNzDZiIGIAA45/CmnAzhcE21m+R61JEHGt
	uy7BBPsgxeaz3S5i29nQDP2qGXwtlfUtvltZfXXNf+XiAYckCqJtplUkkDaeyhvuLJT5hZ/n/812Z
	vDN+hs9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBtt6-00000000BDv-44zA;
	Tue, 28 May 2024 10:17:00 +0000
Received: from out0-204.mail.aliyun.com ([140.205.0.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBtt3-00000000BB5-0JZ4
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 10:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716891412; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3y0rd2CnUNU+u2MqfrobZKeM8+VxIWWtCzpKyZI905g=;
	b=EVS9UItOJq2dyNA5VdbNplfsnvYKIaX9OWiyI7deNyG0t6SbgVqpUdmjsOOG+WAG3qJ3gtANVOysNuIAXFUMOAzXp72ou2qOefKO3wrf1L2qTkwFzsAY1zKfKsWFmAOq7phENhZnXp2bOu8zGOHh4/4nG84YtMKo0Gygjt6suBU=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021168;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---.XpPN8H2_1716891398;
Received: from 30.230.92.133(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XpPN8H2_1716891398)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 18:16:48 +0800
Message-ID: <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
Date: Tue, 28 May 2024 18:16:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
To: benjamin@sipsolutions.net, linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-4-benjamin@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20240528085419.1964424-4-benjamin@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_031657_635427_A6FB9D40 
X-CRM114-Status: GOOD (  25.47  )
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

On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> Newer glibc versions are enabling rseq support by default. This remains
> enabled in the cloned child process, potentially causing the host kernel
> to write/read memory in the child.
> 
> It appears that this was purely not an issue because the used memory
> area happened to be above TASK_SIZE and remains mapped.

I also encountered this issue. In my case, with "Force a static link"
(CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
it starts up. I worked around this by setting the glibc.pthread.rseq
tunable via GLIBC_TUNABLES [1] before launching UML.

So another easy way to work around this issue without introducing runtime
overhead might be to add the GLIBC_TUNABLES=glibc.pthread.rseq=0 environment
variable and exec /proc/self/exe in UML on startup.

[1] https://www.gnu.org/software/libc/manual/html_node/Tunables.html

Regards,
Tiwei

> 
> Note that a better approach would be to exec a small static binary that
> does not link with other libraries. Using a memfd and execveat the
> binary could be embedded into UML itself and it would result in an
> entirely clean execution environment for userspace.
> 
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> ---
>  arch/um/os-Linux/skas/process.c | 54 ++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 41a288dcfc34..ee332a2aeea6 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -255,6 +255,31 @@ static int userspace_tramp(void *stack)
>  int userspace_pid[NR_CPUS];
>  int kill_userspace_mm[NR_CPUS];
>  
> +struct tramp_data {
> +	int pid;
> +	void *clone_sp;
> +	void *stack;
> +};
> +
> +static int userspace_tramp_clone_vm(void *data)
> +{
> +	struct tramp_data *tramp_data = data;
> +
> +	/*
> +	 * This helper exist to do a double-clone. First with CLONE_VM which
> +	 * effectively disables things like rseq, and then the second one to
> +	 * get a new memory space.
> +	 */
> +
> +	tramp_data->pid = clone(userspace_tramp, tramp_data->clone_sp,
> +				CLONE_PARENT | CLONE_FILES | SIGCHLD,
> +				tramp_data->stack);
> +	if (tramp_data->pid < 0)
> +		tramp_data->pid = -errno;
> +
> +	exit(0);
> +}
> +
>  /**
>   * start_userspace() - prepare a new userspace process
>   * @stub_stack:	pointer to the stub stack.
> @@ -268,9 +293,10 @@ int kill_userspace_mm[NR_CPUS];
>   */
>  int start_userspace(unsigned long stub_stack)
>  {
> +	struct tramp_data tramp_data;
>  	void *stack;
>  	unsigned long sp;
> -	int pid, status, n, flags, err;
> +	int pid, status, n, err;
>  
>  	/* setup a temporary stack page */
>  	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
> @@ -286,10 +312,13 @@ int start_userspace(unsigned long stub_stack)
>  	/* set stack pointer to the end of the stack page, so it can grow downwards */
>  	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
>  
> -	flags = CLONE_FILES | SIGCHLD;
> +	tramp_data.stack = (void *) stub_stack;
> +	tramp_data.clone_sp = (void *) sp;
> +	tramp_data.pid = -EINVAL;
>  
>  	/* clone into new userspace process */
> -	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
> +	pid = clone(userspace_tramp_clone_vm, (void *) sp,
> +		    CLONE_VM | CLONE_FILES | SIGCHLD, &tramp_data);
>  	if (pid < 0) {
>  		err = -errno;
>  		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
> @@ -305,7 +334,24 @@ int start_userspace(unsigned long stub_stack)
>  			       __func__, errno);
>  			goto out_kill;
>  		}
> -	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
> +	} while (!WIFEXITED(status));
> +
> +	pid = tramp_data.pid;
> +	if (pid < 0) {
> +		printk(UM_KERN_ERR "%s : second clone failed, errno = %d\n",
> +		       __func__, -pid);
> +		return pid;
> +	}
> +
> +	do {
> +		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
> +		if (n < 0) {
> +			err = -errno;
> +			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
> +			       __func__, errno);
> +			goto out_kill;
> +		}
> +	} while (WIFEXITED(status) && (WSTOPSIG(status) == SIGALRM));
>  
>  	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
>  		err = -EINVAL;


