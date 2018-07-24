Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhxHs-0006Ad-C2
 for linux-um@lists.infradead.org; Tue, 24 Jul 2018 13:23:38 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6ODIdHU061049
 for <linux-um@lists.infradead.org>; Tue, 24 Jul 2018 09:23:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ke1y28maa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Tue, 24 Jul 2018 09:23:23 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Tue, 24 Jul 2018 14:23:21 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/2] um: switch to NO_BOOTMEM
Date: Tue, 24 Jul 2018 16:23:12 +0300
Message-Id: <1532438594-4530-1-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>

Hi,

These patches convert UML to use NO_BOOTMEM.
Tested on x86-64.

Mike Rapoport (2):
  um: setup_physmem: stop using global variables
  um: switch to NO_BOOTMEM

 arch/um/Kconfig.common   |  2 ++
 arch/um/kernel/physmem.c | 22 ++++++++++------------
 2 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

