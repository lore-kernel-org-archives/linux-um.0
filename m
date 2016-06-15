Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 15 Jun 2016 05:45:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [rcu:rcu/next 25/36] include/linux/irqflags.h:79:3: error:
 implicit declaration of function 'arch_irqs_disabled_flags'
Reply-To: paulmck@linux.vnet.ibm.com
References: <201606060200.kVmeQzvA%fengguang.wu@intel.com>
 <20160614225417.GR3923@linux.vnet.ibm.com>
 <5760FE41.9060603@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5760FE41.9060603@nod.at>
Message-Id: <20160615124532.GW3923@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org, linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 15, 2016 at 09:05:37AM +0200, Richard Weinberger wrote:
> Paul,
> 
> Am 15.06.2016 um 00:54 schrieb Paul E. McKenney:
> > On Mon, Jun 06, 2016 at 02:04:03AM +0800, kbuild test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> >> head:   13ee0de9cd2444b57ce30c4f1607b49b90aa0c38
> >> commit: f251ac814fc5787765009e60d54a2bd4277350c8 [25/36] rcu: Make call_rcu_tasks() tolerate first call with irqs disabled
> >> config: um-allmodconfig (attached as .config)
> >> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> >> reproduce:
> >>         git checkout f251ac814fc5787765009e60d54a2bd4277350c8
> >>         # save the attached .config to linux build tree
> >>         make ARCH=um 
> > 
> > My kneejerk reaction would be to make CONFIG_TASKS_RCU depend on
> > !UML or something similar.
> > 
> > Another approach would be create a arch_irqs_disabled_flags() for UML.
> > 
> > Any preferences?
> 
> Patches for arch_irqs_disabled_flags() support are already on LKML:
> https://lkml.org/lkml/2016/6/12/162
> 
> My plan was to merge them in the v4.8 merge window.
> So having CONFIG_TASKS_RCU depend on !UML for now should be fine.
> We can remove the dependency in v4.8 again.

Sounds very good, thank you!

							Thanx, Paul


