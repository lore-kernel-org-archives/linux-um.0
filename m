Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bharrosh@panasas.com>) id 1SCM1Q-0008Nz-F8
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2012 02:20:32 +0000
Received: from natasha.panasas.com ([67.152.220.90])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SCM1O-0002la-12 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2012 02:20:32 +0000
Message-ID: <4F7123E1.6080804@panasas.com>
Date: Mon, 26 Mar 2012 19:20:17 -0700
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
References: <4F71236E.6040400@panasas.com>
In-Reply-To: <4F71236E.6040400@panasas.com>
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
Subject: Re: [uml-devel] [PATCH ] um: uml_setup_stubs': warning: unused
 variable 'pages'
To: Richard Weinberger <richard@nod.at>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On 03/26/2012 07:18 PM, Boaz Harrosh wrote:

> 
> Fix the following gcc complain
> arch/um/kernel/skas/mmu.c: In function 'uml_setup_stubs':
> arch/um/kernel/skas/mmu.c:106:16: warning: unused variable 'pages' [-Wunused-variable]
> 


I get this on today's linus tree. If a fix is already queued please ignore

Thanks
Boaz

> Signed-Signed-off-by: Boaz Harrosh <bharrosh@panasas.com>
> ---
>  arch/um/kernel/skas/mmu.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
> index 4947b31..0a49ef0 100644
> --- a/arch/um/kernel/skas/mmu.c
> +++ b/arch/um/kernel/skas/mmu.c
> @@ -103,7 +103,6 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
>  
>  void uml_setup_stubs(struct mm_struct *mm)
>  {
> -	struct page **pages;
>  	int err, ret;
>  
>  	if (!skas_needs_stub)



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

