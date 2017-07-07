Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dTbVR-0004nb-CK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 22:13:45 +0000
Received: from mail-oi0-f66.google.com ([209.85.218.66])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dTbVQ-0003Da-Ae
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 22:13:45 +0000
Received: by mail-oi0-f66.google.com with SMTP id d77so5432353oig.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Jul 2017 15:13:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170707210127.11601-1-thomas@m3y3r.de>
References: <20170706210404.18253-1-thomas@m3y3r.de>
	<20170707210127.11601-1-thomas@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sat, 8 Jul 2017 00:13:38 +0200
Message-ID: <CAFLxGvzyMVKMmm6Xuf=myOQ+_XdndDYHv1TW8ztN5qT4i-uQsA@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: v2: Fix FP register size for
 XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Thomas,

On Fri, Jul 7, 2017 at 11:01 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Hard code max size. Taken from
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/os-Linux/skas/process.c  | 22 ++++++++++++++++++----
>  arch/x86/um/os-Linux/registers.c | 16 +++++++++++-----
>  arch/x86/um/user-offsets.c       |  2 +-
>  3 files changed, 30 insertions(+), 10 deletions(-)
>
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 03b3c4cc7735..1a7cce387950 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -91,19 +91,25 @@ extern unsigned long current_stub_stack(void);
>  static void get_skas_faultinfo(int pid, struct faultinfo *fi)
>  {
>         int err;
> -       unsigned long fpregs[FP_SIZE];
> +       void * fpregs;
> +
> +       fpregs = malloc(FP_SIZE * sizeof(unsigned long));
> +       if(fpregs == NULL) {
> +               printk(UM_KERN_ERR "cannot alloc memory for save_fp_registers!");
> +               goto errout;
> +       }

Having a malloc() here is rather expensive.
I suggest to allocate a buffer in userspace() that can be used in
get_skas_faultinfo().

Thanks,
//richard
-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

