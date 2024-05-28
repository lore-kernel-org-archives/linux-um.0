Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9234BC25B78
	for <linux-um@archiver.kernel.org>; Tue, 28 May 2024 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQuCjQy+LMQrsYK/Izc2mNQbo4UCqcrZTudfpD3deGs=; b=uFQkjgoEESHuAcsNbnnshL9Qpz
	P9pdOVHRDmqgXcG6nE5Jf6otv0+2GzfrLXtldJ+6xEHPc7lGveob9C/iSGP2aLbT5AnEgcB7Dtr6L
	Gle6ZWyTl/i/y91075kH51YE9FPi2HTMBNT4YdMHOex317EdScan4zMtdTgrjZzmbVuPpeABR5S86
	eofuEinfNSVKICJu5xINw7o8uozaqRGDTQDwpYb6THamN1M8YbbwgpnBcOmlr3jk9EzVXdDvsROlX
	IVcoI4QmFxbX2hQZWH0kTXKACq3wRQhrmS/HlKSRmdgAN3jk8ofqm2MPZShJ8LQS0NZ1oAI2JTxJF
	9n1n5ohw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBucM-00000000ItK-23US;
	Tue, 28 May 2024 11:03:46 +0000
Received: from out0-220.mail.aliyun.com ([140.205.0.220])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBucH-00000000Is9-3R8q
	for linux-um@lists.infradead.org;
	Tue, 28 May 2024 11:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716894215; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iQuCjQy+LMQrsYK/Izc2mNQbo4UCqcrZTudfpD3deGs=;
	b=g48gsWRRVuJaRqcfjafnncdc+/PiRaXCF0sbb7YrKETRAf3zWGHZAGZkwdhm1XfHjmhkQqwsuXCw7k3ZmVng3GgjuekFL1Go/SHc6sInKsdIpId7ko3oraPcFQK00soZV6LO5cEe/vtaV1kM3bktE6gkxs+UtOPuUOQwzX7q1Uc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021176;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---.XpOY3GE_1716894202;
Received: from 30.230.92.133(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.XpOY3GE_1716894202)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 19:03:33 +0800
Message-ID: <616f41e1-4f02-4240-b298-8f611182c960@antgroup.com>
Date: Tue, 28 May 2024 19:03:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] um: Do a double clone to disable rseq
To: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org
References: <20240528085419.1964424-1-benjamin@sipsolutions.net>
 <20240528085419.1964424-4-benjamin@sipsolutions.net>
 <5f5505da-ba67-421e-b0f5-6a5c19955f27@antgroup.com>
 <388619aff5c8372998992a9f28fd7c71fb36eb51.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <388619aff5c8372998992a9f28fd7c71fb36eb51.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240528_040342_379557_966A2409 
X-CRM114-Status: GOOD (  25.91  )
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

Hi Benjamin,

On 5/28/24 6:30 PM, Benjamin Berg wrote:
> On Tue, 2024-05-28 at 18:16 +0800, Tiwei Bie wrote:
>> On 5/28/24 4:54 PM, benjamin@sipsolutions.net wrote:
>>> From: Benjamin Berg <benjamin.berg@intel.com>
>>>
>>> Newer glibc versions are enabling rseq support by default. This remains
>>> enabled in the cloned child process, potentially causing the host kernel
>>> to write/read memory in the child.
>>>
>>> It appears that this was purely not an issue because the used memory
>>> area happened to be above TASK_SIZE and remains mapped.
>>
>> I also encountered this issue. In my case, with "Force a static link"
>> (CONFIG_STATIC_LINK) enabled, UML will crash immediately every time
>> it starts up. I worked around this by setting the glibc.pthread.rseq
>> tunable via GLIBC_TUNABLES [1] before launching UML.
>>
>> So another easy way to work around this issue without introducing runtime
>> overhead might be to add the GLIBC_TUNABLES=glibc.pthread.rseq=0 environment
>> variable and exec /proc/self/exe in UML on startup.
> 
> I am not really worried about the overhead, but I agree that setting
> GLIBC_TUNABLES is also a reasonable solution to the problem.
> 
> Doing the memfd/execveat dance with an embedded static binary would
> still be best in my view, but either this or GLIBC_TUNABLES seem fine
> in the meantime.
> 
> Do you want to submit the patch? Should I re-roll the patchset with
> GLIBC_TUNABLES?

Thanks for asking! :)

I don't have such a patch at the moment. I worked around this issue
using a script. I saw that you are already doing execve("/proc/self/exe",
...) in PATCH 4/5. Please just feel free to re-roll the patchset with
GLIBC_TUNABLES if you would like to choose this solution.

Regards,
Tiwei


> 
> Benjamin
> 
>> [1] https://www.gnu.org/software/libc/manual/html_node/Tunables.html
>>
>> Regards,
>> Tiwei
>>
>>>
>>> Note that a better approach would be to exec a small static binary that
>>> does not link with other libraries. Using a memfd and execveat the
>>> binary could be embedded into UML itself and it would result in an
>>> entirely clean execution environment for userspace.
>>>
>>> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
>>> ---
>>>  arch/um/os-Linux/skas/process.c | 54 ++++++++++++++++++++++++++++++---
>>>  1 file changed, 50 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
>>> index 41a288dcfc34..ee332a2aeea6 100644
>>> --- a/arch/um/os-Linux/skas/process.c
>>> +++ b/arch/um/os-Linux/skas/process.c
>>> @@ -255,6 +255,31 @@ static int userspace_tramp(void *stack)
>>>  int userspace_pid[NR_CPUS];
>>>  int kill_userspace_mm[NR_CPUS];
>>>  
>>> +struct tramp_data {
>>> +	int pid;
>>> +	void *clone_sp;
>>> +	void *stack;
>>> +};
>>> +
>>> +static int userspace_tramp_clone_vm(void *data)
>>> +{
>>> +	struct tramp_data *tramp_data = data;
>>> +
>>> +	/*
>>> +	 * This helper exist to do a double-clone. First with CLONE_VM which
>>> +	 * effectively disables things like rseq, and then the second one to
>>> +	 * get a new memory space.
>>> +	 */
>>> +
>>> +	tramp_data->pid = clone(userspace_tramp, tramp_data->clone_sp,
>>> +				CLONE_PARENT | CLONE_FILES | SIGCHLD,
>>> +				tramp_data->stack);
>>> +	if (tramp_data->pid < 0)
>>> +		tramp_data->pid = -errno;
>>> +
>>> +	exit(0);
>>> +}
>>> +
>>>  /**
>>>   * start_userspace() - prepare a new userspace process
>>>   * @stub_stack:	pointer to the stub stack.
>>> @@ -268,9 +293,10 @@ int kill_userspace_mm[NR_CPUS];
>>>   */
>>>  int start_userspace(unsigned long stub_stack)
>>>  {
>>> +	struct tramp_data tramp_data;
>>>  	void *stack;
>>>  	unsigned long sp;
>>> -	int pid, status, n, flags, err;
>>> +	int pid, status, n, err;
>>>  
>>>  	/* setup a temporary stack page */
>>>  	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
>>> @@ -286,10 +312,13 @@ int start_userspace(unsigned long stub_stack)
>>>  	/* set stack pointer to the end of the stack page, so it can grow downwards */
>>>  	sp = (unsigned long)stack + UM_KERN_PAGE_SIZE;
>>>  
>>> -	flags = CLONE_FILES | SIGCHLD;
>>> +	tramp_data.stack = (void *) stub_stack;
>>> +	tramp_data.clone_sp = (void *) sp;
>>> +	tramp_data.pid = -EINVAL;
>>>  
>>>  	/* clone into new userspace process */
>>> -	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
>>> +	pid = clone(userspace_tramp_clone_vm, (void *) sp,
>>> +		    CLONE_VM | CLONE_FILES | SIGCHLD, &tramp_data);
>>>  	if (pid < 0) {
>>>  		err = -errno;
>>>  		printk(UM_KERN_ERR "%s : clone failed, errno = %d\n",
>>> @@ -305,7 +334,24 @@ int start_userspace(unsigned long stub_stack)
>>>  			       __func__, errno);
>>>  			goto out_kill;
>>>  		}
>>> -	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
>>> +	} while (!WIFEXITED(status));
>>> +
>>> +	pid = tramp_data.pid;
>>> +	if (pid < 0) {
>>> +		printk(UM_KERN_ERR "%s : second clone failed, errno = %d\n",
>>> +		       __func__, -pid);
>>> +		return pid;
>>> +	}
>>> +
>>> +	do {
>>> +		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
>>> +		if (n < 0) {
>>> +			err = -errno;
>>> +			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
>>> +			       __func__, errno);
>>> +			goto out_kill;
>>> +		}
>>> +	} while (WIFEXITED(status) && (WSTOPSIG(status) == SIGALRM));
>>>  
>>>  	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
>>>  		err = -EINVAL;
>>
>>


