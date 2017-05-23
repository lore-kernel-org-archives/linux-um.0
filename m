Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Multiple longjmp definitions with STATIC_LINKING=y
References: <4999b293-42a6-bf88-ef0b-af5e0fc3729c@gmail.com>
 <e03da776-ea69-cfea-14c8-b2d9694d9b31@nod.at>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3d3f50ce-372d-b09a-58ff-9edad4f9a6f8@gmail.com>
Date: Tue, 23 May 2017 11:42:23 -0700
MIME-Version: 1.0
In-Reply-To: <e03da776-ea69-cfea-14c8-b2d9694d9b31@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/23/2017 12:28 AM, Richard Weinberger wrote:
> Florian,
> 
> Am 23.05.2017 um 05:28 schrieb Florian Fainelli:
>> Hi Richard,
>>
>> I have been playing with UML again and trying to get it to statically
>> link on a CentOS 6.9 host that has:
>>
>> glibc-2.12-static
>> gcc-4.4
>>
>> installed results in the following:
>>
>> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
>> In function `siglongjmp':
>> (.text+0x8490): multiple definition of `longjmp'
>> arch/x86/um/built-in.o:/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69/arch/x86/um/setjmp_64.S:44:
>> first defined here
>> /usr/lib/gcc/x86_64-redhat-linux/4.4.7/../../../../lib64/libpthread.a(libpthread.o):
>> In function `sem_open':
>> (.text+0x77cd): warning: the use of `mktemp' is dangerous, better use
>> `mkstemp'
>> collect2: ld returned 1 exit status
>> make[4]: *** [vmlinux] Error 1
> 
> Meh, this is a new one.
> How is musl involved in this game?

So far it's not the user-space is musl based, which is why the path
contain musl here (that's how OpenWrt/LEDE differentiates, based on the
packages' target C library), but the host is a plain glibc.

Now that you mention that, on a real x86/musl host, I doubt that the
linker command would work, since libutil, librt and libpthread are most
likely already part of libc.a in musl. Might be worth fixing later.

> 
> Does it help when you add another redefine-hack to arch/um/Makefile?
> See -Dvmap=kernel_vmap.

Yes, it does and it runs fine with this patch:

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 0ca46ededfc7..908438107a1a 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -59,10 +59,14 @@ KBUILD_CPPFLAGS += -I$(srctree)/$(HOST_DIR)/um
 # Same things for in6addr_loopback and mktime - found in libc. For
these two we
 # only get link-time error, luckily.
 #
+# -Dlongjmp=kernel_longjmp prevents anything from referencing the
libpthread.a
+# embedded copy of longjmp
+#
 # These apply to USER_CFLAGS to.

 KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
        $(ARCH_INCLUDE) $(MODE_INCLUDE) -Dvmap=kernel_vmap      \
+       -Dlongjmp=kernel_longjmp -Dsetjmp=kernel_setjmp \
        -Din6addr_loopback=kernel_in6addr_loopback \
        -Din6addr_any=kernel_in6addr_any -Dstrrchr=kernel_strrchr

diff --git a/arch/x86/um/setjmp_64.S b/arch/x86/um/setjmp_64.S
index 45f547b4043e..eeb39352897a 100644
--- a/arch/x86/um/setjmp_64.S
+++ b/arch/x86/um/setjmp_64.S
@@ -18,9 +18,9 @@

        .text
        .align 4
-       .globl setjmp
-       .type setjmp, @function
-setjmp:
+       .globl kernel_setjmp
+       .type kernel_setjmp, @function
+kernel_setjmp:
        pop  %rsi                       # Return address, and adjust the
stack
        xorl %eax,%eax                  # Return value
        movq %rbx,(%rdi)
@@ -34,13 +34,13 @@ setjmp:
        movq %rsi,56(%rdi)              # Return address
        ret

-       .size setjmp,.-setjmp
+       .size kernel_setjmp,.-kernel_setjmp

        .text
        .align 4
-       .globl longjmp
-       .type longjmp, @function
-longjmp:
+       .globl kernel_jongjmp
+       .type kernel_jongjmp, @function
+kernel_jongjmp:
        movl %esi,%eax                  # Return value (int)
        movq (%rdi),%rbx
        movq 8(%rdi),%rsp
@@ -51,4 +51,4 @@ longjmp:
        movq 48(%rdi),%r15
        jmp *56(%rdi)

-       .size longjmp,.-longjmp
+       .size kernel_jongjmp,.-kernel_jongjmp


If that's okay with you, I can make a formal submission.

I ran into another problem after rebasing to v4.1-2rc2 though, which
makes me thing it's the same as this one I ran on MIPS a while ago which
should be fixed with:

cda2c65f981d0c29805fd01ffce441c650ffe6cf ("kbuild: Remove stale
asm-generic wrappers")

Here is the failure:

make -C
/local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69
HOSTCFLAGS="-O2
-I/local/users/fainelli/openwrt/trunk/staging_dir/host/include
-I/local/users/fainelli/openwrt/trunk/staging_dir/host/usr/include
-Wall -Wmissing-prototypes -Wstrict-prototypes" CROSS_COMPILE=""
ARCH="um" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="" KBUILD_BUILD_HOST=""
KBUILD_BUILD_TIMESTAMP="Tue May 23 03:21:55 2017"
KBUILD_BUILD_VERSION="0"
HOST_LOADLIBES="-L/local/users/fainelli/openwrt/trunk/staging_dir/host/lib"
CONFIG_SHELL="bash" V=''  cmd_syscalls= CC="gcc" modules
make[5]: Entering directory `/local/users/fainelli/linux'
  CHK     include/generated/uapi/linux/version.h
  CHK     include/config/kernel.release
  CHK     include/generated/utsrelease.h
  CHK     scripts/mod/devicetable-offsets.h
  CC      arch/x86/um/user-offsets.s
arch/x86/um/user-offsets.c: In function 'foo':
arch/x86/um/user-offsets.c:53: error: invalid application of 'sizeof' to
incomplete type 'struct _xstate'
make[6]: *** [arch/x86/um/user-offsets.s] Error 1
make[5]: *** [arch/x86/um/user-offsets.s] Error 2
make[5]: Leaving directory `/local/users/fainelli/linux'

Sounds familiar?

> 
>> Should we have some linker script magic not to export this symbol and
>> prevent a clash with libpthread.a pulling its own version?
> 
> Yes, we should. But so far nobody had the time to bite the bullet. :-)
> This is not the first bug of this kind. Please see.
> https://lkml.org/lkml/2015/11/19/726

Yes, that sort of makes sense, I wonder if we could just change the
symbols visibility and be done with that, but like you said, I have no
idea how we can control what the linker pulls in.

> 
> Thanks,
> //richard
> 


-- 
Florian

