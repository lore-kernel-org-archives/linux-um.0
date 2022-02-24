Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN9jb-00HMFA-6x
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 08:44:26 +0000
Subject: Re: [PATCH] um: Remove unused timeval_to_ns() function
References: <20220224081233.1765788-1-davidgow@google.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <78d6ac17-9492-7c41-d6dd-4c92dce8ce62@cambridgegreys.com>
Date: Thu, 24 Feb 2022 08:44:06 +0000
MIME-Version: 1.0
In-Reply-To: <20220224081233.1765788-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>
Cc: linux-um@lists.infradead.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org



On 24/02/2022 08:12, David Gow wrote:
> The timeval_to_ns() function doesn't appear to be used anywhere, as far
> as I (or git grep) can tell, and clang throws up a warning about it:
> 
> ../arch/um/os-Linux/time.c:21:25: warning: unused function 'timeval_to_ns' [-Wunused-function]
> static inline long long timeval_to_ns(const struct timeval *tv)

Correct. Leftovers from the days when the timers subsystem was based on itimer_*() instead of POSIX timers.

>                          ^
> 1 warning generated.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
> 
> Warning can be reproduced under clang 13.0.1-+rc1 after applying:
> um: Allow builds with Clang -- https://lkml.org/lkml/2022/2/24/40
> 
>   arch/um/os-Linux/time.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
> index 6c5041c5560b..4d5591d96d8c 100644
> --- a/arch/um/os-Linux/time.c
> +++ b/arch/um/os-Linux/time.c
> @@ -18,12 +18,6 @@
>   
>   static timer_t event_high_res_timer = 0;
>   
> -static inline long long timeval_to_ns(const struct timeval *tv)
> -{
> -	return ((long long) tv->tv_sec * UM_NSEC_PER_SEC) +
> -		tv->tv_usec * UM_NSEC_PER_USEC;
> -}
> -
>   static inline long long timespec_to_ns(const struct timespec *ts)
>   {
>   	return ((long long) ts->tv_sec * UM_NSEC_PER_SEC) + ts->tv_nsec;
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

