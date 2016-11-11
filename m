Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1c59Ar-0003ZR-Hg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2016 10:35:09 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c59Aq-0004hj-2r
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 11 Nov 2016 10:35:09 +0000
References: <20161110015326.GA51351@juliacomputing.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <81f0fb21-e336-ed4c-4346-5f54836f5d8c@nod.at>
Date: Fri, 11 Nov 2016 11:34:59 +0100
MIME-Version: 1.0
In-Reply-To: <20161110015326.GA51351@juliacomputing.com>
Subject: Re: [uml-devel] [PATCH] um: Fix compile failure due to
 current_text_address() definition
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
To: Keno Fischer <keno@juliacomputing.com>, linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, user-mode-linux-devel@lists.sourceforge.net

Keno,

On 10.11.2016 02:53, Keno Fischer wrote:
> Fixes the following link error:
> ```
> /usr/bin/ld: net/built-in.o: relocation R_X86_64_32S against `.text'
> can not be used when making a shared object; recompile with -fPIC
> ```

How and where do you trigger this?
I had a chat with Sebastian and we are not 100% sure what is going on.
On my freshly installed Debian sid with gcc version 6.2.0 20161109 (Debian 6.2.0-13)
UML builds fine except when I set CONFIG_STATIC_LINK=y

But then I'm facing a slightly different error:
  CC      init/version.o
  LD      init/built-in.o
/usr/bin/ld: init/built-in.o: relocation R_X86_64_PLTOFF64 against STT_GNU_IFUNC symbol `memmove' isn't supported
/usr/bin/ld: final link failed: Bad value
collect2: error: ld returned 1 exit status

Your patch also does not cure this. I'll investigate later into that.

> This is the same definition used on some other architectures.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> I am not sure this is the correct patch in the context of uml. I believe this
> should give the runtime ip, which may be different between runs. It may be
> better to use the offset in .text (e.g. by using `pc-__text_start`), which
> should be consistent.
> 
>  arch/x86/um/asm/processor_64.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/um/asm/processor_64.h b/arch/x86/um/asm/processor_64.h
> index c3be852..6ca3304 100644
> --- a/arch/x86/um/asm/processor_64.h
> +++ b/arch/x86/um/asm/processor_64.h
> @@ -32,7 +32,7 @@ static inline void arch_copy_thread(struct arch_thread *from,
>  }
>  
>  #define current_text_addr() \
> -	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
> +	({ __label__ _l; _l: &&_l; })
>  
>  #define current_sp() ({ void *sp; __asm__("movq %%rsp, %0" : "=r" (sp) : ); sp; })
>  #define current_bp() ({ unsigned long bp; __asm__("movq %%rbp, %0" : "=r" (bp) : ); bp; })

Thanks,
//richard

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

