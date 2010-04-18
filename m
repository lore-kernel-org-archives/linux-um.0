Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BCB788E.2040501@kernel.org>
Date: Mon, 19 Apr 2010 06:24:30 +0900
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

Hello,

On 04/19/2010 01:37 AM, Jan Kiszka wrote:
> We now have to to include linux/slab.h explicitly for kmalloc & friends.
> Files that build against host headers already get their prototypes via
> um_malloc.h, linux/slab.h may even be unavailable.

Hmmm... my test um build was okay but I don't know much about details
of um builds.  I suppose this patch will go through um tree?

Thanks.

-- 
tejun
