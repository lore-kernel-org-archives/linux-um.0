Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ms.lwn.net ([45.79.88.28])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIcWm-0002fI-PL
 for linux-um@lists.infradead.org; Wed, 16 Sep 2020 18:51:37 +0000
Date: Wed, 16 Sep 2020 12:51:34 -0600
From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3] docs: add a new User Mode Linux HowTo
Message-ID: <20200916125134.0d515516@lwn.net>
In-Reply-To: <20200916084741.6250-1-anton.ivanov@cambridgegreys.com>
References: <20200916084741.6250-1-anton.ivanov@cambridgegreys.com>
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

On Wed, 16 Sep 2020 09:47:41 +0100
anton.ivanov@cambridgegreys.com wrote:

> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> The new howto migrates the portions of the old howto which
> are still relevant to a new document, updates them to linux 5.x
> and adds documentation for vector transports and other new
> features.

OK, we're getting closer...

> This version addresses comments from Mike Rapoport and Jonathan
> Corbet.

This sort of information is good to have, but it should be put after the
"---" line.

> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> ---
>  Documentation/virt/index.rst                  |    2 +-
>  ...mode_linux.rst => user_mode_linux-2.4.rst} |    4 +
>  .../virt/uml/user_mode_linux_howto_v2.rst     | 1325 +++++++++++++++++
>  3 files changed, 1330 insertions(+), 1 deletion(-)
>  rename Documentation/virt/uml/{user_mode_linux.rst => user_mode_linux-2.4.rst} (99%)
>  create mode 100644 Documentation/virt/uml/user_mode_linux_howto_v2.rst
> 
> diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
> index de1ab81df958..d20490292642 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -8,7 +8,7 @@ Linux Virtualization Support
>     :maxdepth: 2
>  
>     kvm/index
> -   uml/user_mode_linux
> +   uml/user_mode_linux_howto_v2
>     paravirt_ops
>     guest-halt-polling
>  
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
> +

Kernel documentation should describe the current kernel.  If there is
information in this file that is still useful, please incorporate it into
your new document.  Then just call it user_mode_linux.rst and delete the
old one entirely.

[...]

> +Creating an image
> +=================
> +
> +Create a sparse raw disk image:
> +
> +::
> +
> +    # dd if=/dev/zero of=disk_image_name bs=1 count=1 seek=16G

You can do this a bit more concisely:

	Create a sparse raw disk image::

	  # dd if=/dev/zero of=disk_image_name bs=1 count=1 seek=16G

Please use that idiom throughout.

> +will create a 16G disk image. The OS will initially allocate only one
> +block and will allocate more as they are written by UML. As of kernel
> +version 4.19 UML fully supports TRIM (as usually used by flash drives).
> +Using TRIM inside the UML image by specifying discard as a mount option
> +or by running ``tune2fs -o discard /dev/ubdXX`` will request UML to
> +return any unused blocks to the OS.
> +
> +Create a filesystem on the disk image and mount it:
> +---------------------------------------------------

As part of getting these, these subsubsubsection headings could really just
be ordinary paragraphs.

> +::
> +
> +* The xterm channel - this is the default - bring up an xterm on this channel and
> +  direct IO to it. Note, that in order for xterm to work, the host must have the
> +  UML distribution package installed. This usually contains the port-helper and
> +  other utilities needed for UML to communicate with the xterm. Alternatively,
> +  these need to be complied and installed from source.  All options applicable
> +  to consoles also apply to UML serial lines which are presented as ttyS inside UML.

Please stick to the 80-character limit; it really does make a difference
for readable text.

With those small tweaks I think this will be ready to go; it can still
happen for 5.10.  Thanks for working on this.

jon

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

