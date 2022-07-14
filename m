Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 14 Jul 2022 12:20:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] um: Add missing apply_returns()
Message-ID: <Ys/t45l/garIrD0u@worktop.programming.kicks-ass.net>
References: <20220713223328.07016b70@canb.auug.org.au>
 <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, x86@kernel.org

On Wed, Jul 13, 2022 at 01:40:48PM -0700, Randy Dunlap wrote:
> 
> 
> On 7/13/22 05:33, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20220712:
> > 
> 
> UML for x86_64 defconfig:
> 
> /usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
> module.c:(.text+0x416): undefined reference to `apply_returns'
> 
> arch/x86/kernel/alternative.o is not being built for UML.
> 

---
Subject: um: Add missing apply_returns()

Implement apply_returns() stub for UM, just like all the other patching
routines.

Fixes: 15e67227c49a ("x86: Undo return-thunk damage")
Reported-by: Randy Dunlap <rdunlap@infradead.org)
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 0760e24f2eba..9838967d0b2f 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -432,6 +432,10 @@ void apply_retpolines(s32 *start, s32 *end)
 {
 }
 
+void apply_returns(s32 *start, s32 *end)
+{
+}
+
 void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

