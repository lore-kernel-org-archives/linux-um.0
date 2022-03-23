Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX6r9-00EkFp-86
 for linux-um@lists.infradead.org; Wed, 23 Mar 2022 19:41:21 +0000
Date: Wed, 23 Mar 2022 12:41:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 1/1] um: fix error return code in winch_tramp()
Message-ID: <Yjt31seiNv18HYrf@dev-arch.thelio-3990X>
References: <20210508032239.2177-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210508032239.2177-1-thunder.leizhen@huawei.com>
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
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Andrew Morton <akpm@linux-foundation.org>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, regressions@lists.linux.dev

Hello,

On Sat, May 08, 2021 at 11:22:39AM +0800, Zhen Lei wrote:
> Fix to return a negative error code from the error handling case instead
> of 0, as done elsewhere in this function.
> 
> Fixes: 89df6bfc0405 ("uml: DEBUG_SHIRQ fixes")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/um/drivers/chan_user.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
> index d8845d4aac6a..6040817c036f 100644
> --- a/arch/um/drivers/chan_user.c
> +++ b/arch/um/drivers/chan_user.c
> @@ -256,7 +256,8 @@ static int winch_tramp(int fd, struct tty_port *port, int *fd_out,
>  		goto out_close;
>  	}
>  
> -	if (os_set_fd_block(*fd_out, 0)) {
> +	err = os_set_fd_block(*fd_out, 0);
> +	if (err) {
>  		printk(UM_KERN_ERR "winch_tramp: failed to set thread_fd "
>  		       "non-blocking.\n");
>  		goto out_close;
> -- 
> 2.25.1
> 
> 
> 

Sorry for the necro bump but this patch as commit ccf1236ecac4 ("um: fix
error return code in winch_tramp()") prevents UML from exiting cleanly
when it is called from within in a shell script. It is still
reproducible at next-20220323. I did see a patch from Richard that
touches this area but that patch does not make a difference:

https://lore.kernel.org/r/20220101215810.13260-3-richard@nod.at/

My bisect log:

# bad: [7d2a07b769330c34b4deabeed939325c77a7ec2f] Linux 5.14
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start 'v5.14' 'v5.13'
# good: [406254918b232db198ed60f5bf1f8b84d96bca00] Merge tag 'perf-tools-for-v5.14-2021-07-01' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux
git bisect good 406254918b232db198ed60f5bf1f8b84d96bca00
# good: [4ea90317956718e0648e1f87e56530db809a5a04] Merge tag 'for-linus-5.14-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good 4ea90317956718e0648e1f87e56530db809a5a04
# bad: [65ca89c2b12cca0d473f3dd54267568ad3af55cc] ASoC: intel: atom: Fix breakage for PCM buffer address setup
git bisect bad 65ca89c2b12cca0d473f3dd54267568ad3af55cc
# bad: [6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc] Merge tag 'arm-soc-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 6e207b882159ed3e35a4cd4ff0fc155cce5e3cbc
# good: [f55966571d5eb2876a11e48e798b4592fa1ffbb7] Merge tag 'drm-next-2021-07-08-1' of git://anongit.freedesktop.org/drm/drm
git bisect good f55966571d5eb2876a11e48e798b4592fa1ffbb7
# bad: [1459718d7d79013a4814275c466e0b32da6a26bc] Merge tag 'powerpc-5.14-2' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect bad 1459718d7d79013a4814275c466e0b32da6a26bc
# good: [227c4d507c71acb7bece298a98d83e5b44433f62] Merge tag 'f2fs-for-5.14-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
git bisect good 227c4d507c71acb7bece298a98d83e5b44433f62
# good: [96890bc2eaa1f6bfc1b194e0f0815a10824352a4] Merge tag 'nfs-for-5.14-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
git bisect good 96890bc2eaa1f6bfc1b194e0f0815a10824352a4
# good: [e49d68ce7cc5a865ce14c1e57938438ab01c3ce3] Merge tag 'ext4_for_linus_stable' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4
git bisect good e49d68ce7cc5a865ce14c1e57938438ab01c3ce3
# bad: [ccf1236ecac476d9d2704866d9a476c86e387971] um: fix error return code in winch_tramp()
git bisect bad ccf1236ecac476d9d2704866d9a476c86e387971
# good: [68f5d3f3b6543266b29e047cfaf9842333019b4c] um: add PCI over virtio emulation driver
git bisect good 68f5d3f3b6543266b29e047cfaf9842333019b4c
# good: [c0ecca6604b80e438b032578634c6e133c7028f6] um: enable the use of optimized xor routines in UML
git bisect good c0ecca6604b80e438b032578634c6e133c7028f6
# good: [80f849bf541ef9b633a9c08ac208f9c9afd14eb9] um: implement flush_cache_vmap/flush_cache_vunmap
git bisect good 80f849bf541ef9b633a9c08ac208f9c9afd14eb9
# good: [b77e81fbe5f5fb4ad9a61ec80f6d1e30b6da093a] um: fix error return code in slip_open()
git bisect good b77e81fbe5f5fb4ad9a61ec80f6d1e30b6da093a
# first bad commit: [ccf1236ecac476d9d2704866d9a476c86e387971] um: fix error return code in winch_tramp()

$ make -skj"$(nproc)" ARCH=um mrproper defconfig all

$ ./linux ubd0=...
...
Run /sbin/init as init process
EXT4-fs (ubda): re-mounted. Quota mode: none.
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator: OK
Saving random seed: OK
Starting network: OK
Linux version 5.17.0-next-20220323 (nathan@dev-arch.thelio-3990X) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38) #1 Wed Mar 23 12:05:22 MST 2022
Stopping network: OK
Saving random seed: OK
Stopping klogd: OK
Stopping syslogd: OK
EXT4-fs (ubda): re-mounted. Quota mode: none.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
reboot: System halted

$ echo $?
0

$ cat test.sh
#!/usr/bin/env bash

./linux ubd0=...

$ ./test.sh
...
Run /sbin/init as init process
EXT4-fs (ubda): re-mounted. Quota mode: none.
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Initializing random number generator: OK
Saving random seed: OK
Starting network: OK
Linux version 5.17.0-next-20220323 (nathan@dev-arch.thelio-3990X) (gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.38) #1 Wed Mar 23 12:10:31 MST 2022
Stopping network: OK
Saving random seed: OK
Stopping klogd: OK
Stopping syslogd: OK
EXT4-fs (ubda): re-mounted. Quota mode: none.
The system is going down NOW!
Sent SIGTERM to all processes
Sent SIGKILL to all processes
Requesting system poweroff
reboot: System halted
./test.sh: line 5: 970978 Killed                  ./linux ubd0=...

$ echo $?
137

The rootfs is a simple Buildroot image, which just prints the version
string then runs "poweroff". It is available at:

https://github.com/nathanchance/boot-utils/raw/bd4b962ee12e00f666eef12e3413a79d334a0685/images/x86_64/rootfs.ext4.zst

in case it helps. I am happy to provide more information or test patches
as necessary.

Cheers,
Nathan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

