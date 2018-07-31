Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkZw4-0004wL-I5
 for linux-um@lists.infradead.org; Tue, 31 Jul 2018 19:03:58 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 0/2] um: switch to NO_BOOTMEM
Date: Tue, 31 Jul 2018 21:03:35 +0200
Message-ID: <1574741.Uvo42kyWiX@blindfold>
In-Reply-To: <20180731133827.GC23494@rapoport-lnx>
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180731133827.GC23494@rapoport-lnx>
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
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>

Am Dienstag, 31. Juli 2018, 15:38:27 CEST schrieb Mike Rapoport:
> Any comments on this?
> 
> On Tue, Jul 24, 2018 at 04:23:12PM +0300, Mike Rapoport wrote:
> > Hi,
> > 
> > These patches convert UML to use NO_BOOTMEM.
> > Tested on x86-64.
> > 
> > Mike Rapoport (2):
> >   um: setup_physmem: stop using global variables
> >   um: switch to NO_BOOTMEM
> > 
> >  arch/um/Kconfig.common   |  2 ++
> >  arch/um/kernel/physmem.c | 22 ++++++++++------------
> >  2 files changed, 12 insertions(+), 12 deletions(-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

