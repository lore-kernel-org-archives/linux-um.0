Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOeWN-0008AM-4P
 for linux-um@lists.infradead.org; Wed, 15 Apr 2020 09:39:52 +0000
Subject: Re: [PATCH] um: syscall.c: include <asm/unistd.h>
References: <20200415095152.85794f817f97.I289cb72f130c19e850d70eacca9e68eb84832600@changeid>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <b7157cb3-ee7d-ac91-c755-ace63d617460@kot-begemot.co.uk>
Date: Wed, 15 Apr 2020 10:39:37 +0100
MIME-Version: 1.0
In-Reply-To: <20200415095152.85794f817f97.I289cb72f130c19e850d70eacca9e68eb84832600@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 15/04/2020 08:51, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Without CONFIG_SECCOMP, we don't get this include recursively
> through the existing includes, thus failing the build on not
> having __NR_syscall_max defined. Add the necessary include to
> fix this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/skas/syscall.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
> index 0a12d5a09217..3d91f89fd852 100644
> --- a/arch/um/kernel/skas/syscall.c
> +++ b/arch/um/kernel/skas/syscall.c
> @@ -11,6 +11,7 @@
>   #include <sysdep/ptrace_user.h>
>   #include <sysdep/syscalls.h>
>   #include <linux/time-internal.h>
> +#include <asm/unistd.h>
>   
>   void handle_syscall(struct uml_pt_regs *r)
>   {
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

