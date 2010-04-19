Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Apr 2010 18:29:49 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] uml: Fix build breakage after slab.h changes
In-Reply-To: <4BCC07C0.5050601@web.de>
Message-ID: <alpine.LRH.2.00.1004191829220.28179@twin.jikos.cz>
References: <4BCB353A.3040806@web.de> <4BCB788E.2040501@kernel.org> <4BCC07C0.5050601@web.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Tejun Heo <tj@kernel.org>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Tiger Yang <tiger.yang@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 19 Apr 2010, Jan Kiszka wrote:

> > I suppose this patch will go through um tree?
> 
> Good question. Does such a tree exist? I'm sitting on a few more um
> cleanups & fixes, and so far I'm working against Linus' tree as I failed
> to find anything more recent.

If these are simple-enough cleanups and/or compile fixes, feel free to 
send them to trivial@kernel.org.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

