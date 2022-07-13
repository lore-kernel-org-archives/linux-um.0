Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBWQj-0012Y8-Lb
	for linux-um@lists.infradead.org; Wed, 13 Jul 2022 07:05:06 +0000
Message-ID: <d2c55506bd0a93854320ce352a93303cf8080f48.camel@sipsolutions.net>
Subject: Re: [PATCH] um: seed rng using host OS rng
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 13 Jul 2022 09:05:03 +0200
In-Reply-To: <20220712232738.77737-1-Jason@zx2c4.com>
References: <20220712232738.77737-1-Jason@zx2c4.com>
MIME-Version: 1.0
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

On Wed, 2022-07-13 at 01:27 +0200, Jason A. Donenfeld wrote:
> 
> +++ b/arch/um/include/shared/os.h
> @@ -11,6 +11,12 @@
>  #include <irq_user.h>
>  #include <longjmp.h>
>  #include <mm_id.h>
> +/* This is to get size_t */
> +#ifndef __UM_HOST__
> +#include <linux/types.h>
> +#else
> +#include <stddef.h>
> +#endif
>  
>  #define CATCH_EINTR(expr) while ((errno = 0, ((expr) < 0)) && (errno == EINTR))
>  
> @@ -243,6 +249,7 @@ extern void stack_protections(unsigned long address);
>  extern int raw(int fd);
>  extern void setup_machinename(char *machine_out);
>  extern void setup_hostinfo(char *buf, int len);
> +extern ssize_t os_getrandom(void *buf, size_t len, unsigned int flags);

For me, this doesn't compile, and per the man-page on my system, ssize_t
requires <sys/types.h>, not <stddef.h>?

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

