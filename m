Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Wed, 13 Apr 2011 21:50:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201104132150.05623.richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: gcc-4.6.0 generates no code for sub_preempt_count()
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

I'm facing a very strange issue with gcc-4.6.0 and UML.
Within __local_bh_enable() gcc generates no code for sub_preempt_count().

See:
http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc460.txt
vs.
http://userweb.kernel.org/~rw/uml-gcc460/__local_bh_enable-gcc431.txt

Interestingly it generates code for add_preempt_count().
I can reproduce this on x86 and x86_64.

The problem has to do with UML's current_thread_info() function.
When I replace it with arch/x86's (unportable) variant gcc generates code.

Any ideas whether this is a gcc or a kernel issue?
Thanks,
//richard
