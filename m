Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <7b6077ec-4603-c177-b321-0eeaeefaec70@infradead.org>
Date: Wed, 13 Jul 2022 13:40:48 -0700
MIME-Version: 1.0
Subject: Re: linux-next: Tree for Jul 13 (UML, apply_returns)
Content-Language: en-US
References: <20220713223328.07016b70@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220713223328.07016b70@canb.auug.org.au>
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
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-um <linux-um@lists.infradead.org>



On 7/13/22 05:33, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20220712:
> 

UML for x86_64 defconfig:

/usr/lib64/gcc/x86_64-suse-linux/12/../../../../x86_64-suse-linux/bin/ld: arch/x86/um/../kernel/module.o: in function `module_finalize':
module.c:(.text+0x416): undefined reference to `apply_returns'

arch/x86/kernel/alternative.o is not being built for UML.

-- 
~Randy

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

