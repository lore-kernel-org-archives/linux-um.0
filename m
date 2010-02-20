Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 20 Feb 2010 15:16:05 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Patch] um: tell git to ignore generated files
Message-ID: <20100220151605.GQ30031@ZenIV.linux.org.uk>
References: <20100220143359.GD3000@hack>
 <20100220150936.GP30031@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100220150936.GP30031@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Am??rico Wang <xiyou.wangcong@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Feb 20, 2010 at 03:09:36PM +0000, Al Viro wrote:
> On Sat, Feb 20, 2010 at 10:33:59PM +0800, Am??rico Wang wrote:
> > 
> > git should ignore these files, since they are generated.
> 
> > +include/shared/kern_constants.h
> > +include/shared/user_constants.h
> 
> I have patches taking that to include/generated, actually

BTW, what's the status of skas4?  I have a series of patches leading towards
resurrection of uml/powerpc (skas0), but I'd rather avoid breaking skas4
in process...  Where does the recent version of that thing live?
