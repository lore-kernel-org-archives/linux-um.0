Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 14 Jun 2016 15:54:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rcu:rcu/next 25/36] include/linux/irqflags.h:79:3: error:
 implicit declaration of function 'arch_irqs_disabled_flags'
Reply-To: paulmck@linux.vnet.ibm.com
References: <201606060200.kVmeQzvA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201606060200.kVmeQzvA%fengguang.wu@intel.com>
Message-Id: <20160614225417.GR3923@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jun 06, 2016 at 02:04:03AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> head:   13ee0de9cd2444b57ce30c4f1607b49b90aa0c38
> commit: f251ac814fc5787765009e60d54a2bd4277350c8 [25/36] rcu: Make call_rcu_tasks() tolerate first call with irqs disabled
> config: um-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         git checkout f251ac814fc5787765009e60d54a2bd4277350c8
>         # save the attached .config to linux build tree
>         make ARCH=um 

My kneejerk reaction would be to make CONFIG_TASKS_RCU depend on
!UML or something similar.

Another approach would be create a arch_irqs_disabled_flags() for UML.

Any preferences?

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/spinlock.h:53:0,
>                     from kernel/rcu/update.c:36:
>    kernel/rcu/update.c: In function 'call_rcu_tasks':
> >> include/linux/irqflags.h:79:3: error: implicit declaration of function 'arch_irqs_disabled_flags' [-Werror=implicit-function-declaration]
>       arch_irqs_disabled_flags(flags); \
>       ^
>    include/linux/irqflags.h:149:36: note: in expansion of macro 'raw_irqs_disabled_flags'
>     #define irqs_disabled_flags(flags) raw_irqs_disabled_flags(flags)
>                                        ^~~~~~~~~~~~~~~~~~~~~~~
>    kernel/rcu/update.c:572:21: note: in expansion of macro 'irqs_disabled_flags'
>          (!havetask && !irqs_disabled_flags(flags))) {
>                         ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/arch_irqs_disabled_flags +79 include/linux/irqflags.h
> 
> df9ee292 David Howells 2010-10-07  73  		typecheck(unsigned long, flags);	\
> df9ee292 David Howells 2010-10-07  74  		flags = arch_local_save_flags();	\
> df9ee292 David Howells 2010-10-07  75  	} while (0)
> df9ee292 David Howells 2010-10-07  76  #define raw_irqs_disabled_flags(flags)			\
> df9ee292 David Howells 2010-10-07  77  	({						\
> df9ee292 David Howells 2010-10-07  78  		typecheck(unsigned long, flags);	\
> df9ee292 David Howells 2010-10-07 @79  		arch_irqs_disabled_flags(flags);	\
> df9ee292 David Howells 2010-10-07  80  	})
> df9ee292 David Howells 2010-10-07  81  #define raw_irqs_disabled()		(arch_irqs_disabled())
> df9ee292 David Howells 2010-10-07  82  #define raw_safe_halt()			arch_safe_halt()
> 
> :::::: The code at line 79 was first introduced by commit
> :::::: df9ee29270c11dba7d0fe0b83ce47a4d8e8d2101 Fix IRQ flag handling naming
> 
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



