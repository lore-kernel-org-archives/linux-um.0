Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIBAB-00FEvB-B7
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 14:10:46 +0000
Subject: Re: [PATCH v4 3/9] um: remove unused smp_sigio_handler() declaration
References: <20210305122010.442577-1-johannes@sipsolutions.net>
 <20210305131934.159de8b94c36.I479aba3ebfb7a6418255b7a51c5c2cfe3796e9a2@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f97f8671-e4ac-ee84-4ed3-b5c142d0f30d@cambridgegreys.com>
Date: Fri, 5 Mar 2021 14:10:36 +0000
MIME-Version: 1.0
In-Reply-To: <20210305131934.159de8b94c36.I479aba3ebfb7a6418255b7a51c5c2cfe3796e9a2@changeid>
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



On 05/03/2021 12:19, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This function doesn't exist, remove its declaration.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/include/shared/kern_util.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
> index 2888ec812f6e..a2cfd42608a0 100644
> --- a/arch/um/include/shared/kern_util.h
> +++ b/arch/um/include/shared/kern_util.h
> @@ -33,7 +33,6 @@ extern int handle_page_fault(unsigned long address, unsigned long ip,
>   			     int is_write, int is_user, int *code_out);
>   
>   extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
> -extern int smp_sigio_handler(void);
>   extern void initial_thread_cb(void (*proc)(void *), void *arg);
>   extern int is_syscall(unsigned long addr);
>   
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

