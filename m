Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1RYm6n-0005U8-9p
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Dec 2011 22:06:29 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1RYm6m-0002qd-Fl
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Dec 2011 22:06:29 +0000
Received: by ggnh1 with SMTP id h1so3201535ggn.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 08 Dec 2011 14:06:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1323133549-13590-2-git-send-email-hpa@linux.intel.com>
References: <1323133549-13590-1-git-send-email-hpa@linux.intel.com>
	<1323133549-13590-2-git-send-email-hpa@linux.intel.com>
Date: Thu, 8 Dec 2011 23:06:22 +0100
Message-ID: <CAFLxGvxuP64FzhKcL5bL2vv=sfQ0ZB2U_xXd4MkAF006RJfZrA@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 1/3] um: Run host archheaders,
	allow use of host generated headers
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

On Tue, Dec 6, 2011 at 2:05 AM, H. Peter Anvin <hpa@linux.intel.com> wrote:
> From: "H. Peter Anvin" <hpa@linux.intel.com>
>
> Run the "archheaders" target for the host architecture, for
> architectures (like x86, now) that want to generate some of the
> necessary header files.
>
> Add $(HOST_DIR)/include/generated to the include path so we then pick
> them up.
>
> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> ---
> =A0arch/um/Makefile | =A0 =A07 ++++++-
> =A01 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index 7730af6..00210e9 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -64,7 +64,8 @@ USER_CFLAGS =3D $(patsubst $(KERNEL_DEFINES),,$(patsubs=
t -D__KERNEL__,,\
> =A0#This will adjust *FLAGS accordingly to the platform.
> =A0include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
>
> -KBUILD_CPPFLAGS +=3D -I$(srctree)/$(HOST_DIR)/include
> +KBUILD_CPPFLAGS +=3D -I$(srctree)/$(HOST_DIR)/include \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-I$(HOST_DIR)/include/generated
>
> =A0# -Derrno=3Dkernel_errno - This turns all kernel references to errno i=
nto
> =A0# kernel_errno to separate them from the libc errno. =A0This allows -f=
no-common
> @@ -96,6 +97,10 @@ endef
>
> =A0KBUILD_KCONFIG :=3D $(HOST_DIR)/um/Kconfig
>
> +archheaders:
> + =A0 =A0 =A0 $(Q)$(MAKE) -C '$(KBUILD_SRC)' KBUILD_SRC=3D \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARCH=3D$(SUBARCH) O=3D'$(objtree)' archhead=
ers
> +

This does not work, KBUILD_SRC is empty.
I'm not a kbuild expert, but I think the usage of KBUILD_SRC is in general
not allowed.

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Cloud Services Checklist: Pricing and Packaging Optimization
This white paper is intended to serve as a reference, checklist and point o=
f =

discussion for anyone considering optimizing the pricing and packaging mode=
l =

of a cloud services business. Read Now!
http://www.accelacomm.com/jaw/sfnl/114/51491232/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

