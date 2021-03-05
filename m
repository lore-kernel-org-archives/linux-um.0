Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHTU-00GSht-Rc
 for linux-um@lists.infradead.org; Fri, 05 Mar 2021 20:55:08 +0000
Subject: Re: [PATCH] um: mark all kernel symbols as local
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <20210305214315.75ea78f93d79.I410acf4509c4ff51aac4a03df61d19abfa0454cb@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <5d04179e-5ba5-a0cc-e514-c90feea5eb00@cambridgegreys.com>
Date: Fri, 5 Mar 2021 20:54:53 +0000
MIME-Version: 1.0
In-Reply-To: <20210305214315.75ea78f93d79.I410acf4509c4ff51aac4a03df61d19abfa0454cb@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Ritesh Raj Sarraf <rrs@debian.org>, 983379@bugs.debian.org, Christopher Obbard <chris.obbard@collabora.com>, Johannes Berg <johannes.berg@intel.com>

On 05/03/2021 20:43, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Ritesh reported a bug [1] against UML, noting that it crashed on
> startup. The backtrace shows the following (heavily redacted):
> 
> (gdb) bt
> ...
>   #26 0x0000000060015b5d in sem_init () at ipc/sem.c:268
>   #27 0x00007f89906d92f7 in ?? () from /lib/x86_64-linux-gnu/libcom_err.so.2
>   #28 0x00007f8990ab8fb2 in call_init (...) at dl-init.c:72
> ...
>   #40 0x00007f89909bf3a6 in nss_load_library (...) at nsswitch.c:359
> ...
>   #44 0x00007f8990895e35 in _nss_compat_getgrnam_r (...) at nss_compat/compat-grp.c:486
>   #45 0x00007f8990968b85 in __getgrnam_r [...]
>   #46 0x00007f89909d6b77 in grantpt [...]
>   #47 0x00007f8990a9394e in __GI_openpty [...]
>   #48 0x00000000604a1f65 in openpty_cb (...) at arch/um/os-Linux/sigio.c:407
>   #49 0x00000000604a58d0 in start_idle_thread (...) at arch/um/os-Linux/skas/process.c:598
>   #50 0x0000000060004a3d in start_uml () at arch/um/kernel/skas/process.c:45
>   #51 0x00000000600047b2 in linux_main (...) at arch/um/kernel/um_arch.c:334
>   #52 0x000000006000574f in main (...) at arch/um/os-Linux/main.c:144
> 
> indicating that the UML function openpty_cb() calls openpty(),
> which internally calls __getgrnam_r(), which causes the nsswitch
> machinery to get started.
> 
> This loads, through lots of indirection that I snipped, the
> libcom_err.so.2 library, which (in an unknown function, "??")
> calls sem_init().
> 
> Now, of course it wants to get libpthread's sem_init(), since
> it's linked against libpthread. However, the dynamic linker
> looks up that symbol against the binary first, and gets the
> kernel's sem_init().
> 
> Hajime Tazaki noted that "objcopy -L" can localize a symbol,
> so the dynamic linker wouldn't do the lookup this way. I tried,
> but for some reason that didn't seem to work.
> 
> Doing the same thing in the linker script instead does seem to
> work, though I cannot entirely explain - it *also* works if I
> just add "VERSION { { global: *; }; }" instead, indicating that
> something else is happening that I don't really understand. It
> may be that explicitly doing that marks them with some kind of
> empty version, and that's different from the default.
> 
> Explicitly marking them with a version breaks kallsyms, so that
> doesn't seem to be possible.
> 
> Marking all the symbols as local seems correct, and does seem
> to address the issue, so do that. Also do it for static link,
> nsswitch libraries could still be loaded there.
> 
> [1] https://bugs.debian.org/983379
> 
> Reported-by: Ritesh Raj Sarraf <rrs@debian.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/kernel/dyn.lds.S | 6 ++++++
>   arch/um/kernel/uml.lds.S | 6 ++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> index dacbfabf66d8..2f2a8ce92f1e 100644
> --- a/arch/um/kernel/dyn.lds.S
> +++ b/arch/um/kernel/dyn.lds.S
> @@ -6,6 +6,12 @@ OUTPUT_ARCH(ELF_ARCH)
>   ENTRY(_start)
>   jiffies = jiffies_64;
>   
> +VERSION {
> +  {
> +    local: *;
> +  };
> +}
> +
>   SECTIONS
>   {
>     PROVIDE (__executable_start = START);
> diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> index 45d957d7004c..7a8e2b123e29 100644
> --- a/arch/um/kernel/uml.lds.S
> +++ b/arch/um/kernel/uml.lds.S
> @@ -7,6 +7,12 @@ OUTPUT_ARCH(ELF_ARCH)
>   ENTRY(_start)
>   jiffies = jiffies_64;
>   
> +VERSION {
> +  {
> +    local: *;
> +  };
> +}
> +
>   SECTIONS
>   {
>     /* This must contain the right address - not quite the default ELF one.*/
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

