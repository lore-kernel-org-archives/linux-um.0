Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHnXj-0002R7-Ku
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 10:16:09 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: Testing UserModeLinux with kbuild bot
Date: Wed, 31 Oct 2018 11:15:54 +0100
Message-ID: <2576349.EAEpUZHT3j@blindfold>
In-Reply-To: <20181031100743.wstzibltwysrmmgr@wfg-t540p.sh.intel.com>
References: <1924684.J8ZAjWOtys@blindfold>
 <20181031100743.wstzibltwysrmmgr@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
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
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Philip Li <philip.li@intel.com>, linux-um@lists.infradead.org, kbuild-all@01.org, LKP <lkp@intel.com>

Fengguang,

Am Mittwoch, 31. Oktober 2018, 11:07:43 CET schrieb Fengguang Wu:
> Hi Richard,
> 
> On Wed, Oct 31, 2018 at 09:45:57AM +0100, Richard Weinberger wrote:
> >Fengguang,
> >
> >I wonder what kind of tests currently are enabled for UML?
> >If I remember correctly we disabled some a few years ago.
> 
> Currently we are testing tree
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

good! Which branches linux-next and master?
 
Is it also possible to test patches which land on our mailinglist?

> There are no special settings for UML tree, so the standard build
> tests, static checks, boot tests and runtime tests will be performed.
> Note that there are no UML specific runtime test case.

Are you interested in rumtime tests?
Actually running a UML is pretty easy.
I can provide some command lines.

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

