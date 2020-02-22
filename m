Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j5ZLr-0001rh-CL
 for linux-um@lists.infradead.org; Sat, 22 Feb 2020 18:18:09 +0000
Subject: Re: [PATCH] Documentation: update UserModeLinux-HOWTO.txt
References: <1582391968-3960-1-git-send-email-manbing3@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <9e8a47ca-bc82-496c-dc32-a5cde0d26fe9@cambridgegreys.com>
Date: Sat, 22 Feb 2020 18:17:56 +0000
MIME-Version: 1.0
In-Reply-To: <1582391968-3960-1-git-send-email-manbing3@gmail.com>
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
To: Manbing <manbing3@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org



On 22/02/2020 17:19, Manbing wrote:
> Original content is obsolete. Which is based on kernel 2.4.0-prerelease.
> Updating content according to kernel 5.5.1.
> 
> Signed-off-by: Manbing <manbing3@gmail.com>
> ---
>   Documentation/virt/uml/UserModeLinux-HOWTO.txt | 42 +++++---------------------
>   1 file changed, 8 insertions(+), 34 deletions(-)
> 
> diff --git a/Documentation/virt/uml/UserModeLinux-HOWTO.txt b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> index 87b80f5..08ee28d 100644
> --- a/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> +++ b/Documentation/virt/uml/UserModeLinux-HOWTO.txt
> @@ -1,6 +1,6 @@
>     User Mode Linux HOWTO
>     User Mode Linux Core Team
> -  Mon Nov 18 14:16:16 EST 2002
> +  Mon Feb 10 08:27:24 EST 2020
>   
>     This document describes the use and abuse of Jeff Dike's User Mode
>     Linux: a port of the Linux kernel as a normal Intel Linux process.
> @@ -215,26 +215,17 @@
>   
>   
>     Compiling the user mode kernel is just like compiling any other
> -  kernel.  Let's go through the steps, using 2.4.0-prerelease (current
> +  kernel.  Let's go through the steps, using 5.5.1 (current
>     as of this writing) as an example:
>   
>   
> -  1. Download the latest UML patch from
> -
> -     the download page <http://user-mode-linux.sourceforge.net/
> -
> -     In this example, the file is uml-patch-2.4.0-prerelease.bz2.
> -
> -
> -  2. Download the matching kernel from your favourite kernel mirror,
> +  1. Download the matching kernel from your favourite kernel mirror,
>        such as:
>   
> -     ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2
> -     <ftp://ftp.ca.kernel.org/pub/kernel/v2.4/linux-2.4.0-prerelease.tar.bz2>
> -     .
> +     wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.5.1.tar.xz
>   
>   
> -  3. Make a directory and unpack the kernel into it.
> +  2. Make a directory and unpack the kernel into it.
>   
>   
>   
> @@ -255,31 +246,14 @@
>   
>   
>          host%
> -       tar -xzvf linux-2.4.0-prerelease.tar.bz2
> -
> -
> -
> -
> -
> -
> -  4. Apply the patch using
> -
> -
> -
> -       host%
> -       cd ~/uml/linux
> -
> -
> -
> -       host%
> -       bzcat uml-patch-2.4.0-prerelease.bz2 | patch -p1
> +       tar xvf linux-5.5.1.tar.xz
>   
>   
>   
>   
>   
>   
> -  5. Run your favorite config; `make xconfig ARCH=um' is the most
> +  3. Run your favorite config; `make xconfig ARCH=um' is the most
>        convenient.  `make config ARCH=um' and 'make menuconfig ARCH=um'
>        will work as well.  The defaults will give you a useful kernel.  If
>        you want to change something, go ahead, it probably won't hurt
> @@ -293,7 +267,7 @@
>   
>   
>   
> -  6. Finish with `make linux ARCH=um': the result is a file called
> +  4. Finish with `make linux ARCH=um': the result is a file called
>        `linux' in the top directory of your source tree.
>   
>     Make sure that you don't build this kernel in /usr/src/linux.  On some
> 

I am rewriting the whole thing at the moment.

I will publish the finished sections for review at some point during the 
coming week.

It needs to be rewritten from scratch, fixing a few things like this is 
not enough.

Brgds,

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

