Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] um: remove unused variable
References: <20190312133037.5665-1-brgl@bgdev.pl>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4afb5d38-f2bd-9e79-fc62-c0cae83953e3@cambridgegreys.com>
Date: Wed, 13 Mar 2019 09:48:51 +0000
MIME-Version: 1.0
In-Reply-To: <20190312133037.5665-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 12/03/2019 13:30, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> The buf variable is unused. Remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   arch/um/kernel/skas/uaccess.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
> index 7f06fdbc7ee1..bd3cb694322c 100644
> --- a/arch/um/kernel/skas/uaccess.c
> +++ b/arch/um/kernel/skas/uaccess.c
> @@ -59,7 +59,6 @@ static pte_t *maybe_map(unsigned long virt, int is_write)
>   static int do_op_one_page(unsigned long addr, int len, int is_write,
>   		 int (*op)(unsigned long addr, int len, void *arg), void *arg)
>   {
> -	jmp_buf buf;
>   	struct page *page;
>   	pte_t *pte;
>   	int n;
> 
Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

