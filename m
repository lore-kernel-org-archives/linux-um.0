Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] arch/um: falloc.h needs to be directly included for older
 libc
References: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <2295c218-74a6-d785-f4b1-2046ee91503a@cambridgegreys.com>
Date: Fri, 20 Mar 2020 15:57:20 +0000
MIME-Version: 1.0
In-Reply-To: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Maguire <alan.maguire@oracle.com>, jdike@addtoit.com, richard@nod.at, alex.dewar@gmx.co.uk, erelx.geron@intel.com, johannes.berg@intel.com, arnd@arndb.de, linux-um@lists.infradead.org
Cc: brendanhiggins@google.com, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 17/03/2020 17:35, Alan Maguire wrote:
> When building UML with glibc 2.17 installed, compilation
> of arch/um/os-Linux/file.c fails due to failure to find
> FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.
> 
> It appears that /usr/include/bits/fcntl-linux.h (indirectly
> included by /usr/include/fcntl.h) does not include falloc.h
> with an older glibc, whereas a more up-to-date version
> does.
> 
> Adding the direct include to file.c resolves the issue
> and does not cause problems for more recent glibc.
> 
> Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>   arch/um/os-Linux/file.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> index fbda105..5c819f8 100644
> --- a/arch/um/os-Linux/file.c
> +++ b/arch/um/os-Linux/file.c
> @@ -8,6 +8,7 @@
>   #include <errno.h>
>   #include <fcntl.h>
>   #include <signal.h>
> +#include <linux/falloc.h>
>   #include <sys/ioctl.h>
>   #include <sys/mount.h>
>   #include <sys/socket.h>
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

