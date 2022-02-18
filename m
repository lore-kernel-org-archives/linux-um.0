Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKy9U-00DFKV-Nq
 for linux-um@lists.infradead.org; Fri, 18 Feb 2022 07:58:06 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2d07ae11461so36362707b3.6
 for <linux-um@lists.infradead.org>; Thu, 17 Feb 2022 23:58:03 -0800 (PST)
Date: Fri, 18 Feb 2022 15:57:25 +0800
In-Reply-To: <20220218075727.2737623-1-davidgow@google.com>
Message-Id: <20220218075727.2737623-3-davidgow@google.com>
Mime-Version: 1.0
References: <20220218075727.2737623-1-davidgow@google.com>
Subject: [PATCH 2/4] drm/amdgpu: Make smu7_hwmgr build on UML
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

The User-Mode-Linux architecture (with the x86_64 subarch) defines
CONFIG_X86_64, but doesn't expose the cpuinfo_x86 struct (instead
there's a cpuinfo_um struct).

In order to allow UML to build with allyesconfig, only check cpuinfo_x86
on non-UML architectures.

Fixes: b3dc549986 ("mdgpu: Disable PCIE_DPM on Intel RKL Platform")
Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index a1e11037831a..a162552f7845 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1738,7 +1738,7 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 
 static bool intel_core_rkl_chk(void)
 {
-#if IS_ENABLED(CONFIG_X86_64)
+#if IS_ENABLED(CONFIG_X86_64) && !defined(CONFIG_UML)
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
-- 
2.35.1.265.g69c8d7142f-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

