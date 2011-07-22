Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 22 Jul 2011 08:53:46 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20110722085346.51565411.rdunlap@xenotime.net>
In-Reply-To: <20110722164237.2b3f6cbdedafa9e1d3f70867@canb.auug.org.au>
References: <20110722164237.2b3f6cbdedafa9e1d3f70867@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: linux-next: Tree for July 22 (uml)
To: Stephen Rothwell <sfr@canb.auug.org.au>, Richard Weinberger <richard@nod.at>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 22 Jul 2011 16:42:37 +1000 Stephen Rothwell wrote:

> Hi all,

uml build on i386 fails with:

arch/um/sys-i386/built-in.o: In function `call_rwsem_down_read_failed':
linux-next-20110722/arch/um/sys-i386/../../x86/lib/rwsem.S:93: undefined reference to `rwsem_down_read_failed'
arch/um/sys-i386/built-in.o: In function `call_rwsem_down_write_failed':
linux-next-20110722/arch/um/sys-i386/../../x86/lib/rwsem.S:105: undefined reference to `rwsem_down_write_failed'
arch/um/sys-i386/built-in.o: In function `call_rwsem_wake':
linux-next-20110722/arch/um/sys-i386/../../x86/lib/rwsem.S:118: undefined reference to `rwsem_wake'
arch/um/sys-i386/built-in.o: In function `call_rwsem_downgrade_wake':
linux-next-20110722/arch/um/sys-i386/../../x86/lib/rwsem.S:130: undefined reference to `rwsem_downgrade_wake'


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
