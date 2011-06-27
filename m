Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 27 Jun 2011 08:27:33 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Message-Id: <20110627082733.75e58ae4.randy.dunlap@oracle.com>
In-Reply-To: <20110627161656.688820b9.sfr@canb.auug.org.au>
References: <20110627161656.688820b9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: linux-next: Tree for June 27 (uml)
To: Stephen Rothwell <sfr@canb.auug.org.au>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, 27 Jun 2011 16:16:56 +1000 Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20110624:


uml defconfig builds on x86 (32-bit and 64-bit) fail with:

fs/hostfs/hostfs_kern.c:756: error: 'mask' undeclared (first use in this function)


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
