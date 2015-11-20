Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <aivanov@Brocade.com>) id 1ZzqAh-0006Zk-C0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 18:12:31 +0000
Received: from mx0a-000f0801.pphosted.com ([67.231.144.122])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZzqAg-0004GF-Ii
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Nov 2015 18:12:31 +0000
Received: from pps.filterd (m0048193.ppops.net [127.0.0.1])
	by mx0a-000f0801.pphosted.com (8.15.0.59/8.15.0.59) with SMTP id
	tAKHxfCZ032233 for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Nov 2015 10:12:24 -0800
Received: from brmwp-exmb11.corp.brocade.com ([208.47.132.227])
	by mx0a-000f0801.pphosted.com with ESMTP id 1ya75x06wc-1
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 20 Nov 2015 10:12:24 -0800
From: Anton Ivanov <aivanov@Brocade.com>
Date: Fri, 20 Nov 2015 18:12:21 +0000
Message-ID: <564F6285.8020200@brocade.com>
References: <1448037915-921549-1-git-send-email-aivanov@brocade.com>
	<1448037915-921549-2-git-send-email-aivanov@brocade.com>
In-Reply-To: <1448037915-921549-2-git-send-email-aivanov@brocade.com>
Content-Language: en-US
Content-ID: <D430533861705648A35DD9286C1FC1ED@brocade.local>
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/3] Errata: HR Timer subsystem
To: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

This one came up with a messed up formatting, I will resubmit at some 
point (hopefully as we refine this).

A.

On 20/11/15 16:45, Anton Ivanov wrote:
> The signals should be restored to their pre-off state
> not turned on.
>
> Signed-off-by: Anton Ivanov <aivanov@brocade.com>
> ---
>   arch/um/kernel/skas/mmu.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> index 9591a66..a845de6 100644
> --- a/arch/um/kernel/skas/mmu.c
> +++ b/arch/um/kernel/skas/mmu.c
> @@ -53,6 +53,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>   	struct mm_context *to_mm = &mm->context;
>   	unsigned long stack = 0;
>   	int ret = -ENOMEM;
> +    unsigned long int flags;
>   
>   	stack = get_zeroed_page(GFP_KERNEL);
>   	if (stack == 0)
> @@ -62,12 +63,12 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>   	if (current->mm != NULL && current->mm != &init_mm)
>   		from_mm = &current->mm->context;
>   
> -	block_signals();
> +	local_irq_save(flags);
>   	if (from_mm)
>   		to_mm->id.u.pid = copy_context_skas0(stack,
>   						     from_mm->id.u.pid);
>   	else to_mm->id.u.pid = start_userspace(stack);
> -	unblock_signals();
> +    local_irq_restore(flags);
>   
>   	if (to_mm->id.u.pid < 0) {
>   		ret = to_mm->id.u.pid;

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

