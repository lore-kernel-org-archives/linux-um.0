Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from perceval.ideasonboard.com
 ([2001:4b98:dc2:55:216:3eff:fef7:d647])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gCnlt-0004Cs-24
 for linux-um@lists.infradead.org; Wed, 17 Oct 2018 15:30:16 +0000
Subject: Re: [RFC v1 06/31] arch: um: enabled running kunit from User Mode
 Linux
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com>
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
Message-ID: <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
Date: Wed, 17 Oct 2018 16:29:38 +0100
MIME-Version: 1.0
In-Reply-To: <20181016235120.138227-7-brendanhiggins@google.com>
Content-Language: en-GB
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>, gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org, shuah@kernel.org, Tim.Bird@sony.com
Cc: brakmo@fb.com, richard@nod.at, mpe@ellerman.id.au, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, julia.lawall@lip6.fr, joel@jms.id.au, linux-kselftest@vger.kernel.org, khilman@baylibre.com, joe@perches.com, kunit-dev@googlegroups.com

Hi Brendan,

I very excitedly jumped on these patches to try them out, as this is
essentially something I was trying to do a few weeks back.

On 17/10/18 00:50, Brendan Higgins wrote:
> Makes minimum number of changes outside of the KUnit directories for
> KUnit to build and run using UML.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  Makefile             | 2 +-
>  arch/um/Kconfig.rest | 3 +++

But this file isn't present on v4.19-rc8

It looks like the file is removed at f163977d21a2 ("um: cleanup Kconfig
files")

What version have you currently based these patches on?
Do you expect to keep a branch somewhere that's easy to pull in?

Please add me to the CC list as an interested party on later versions :-)

It might be of interest to the automated testing mailing list too ? (Tim?)

--
regards

Kieran


>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Makefile b/Makefile
> index 863f58503beed..c8e659468ed49 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -944,7 +944,7 @@ endif
>  
>  
>  ifeq ($(KBUILD_EXTMOD),)
> -core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/
> +core-y		+= kernel/ certs/ mm/ fs/ ipc/ security/ crypto/ block/ kunit/
>  
>  vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
>  		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
> diff --git a/arch/um/Kconfig.rest b/arch/um/Kconfig.rest
> index 08327b9c0cbea..484c4cfcad1ef 100644
> --- a/arch/um/Kconfig.rest
> +++ b/arch/um/Kconfig.rest
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +source "kunit/Kconfig"
> +
>  source "init/Kconfig"
>  
>  source "kernel/Kconfig.freezer"
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

