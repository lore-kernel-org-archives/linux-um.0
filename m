Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 28 Feb 2010 10:28:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 66/66]
	arch/um/sys-x86_64/shared/sysdep/skas_ptrace.h: Checkpatch cleanup
Message-ID: <20100228152839.GA3063@localhost.localdomain>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net> <1267289508-31031-67-git-send-email-andrea.gelmini@gelma.net> <20100227221310.GA5455@localhost.localdomain> <9cdbb57f1002280606j6d6ca697k21f42cff87d685de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cdbb57f1002280606j6d6ca697k21f42cff87d685de@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Gelmini <andrea.gelmini@gelma.net>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Feb 28, 2010 at 03:06:21PM +0100, Andrea Gelmini wrote:
> 2010/2/27 Jeff Dike <jdike@addtoit.com>:
> Hi Jeff,
>    and thanks for your reply.
> 
> > Don't you have anything better to do with your time?
> 
> It's a dirty job, but somebody has to do it...

To be a bit more serious, the UML tree was once a seething mass of
checkpatch violations.  I cleaned up a lot of it while making other
changes in the area.  This sort of thing I think is reasonably
worthwhile, but dumping in a whole lot of checkpatch changes doesn't
help anything and it just pollutes the change history.

				Jeff
