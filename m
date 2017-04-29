Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 29 Apr 2017 20:26:17 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 5/7] um: Print out fatal error in stderr
Message-Id: <20170429202617.df4a855dff629441161c4871@kernel.org>
In-Reply-To: <149337512938.14717.12152115985265749215.stgit@devbox>
References: <149337478135.14717.16640886389891283.stgit@devbox>
        <149337512938.14717.12152115985265749215.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 28 Apr 2017 19:25:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Print out fatal error in stderr as same as fatal() does.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/um/kernel/physmem.c |    8 ++++----
>  arch/um/kernel/um_arch.c |    2 +-
>  arch/um/os-Linux/main.c  |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index 4c9861b..7f95329 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -89,8 +89,8 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
>  	offset = uml_reserved - uml_physmem;
>  	map_size = len - offset;
>  	if(map_size <= 0) {
> -		printf("Too few physical memory! Needed=%d, given=%d\n",
> -		       offset, len);
> +		fprintf(stderr, "Too few physical memory! Needed=%d, "
> +			"given=%d\n", offset, len);

Oops, I've missed to include something for using fprintf here.
Anyway, I think we need something like um_fatal() for handling
these errors.
I'll resend v2.

Thanks,

>  		exit(1);
>  	}
>  
> @@ -99,8 +99,8 @@ void __init setup_physmem(unsigned long start, unsigned long reserve_end,
>  	err = os_map_memory((void *) uml_reserved, physmem_fd, offset,
>  			    map_size, 1, 1, 1);
>  	if (err < 0) {
> -		printf("setup_physmem - mapping %ld bytes of memory at 0x%p "
> -		       "failed - errno = %d\n", map_size,
> +		fprintf(stderr, "setup_physmem - mapping %ld bytes of memory "
> +			"at 0x%p failed - errno = %d\n", map_size,
>  		       (void *) uml_reserved, err);
>  		exit(1);
>  	}
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index b3b28db..01817d6 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -34,7 +34,7 @@ static char __initdata command_line[COMMAND_LINE_SIZE] = { 0 };
>  static void __init add_arg(char *arg)
>  {
>  	if (strlen(command_line) + strlen(arg) + 1 > COMMAND_LINE_SIZE) {
> -		printf("add_arg: Too many command line arguments!\n");
> +		fprintf(stderr, "add_arg: Too many command line arguments!\n");
>  		exit(1);
>  	}
>  	if (strlen(command_line) > 0)
> diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
> index 659fee3..09b44f1 100644
> --- a/arch/um/os-Linux/main.c
> +++ b/arch/um/os-Linux/main.c
> @@ -74,8 +74,8 @@ static void install_fatal_handler(int sig)
>  	action.sa_restorer = NULL;
>  	action.sa_handler = last_ditch_exit;
>  	if (sigaction(sig, &action, NULL) < 0) {
> -		printf("failed to install handler for signal %d - errno = %d\n",
> -		       sig, errno);
> +		fprintf(stderr, "failed to install handler for signal %d "
> +			"- errno = %d\n", sig, errno);
>  		exit(1);
>  	}
>  }
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

