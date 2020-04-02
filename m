Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJuWn-0001lK-An
 for linux-um@lists.infradead.org; Thu, 02 Apr 2020 07:44:42 +0000
Subject: Re: [PATCH] um: add include: memset() and memcpy() are in <string.h>
References: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <26235042-02c6-04ae-42ec-4d1f393975d8@cambridgegreys.com>
Date: Thu, 2 Apr 2020 08:44:29 +0100
MIME-Version: 1.0
In-Reply-To: <a1f6271e7c72e49fd863efc4b7126be6598fd4f6.camel@zv.io>
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
To: Zach van Rijn <me@zv.io>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org



On 01/04/2020 22:30, Zach van Rijn wrote:
> These two functions are otherwise unknown to the pedantic compiler.
> Include the correct header to enable the build to succeed.
> 
> Signed-off-by: Zach van Rijn <me@zv.io>
> ---
>   arch/um/os-Linux/file.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index 26ecbd64c409..044836ad7392 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -6,6 +6,7 @@
>   #include <stdio.h>
>   #include <unistd.h>
>   #include <stdlib.h>
> +#include <string.h>
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <signal.h>
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

