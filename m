Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9NAf-0001WK-3w
 for linux-um@lists.infradead.org; Tue, 09 Feb 2021 07:10:50 +0000
Received: by mail-pj1-x104a.google.com with SMTP id x5so1094574pjk.7
 for <linux-um@lists.infradead.org>; Mon, 08 Feb 2021 23:10:43 -0800 (PST)
Date: Mon,  8 Feb 2021 23:10:34 -0800
Message-Id: <20210209071034.3268897-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] kunit: tool: Disable PAGE_POISONING under --alltests
From: David Gow <davidgow@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>, Shuah Khan <skhan@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>, kunit-dev@googlegroups.com

kunit_tool maintains a list of config options which are broken under
UML, which we exclude from an otherwise 'make ARCH=um allyesconfig'
build used to run all tests with the --alltests option.

Something in UML allyesconfig is causing segfaults when page poisining
is enabled (and is poisoning with a non-zero value). Previously, this
didn't occur, as allyesconfig enabled the CONFIG_PAGE_POISONING_ZERO
option, which worked around the problem by zeroing memory. This option
has since been removed, and memory is now poisoned with 0xAA, which
triggers segfaults in many different codepaths, preventing UML from
booting.

Note that we have to disable both CONFIG_PAGE_POISONING and
CONFIG_DEBUG_PAGEALLOC, as the latter will 'select' the former on
architectures (such as UML) which don't implement __kernel_map_pages().

Ideally, we'd fix this properly by tracking down the real root cause,
but since this is breaking KUnit's --alltests feature, it's worth
disabling there in the meantime so the kernel can boot to the point
where tests can actually run.

Fixes: f289041ed4 ("mm, page_poison: remove CONFIG_PAGE_POISONING_ZERO")
Signed-off-by: David Gow <davidgow@google.com>
---

As described above, 'make ARCH=um allyesconfig' is broken. KUnit has
been maintaining a list of configs to force-disable for this in
tools/testing/kunit/configs/broken_on_uml.config. The kernels we've
built with this have broken since CONFIG_PAGE_POISONING_ZERO was
removed, panic-ing on startup with:

<0>[    0.100000][   T11] Kernel panic - not syncing: Segfault with no mm
<4>[    0.100000][   T11] CPU: 0 PID: 11 Comm: kdevtmpfs Not tainted 5.11.0-rc7-00003-g63381dc6f5f1-dirty #4
<4>[    0.100000][   T11] Stack:
<4>[    0.100000][   T11]  677d3d40 677d3f10 0000000e 600c0bc0
<4>[    0.100000][   T11]  677d3d90 603c99be 677d3d90 62529b93
<4>[    0.100000][   T11]  603c9ac0 677d3f10 62529b00 603c98a0
<4>[    0.100000][   T11] Call Trace:
<4>[    0.100000][   T11]  [<600c0bc0>] ? set_signals+0x0/0x60
<4>[    0.100000][   T11]  [<603c99be>] lookup_mnt+0x11e/0x220
<4>[    0.100000][   T11]  [<62529b93>] ? down_write+0x93/0x180
<4>[    0.100000][   T11]  [<603c9ac0>] ? lock_mount+0x0/0x160
<4>[    0.100000][   T11]  [<62529b00>] ? down_write+0x0/0x180
<4>[    0.100000][   T11]  [<603c98a0>] ? lookup_mnt+0x0/0x220
<4>[    0.100000][   T11]  [<603c8160>] ? namespace_unlock+0x0/0x1a0
<4>[    0.100000][   T11]  [<603c9b25>] lock_mount+0x65/0x160
<4>[    0.100000][   T11]  [<6012f360>] ? up_write+0x0/0x40
<4>[    0.100000][   T11]  [<603cbbd2>] do_new_mount_fc+0xd2/0x220
<4>[    0.100000][   T11]  [<603eb560>] ? vfs_parse_fs_string+0x0/0xa0
<4>[    0.100000][   T11]  [<603cbf04>] do_new_mount+0x1e4/0x260
<4>[    0.100000][   T11]  [<603ccae9>] path_mount+0x1c9/0x6e0
<4>[    0.100000][   T11]  [<603a9f4f>] ? getname_kernel+0xaf/0x1a0
<4>[    0.100000][   T11]  [<603ab280>] ? kern_path+0x0/0x60
<4>[    0.100000][   T11]  [<600238ee>] 0x600238ee
<4>[    0.100000][   T11]  [<62523baa>] devtmpfsd+0x52/0xb8
<4>[    0.100000][   T11]  [<62523b58>] ? devtmpfsd+0x0/0xb8
<4>[    0.100000][   T11]  [<600fffd8>] kthread+0x1d8/0x200
<4>[    0.100000][   T11]  [<600a4ea6>] new_thread_handler+0x86/0xc0

Disabling PAGE_POISONING fixes this. The issue can't be repoduced with
just PAGE_POISONING, there's clearly something (or several things) also
enabled by allyesconfig which contribute. Ideally, we'd track these down
and fix this at its root cause, but in the meantime it'd be nice to
disable PAGE_POISONING so we can at least get the kernel to boot. One
way would be to add a 'depends on !UML' or similar, but since
PAGE_POISONING does seem to work in the non-allyesconfig case, adding it
to our list of broken configs seemed the better choice.

Thoughts?

(Note that to reproduce this, you'll want to run
./tools/testing/kunit/kunit.py run --alltests --raw_output
It also depends on a couple of other fixes which are not upstream yet:
https://www.spinics.net/lists/linux-rtc/msg08294.html
https://lore.kernel.org/linux-i3c/20210127040636.1535722-1-davidgow@google.com/

Cheers,
-- David

 tools/testing/kunit/configs/broken_on_uml.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
index a7f0603d33f6..690870043ac0 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -40,3 +40,5 @@
 # CONFIG_RESET_BRCMSTB_RESCAL is not set
 # CONFIG_RESET_INTEL_GW is not set
 # CONFIG_ADI_AXI_ADC is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PAGE_POISONING is not set
-- 
2.30.0.478.g8a0d178c01-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

