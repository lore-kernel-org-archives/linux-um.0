Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Multiple longjmp definitions with STATIC_LINKING=y
From: Florian Fainelli <f.fainelli@gmail.com>
References: <4999b293-42a6-bf88-ef0b-af5e0fc3729c@gmail.com>
 <e03da776-ea69-cfea-14c8-b2d9694d9b31@nod.at>
 <3d3f50ce-372d-b09a-58ff-9edad4f9a6f8@gmail.com>
Message-ID: <26a3983c-426d-ab59-8fab-d41a643fe36b@gmail.com>
Date: Tue, 23 May 2017 18:09:24 -0700
MIME-Version: 1.0
In-Reply-To: <3d3f50ce-372d-b09a-58ff-9edad4f9a6f8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 05/23/2017 11:42 AM, Florian Fainelli wrote:
> 
> make -C
> /local/users/fainelli/openwrt/trunk/build_dir/target-x86_64_musl/linux-uml/linux-4.4.69
> HOSTCFLAGS="-O2
> -I/local/users/fainelli/openwrt/trunk/staging_dir/host/include
> -I/local/users/fainelli/openwrt/trunk/staging_dir/host/usr/include
> -Wall -Wmissing-prototypes -Wstrict-prototypes" CROSS_COMPILE=""
> ARCH="um" KBUILD_HAVE_NLS=no KBUILD_BUILD_USER="" KBUILD_BUILD_HOST=""
> KBUILD_BUILD_TIMESTAMP="Tue May 23 03:21:55 2017"
> KBUILD_BUILD_VERSION="0"
> HOST_LOADLIBES="-L/local/users/fainelli/openwrt/trunk/staging_dir/host/lib"
> CONFIG_SHELL="bash" V=''  cmd_syscalls= CC="gcc" modules
> make[5]: Entering directory `/local/users/fainelli/linux'
>   CHK     include/generated/uapi/linux/version.h
>   CHK     include/config/kernel.release
>   CHK     include/generated/utsrelease.h
>   CHK     scripts/mod/devicetable-offsets.h
>   CC      arch/x86/um/user-offsets.s
> arch/x86/um/user-offsets.c: In function 'foo':
> arch/x86/um/user-offsets.c:53: error: invalid application of 'sizeof' to
> incomplete type 'struct _xstate'
> make[6]: *** [arch/x86/um/user-offsets.s] Error 1
> make[5]: *** [arch/x86/um/user-offsets.s] Error 2
> make[5]: Leaving directory `/local/users/fainelli/linux'
> 
> Sounds familiar?

Found the problem and submitted a candidate fix to keep UML from both
building and running on older hosts.
-- 
Florian

