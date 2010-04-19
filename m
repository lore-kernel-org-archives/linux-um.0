Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BCC1998.2090604@kernel.org>
Date: Mon, 19 Apr 2010 17:51:36 +0900
From: Tejun Heo <tj@kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] uml: Fix build breakage after slab.h changes
References: <4BCB353A.3040806@web.de>
In-Reply-To: <4BCB353A.3040806@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Tiger Yang <tiger.yang@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 04/19/2010 01:37 AM, Jan Kiszka wrote:
> We now have to to include linux/slab.h explicitly for kmalloc & friends.
> Files that build against host headers already get their prototypes via
> um_malloc.h, linux/slab.h may even be unavailable.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@web.de>

applied to percpu#for-linus/next.  Will push to Linus in a few days.

Thanks.

-- 
tejun
