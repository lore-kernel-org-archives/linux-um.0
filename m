Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkqS5-0001oC-2J
 for linux-um@lists.infradead.org; Wed, 01 Aug 2018 12:42:06 +0000
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w71CeoBJ020450
 for <linux-um@lists.infradead.org>; Wed, 1 Aug 2018 08:41:53 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkbhgvgpe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Wed, 01 Aug 2018 08:41:53 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 1 Aug 2018 13:41:51 +0100
Date: Wed, 1 Aug 2018 15:41:45 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] um: switch to NO_BOOTMEM
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180731133827.GC23494@rapoport-lnx>
 <1574741.Uvo42kyWiX@blindfold>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1574741.Uvo42kyWiX@blindfold>
Message-Id: <20180801124144.GF24836@rapoport-lnx>
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-mm@kvack.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>

Hi Richard,

On Tue, Jul 31, 2018 at 09:03:35PM +0200, Richard Weinberger wrote:
> Am Dienstag, 31. Juli 2018, 15:38:27 CEST schrieb Mike Rapoport:
> > Any comments on this?
> > 
> > On Tue, Jul 24, 2018 at 04:23:12PM +0300, Mike Rapoport wrote:
> > > Hi,
> > > 
> > > These patches convert UML to use NO_BOOTMEM.
> > > Tested on x86-64.
> > > 
> > > Mike Rapoport (2):
> > >   um: setup_physmem: stop using global variables
> > >   um: switch to NO_BOOTMEM
> > > 
> > >  arch/um/Kconfig.common   |  2 ++
> > >  arch/um/kernel/physmem.c | 22 ++++++++++------------
> > >  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> Acked-by: Richard Weinberger <richard@nod.at>

Thanks!

Can you please merge this through the uml tree?
 
> Thanks,
> //richard
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

