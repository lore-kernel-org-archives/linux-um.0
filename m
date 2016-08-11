Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stefan@hello-penguin.com>) id 1bXpDN-0000m8-1R
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2016 12:36:01 +0000
Received: from mail.nethype.de ([5.9.56.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bXpDK-0000p1-M3
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2016 12:36:01 +0000
Received: from [10.9.0.40] (helo=localhost.localdomain)
	by mail.nethype.de with esmtp (Exim 4.84_2)
	(envelope-from <stefan@hello-penguin.com>) id 1bXoxj-00024y-78
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 11 Aug 2016 12:19:51 +0000
Date: Thu, 11 Aug 2016 14:19:50 +0200
From: Stefan Traby <stefan@hello-penguin.com>
Message-ID: <20160811121950.fxhgqzjamaa37ezp@hello-penguin.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] link error on recent kernels with CONFIG_STATIC_LINK=y
Reply-To: Stefan Traby <stefan@hello-penguin.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

hi!

I get
`.text.exit' referenced in section `.fini_array' of
/usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o):
defined in discarded section `.text.exit' of
/usr/lib/gcc/x86_64-linux-gnu/6/../../../x86_64-linux-gnu/libc.a(sdlerror.o)

on statically linking uml (dynamic linking works).
I use debian unstable.


running ../bisect.sh
Bisecting: 6495 revisions left to test after this (roughly 13 steps)
[c3486f5376696034d0fcbef8ba70c70cfcb26f51] mm, compaction: simplify contended compaction handling
running ../bisect.sh
Bisecting: 3075 revisions left to test after this (roughly 12 steps)
[9c1958fc326a0a0a533ec8e86ea6fa30977207de] Merge tag 'media/v4.8-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
running ../bisect.sh
Bisecting: 1688 revisions left to test after this (roughly 11 steps)
[7e4dc77b2869a683fc43c0394fca5441816390ba] Merge branch 'perf-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
running ../bisect.sh
Bisecting: 749 revisions left to test after this (roughly 10 steps)
[25a0dc4be86fc0d8c7e81bb5f8be8427022bf15f] Merge tag 'staging-4.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
running ../bisect.sh
Bisecting: 480 revisions left to test after this (roughly 9 steps)
[b403f230448ed687edcc460cd46de652bc686b12] Merge tag 'gfs2-4.7.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
running ../bisect.sh
Bisecting: 237 revisions left to test after this (roughly 8 steps)
[33f4751e99601b7bfd1d66aedabd3ee9140922de] mm: thp: move pmd check inside ptl for freeze_page()
running ../bisect.sh
Bisecting: 118 revisions left to test after this (roughly 7 steps)
[4c2a8499a450b6582eb5637a8f0d472168355ddd] Merge tag 'configfs-for-4.7' of git://git.infradead.org/users/hch/configfs
running ../bisect.sh
Bisecting: 60 revisions left to test after this (roughly 6 steps)
[cfae7e3eb1334ff8035bb66f307f3d4010e65646] Merge tag 'for-linus-4.7b-rc6-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
running ../bisect.sh
Bisecting: 30 revisions left to test after this (roughly 5 steps)
[f1b5e4fac164ff43b189d996e4f05f95cc57b984] Merge tag 'acpi-urgent-4.7' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
running ../bisect.sh
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[f97d10454e4da2aceb44dfa7c59bb43ba9f50199] Merge branches 'perf-urgent-for-linus' and 'timers-urgent-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
running ../bisect.sh
Bisecting: 7 revisions left to test after this (roughly 3 steps)
[ef722fd4a7592ddbfa42bcb3ad8a5caa598589b3] Revert "scripts/gdb: add documentation example for radix tree"
running ../bisect.sh
Bisecting: 3 revisions left to test after this (roughly 2 steps)
[e4568d3803852d00effd41dcdd489e726b998879] mm, meminit: always return a valid node from early_pfn_to_nid
running ../bisect.sh
Bisecting: 1 revision left to test after this (roughly 1 step)
[d02038f972538b93011d78c068f44514fbde0a8c] gcov: add support for gcc version >= 6
running ../bisect.sh
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[e41f501d391265ff568f3e49d6128cc30856a36f] vmlinux.lds: account for destructor sections
running ../bisect.sh
e41f501d391265ff568f3e49d6128cc30856a36f is the first bad commit
commit e41f501d391265ff568f3e49d6128cc30856a36f
Author: Dmitry Vyukov <dvyukov@google.com>
Date:   Thu Jul 14 12:07:29 2016 -0700

    vmlinux.lds: account for destructor sections
    
    If CONFIG_KASAN is enabled and gcc is configured with
    --disable-initfini-array and/or gold linker is used, gcc emits
    .ctors/.dtors and .text.startup/.text.exit sections instead of
    .init_array/.fini_array.  .dtors section is not explicitly accounted in
    the linker script and messes vvar/percpu layout.
    
    We want:
      ffffffff822bfd80 D _edata
      ffffffff822c0000 D __vvar_beginning_hack
      ffffffff822c0000 A __vvar_page
      ffffffff822c0080 0000000000000098 D vsyscall_gtod_data
      ffffffff822c1000 A __init_begin
      ffffffff822c1000 D init_per_cpu__irq_stack_union
      ffffffff822c1000 A __per_cpu_load
      ffffffff822d3000 D init_per_cpu__gdt_page
    
    We got:
      ffffffff8279a600 D _edata
      ffffffff8279b000 A __vvar_page
      ffffffff8279c000 A __init_begin
      ffffffff8279c000 D init_per_cpu__irq_stack_union
      ffffffff8279c000 A __per_cpu_load
      ffffffff8279e000 D __vvar_beginning_hack
      ffffffff8279e080 0000000000000098 D vsyscall_gtod_data
      ffffffff827ae000 D init_per_cpu__gdt_page
    
    This happens because __vvar_page and .vvar get different addresses in
    arch/x86/kernel/vmlinux.lds.S:
    
    	. = ALIGN(PAGE_SIZE);
    	__vvar_page = .;
    
    	.vvar : AT(ADDR(.vvar) - LOAD_OFFSET) {
    		/* work around gold bug 13023 */
    		__vvar_beginning_hack = .;
    
    Discard .dtors/.fini_array/.text.exit, since we don't call dtors.
    Merge .text.startup into init text.
    
    Link: http://lkml.kernel.org/r/1467386363-120030-1-git-send-email-dvyukov@google.com
    Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
    Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
    Cc: <stable@vger.kernel.org>	[4.0+]
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 c189d7a2a48172c6adcd17cedcf55aaaef361838 4545644f4316ab845c02b31c4bb70b1399eb1a7a M	include
bisect run success

-- 

  ciao - 
    Stefan

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity 
planning reports. http://sdm.link/zohodev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

