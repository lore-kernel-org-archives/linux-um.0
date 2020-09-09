Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG4Jj-0006G8-La
 for linux-um@lists.infradead.org; Wed, 09 Sep 2020 17:55:36 +0000
Date: Wed, 9 Sep 2020 11:55:32 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] docs: add a new User Mode Linux HowTo
Message-ID: <20200909115532.42a96ddc@lwn.net>
In-Reply-To: <20200907092124.17599-1-anton.ivanov@cambridgegreys.com>
References: <20200907092124.17599-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-doc@vger.kernel.org

On Mon,  7 Sep 2020 10:21:24 +0100
anton.ivanov@cambridgegreys.com wrote:

Sorry, I'd missed the fact that there's a v2; my comments from v1 still
apply, though, it seems.

> diff --git a/Documentation/virt/uml/user_mode_linux.rst b/Documentation/virt/uml/user_mode_linux-2.4.rst
> similarity index 99%
> rename from Documentation/virt/uml/user_mode_linux.rst
> rename to Documentation/virt/uml/user_mode_linux-2.4.rst
> index de0f0b2c9d5b..ed5a698cd710 100644
> --- a/Documentation/virt/uml/user_mode_linux.rst
> +++ b/Documentation/virt/uml/user_mode_linux-2.4.rst
> @@ -10,6 +10,10 @@ User Mode Linux HOWTO
>  This document describes the use and abuse of Jeff Dike's User Mode
>  Linux: a port of the Linux kernel as a normal Intel Linux process.
>  
> +*Note: - this howto is historic and correct as of kernel versions
> +~ 2.4. For more up-to-date information please refer to the newer
> +user_mode_linux_howto_v2.*

So why are we keeping this version around?  The 5.x kernel doesn't need to
document what was happening in 2.4... ?

Thanks,

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

