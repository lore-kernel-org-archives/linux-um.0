Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKy9M-00DFFa-AE
 for linux-um@lists.infradead.org; Fri, 18 Feb 2022 07:57:58 +0000
Received: by mail-pf1-x449.google.com with SMTP id
 d16-20020a056a0010d000b004e0204c9753so1286816pfu.7
 for <linux-um@lists.infradead.org>; Thu, 17 Feb 2022 23:57:55 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:23 +0800
Message-Id: <20220218075727.2737623-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH 0/4] kunit,um: Fix kunit.py build --alltests
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Shuah Khan <skhan@linuxfoundation.org>, Brendan Higgins <brendanhiggins@google.com>, Randy Dunlap <rdunlap@infradead.org>
Cc: David Gow <davidgow@google.com>, linux-um@lists.infradead.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org, felix.kuehling@amd.com, linux-kernel@vger.kernel.org

kunit_tool's --alltests option uses UML and make allyesconfig to produce
a configuration which enables as many tests as possible. However, make
ARCH=um allyesconfig is broken for a number of reasons.

Fix a few different UML build breakages, and disable a few config
options in kunit_tool in order to get this kernel compiling again.

Note that the resulting kernel still doesn't run, but having it compile
is the first step to fixing that.

David Gow (3):
  drm/amdgpu: Make smu7_hwmgr build on UML
  IB/qib: Compile under User-Mode Linux
  kunit: tool: Disable broken options for --alltests

Randy Dunlap (1):
  drm/amdgpu: Fix compilation under UML

 drivers/gpu/drm/amd/amdkfd/kfd_crat.c               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c           | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 drivers/infiniband/hw/qib/qib_wc_x86_64.c           | 4 ++++
 tools/testing/kunit/configs/broken_on_uml.config    | 5 +++++
 5 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.35.1.265.g69c8d7142f-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

