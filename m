Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <63b95279-8013-078d-b84b-716b3dbfbac4@infradead.org>
Date: Fri, 26 Aug 2022 13:36:58 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] um: Cleanup compiler warning in arch/x86/um/tls_32.c
Content-Language: en-US
References: <20220826152931.5835fdf8@gecko>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220826152931.5835fdf8@gecko>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Lukas Straub <lukasstraub2@web.de>, linux-um <linux-um@lists.infradead.org>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org, linux-kernel@vger.kernel.org



On 8/26/22 08:29, Lukas Straub wrote:
> arch.tls_array is statically allocated so checking for NULL doesn't
> make sense. This causes the compiler warning below.
> 
> Remove the checks to silence these warnings.
> 
> ../arch/x86/um/tls_32.c: In function 'get_free_idx':
> ../arch/x86/um/tls_32.c:68:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
>    68 |         if (!t->arch.tls_array)
>       |             ^
> In file included from ../arch/x86/um/asm/processor.h:10,
>                  from ../include/linux/rcupdate.h:30,
>                  from ../include/linux/rculist.h:11,
>                  from ../include/linux/pid.h:5,
>                  from ../include/linux/sched.h:14,
>                  from ../arch/x86/um/tls_32.c:7:
> ../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
>    22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
>       |                               ^~~~~~~~~
> ../arch/x86/um/tls_32.c: In function 'get_tls_entry':
> ../arch/x86/um/tls_32.c:243:13: warning: the comparison will always evaluate as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
>   243 |         if (!t->arch.tls_array)
>       |             ^
> ../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
>    22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
>       |                               ^~~~~~~~~
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  arch/x86/um/tls_32.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
> index ac8eee093f9c..66162eafd8e8 100644
> --- a/arch/x86/um/tls_32.c
> +++ b/arch/x86/um/tls_32.c
> @@ -65,9 +65,6 @@ static int get_free_idx(struct task_struct* task)
>  	struct thread_struct *t = &task->thread;
>  	int idx;
>  
> -	if (!t->arch.tls_array)
> -		return GDT_ENTRY_TLS_MIN;
> -
>  	for (idx = 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
>  		if (!t->arch.tls_array[idx].present)
>  			return idx + GDT_ENTRY_TLS_MIN;
> @@ -240,9 +237,6 @@ static int get_tls_entry(struct task_struct *task, struct user_desc *info,
>  {
>  	struct thread_struct *t = &task->thread;
>  
> -	if (!t->arch.tls_array)
> -		goto clear;
> -
>  	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
>  		return -EINVAL;
>  

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

