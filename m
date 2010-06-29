Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4C29B034.8070208@panasas.com>
Date: Tue, 29 Jun 2010 11:35:00 +0300
From: Boaz Harrosh <bharrosh@panasas.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] um: Include missing header file in 	os-linux/mem.c
References: <AANLkTikziSEDW07YiiJs6ny6JLhSQ-TGvdw_kTroIIx5@mail.gmail.com>	<4C1809D3.7030707@panasas.com> <AANLkTikYn_EwizmUq6ZxitJ6ibCkr8Nfd4yslK_Bo0zR@mail.gmail.com>
In-Reply-To: <AANLkTikYn_EwizmUq6ZxitJ6ibCkr8Nfd4yslK_Bo0zR@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Liu Aleaxander <aleaxander@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 06/15/2010 11:06 AM, Liu Aleaxander wrote:
> The os-linux/mem.c file calls fchmod function, which is declared in sys/stat.h
> header file, so include it.
> 
> Signed-off-by: Liu Aleaxander <Aleaxander@gmail.com>
> ---
>  arch/um/os-Linux/mem.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> index 93a11d7..e696144 100644
> --- a/arch/um/os-Linux/mem.c
> +++ b/arch/um/os-Linux/mem.c
> @@ -10,6 +10,7 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <string.h>
> +#include <sys/stat.h>
>  #include <sys/mman.h>
>  #include <sys/param.h>
>  #include "init.h"
> 

On 06/15/2010 04:06 AM, Liu Aleaxander wrote:
> On Wed, Jun 16, 2010 at 7:16 AM, Boaz Harrosh <bharrosh@panasas.com> wrote:
>>
>> Yes. I have the same patch.
>>
>> Apparently it's new for Fedora 13. Previous Fedora's are compiling fine.
> 
> Same here:)
> 
>> I guess something has changed with the new gcc headers include sequence
> 

Andrew? Jeff? someone?

I saw that some uml patches where pushed for -rc4. What about this patch?
could some one push this patch? It's for FC13 compilation?

It might be needed for stable@ as well. I'll try to test with old Kernels.
Am back on an FC12 in the office so it'll take some time.

Liu could you test to see that older Kernels need this patch as well?

Thanks
Boaz
