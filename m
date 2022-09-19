Return-Path: <peterz@infradead.org>
Message-ID: <20220919101523.312333837@infradead.org>
Date: Mon, 19 Sep 2022 12:00:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 44/44] arm64,riscv,perf: Remove RCU_NONIDLE() usage
References: <20220919095939.761690562@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: peterz@infradead.org
Cc: richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@kernel.org, linux@armlinux.org.uk, ulli.kroll@googlemail.com, linus.walleij@linaro.org, shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, tony@atomide.com, khilman@kernel.org, catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, bcain@quicinc.com, chenhuacai@kernel.org, kernel@xen0n.name, geert@linux-m68k.org, sammy@sammy.net, monstr@monstr.eu, tsbogend@alpha.franken.de, dinguyen@kernel.org, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com, James.Bottomley@HansenPartnership.com, deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net, richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, jgross@suse.com, srivatsa@csail.mit.edu, amakhalov@vmware.com, pv-drivers@vmware.com, boris.ostrovsky@oracle.com, chris@zankel.net, jcmvbkbc@gmail.com, rafael@kernel.org, lenb@kernel.org, pavel@ucw.cz, gregkh@linuxfoundation.org, mturquette@baylibre.com, sboyd@kernel.org, daniel.lezcano@linaro.org, lpieralisi@kernel.org, sudeep.holla@arm.com, agross@kernel.org, bjorn.andersson@linaro.org, konrad.dybcio@somainline.org, anup@brainfault.org, thierry.reding@gmail.com, jonathanh@nvidia.com, jacob.jun.pan@linux.intel.com, atishp@atishpatra.org, Arnd Bergmann <arnd@arndb.de>, yury.norov@gmail.com, andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk, dennis@kernel.org, tj@kernel.org, cl@linux.com, rostedt@goodmis.org, pmladek@suse.com, senozhatsky@chromium.org, john.ogness@linutronix.de, juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, fweisbec@gmail.com, ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com, Andrew Morton <akpm@linux-foundation.org>, jpoimboe@kernel.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, linux-omap@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-perf-users@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-xtensa@linux-xtensa.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com
List-ID: <linux-um.lists.infradead.org>

The PM notifiers should no longer be ran with RCU disabled (per the
previous patches), as such this hack is no longer required either.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/perf/arm_pmu.c       |   11 +----------
 drivers/perf/riscv_pmu_sbi.c |    8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -762,17 +762,8 @@ static void cpu_pm_pmu_setup(struct arm_
 		case CPU_PM_ENTER_FAILED:
 			 /*
 			  * Restore and enable the counter.
-			  * armpmu_start() indirectly calls
-			  *
-			  * perf_event_update_userpage()
-			  *
-			  * that requires RCU read locking to be functional,
-			  * wrap the call within RCU_NONIDLE to make the
-			  * RCU subsystem aware this cpu is not idle from
-			  * an RCU perspective for the armpmu_start() call
-			  * duration.
 			  */
-			RCU_NONIDLE(armpmu_start(event, PERF_EF_RELOAD));
+			armpmu_start(event, PERF_EF_RELOAD);
 			break;
 		default:
 			break;
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -747,14 +747,8 @@ static int riscv_pm_pmu_notify(struct no
 		case CPU_PM_ENTER_FAILED:
 			/*
 			 * Restore and enable the counter.
-			 *
-			 * Requires RCU read locking to be functional,
-			 * wrap the call within RCU_NONIDLE to make the
-			 * RCU subsystem aware this cpu is not idle from
-			 * an RCU perspective for the riscv_pmu_start() call
-			 * duration.
 			 */
-			RCU_NONIDLE(riscv_pmu_start(event, PERF_EF_RELOAD));
+			riscv_pmu_start(event, PERF_EF_RELOAD);
 			break;
 		default:
 			break;



