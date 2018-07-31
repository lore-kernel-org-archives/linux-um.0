Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkUrR-0005PW-3z
 for linux-um@lists.infradead.org; Tue, 31 Jul 2018 13:38:50 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6VDJFEm005903
 for <linux-um@lists.infradead.org>; Tue, 31 Jul 2018 09:38:36 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kjnsy7w8a-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Tue, 31 Jul 2018 09:38:35 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Tue, 31 Jul 2018 14:38:33 +0100
Date: Tue, 31 Jul 2018 16:38:27 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] um: switch to NO_BOOTMEM
References: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <20180731133827.GC23494@rapoport-lnx>
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
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: linux-mm@kvack.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>

Any comments on this?

On Tue, Jul 24, 2018 at 04:23:12PM +0300, Mike Rapoport wrote:
> Hi,
> 
> These patches convert UML to use NO_BOOTMEM.
> Tested on x86-64.
> 
> Mike Rapoport (2):
>   um: setup_physmem: stop using global variables
>   um: switch to NO_BOOTMEM
> 
>  arch/um/Kconfig.common   |  2 ++
>  arch/um/kernel/physmem.c | 22 ++++++++++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

