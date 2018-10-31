Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHnPp-0007aI-DQ
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 10:07:58 +0000
Date: Wed, 31 Oct 2018 18:07:43 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: Testing UserModeLinux with kbuild bot
Message-ID: <20181031100743.wstzibltwysrmmgr@wfg-t540p.sh.intel.com>
References: <1924684.J8ZAjWOtys@blindfold>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1924684.J8ZAjWOtys@blindfold>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: Philip Li <philip.li@intel.com>, linux-um@lists.infradead.org, kbuild-all@01.org, LKP <lkp@intel.com>

Hi Richard,

On Wed, Oct 31, 2018 at 09:45:57AM +0100, Richard Weinberger wrote:
>Fengguang,
>
>I wonder what kind of tests currently are enabled for UML?
>If I remember correctly we disabled some a few years ago.

Currently we are testing tree

https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git

There are no special settings for UML tree, so the standard build
tests, static checks, boot tests and runtime tests will be performed.
Note that there are no UML specific runtime test case.

Thanks,
Fengguang

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

