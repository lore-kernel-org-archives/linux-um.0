Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5040AAAE.30501@gmail.com>
Date: Fri, 31 Aug 2012 14:14:38 +0200
From: Marco Stornelli <marco.stornelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: 3.6rc-3 doesn't compile um arch
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, torvalds@linux-foundation.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi,

I'm trying to compile the latest kernel for arch um, using the latest 
Linus's tree, but it doesn't compile due to the commit:

um: pass siginfo to the guest process.

I think the fix is trivial. At line 117 of os-Linux/time.c you find
this line:

   alarm_handler(SIGVTALRM, NULL);

but it should be:

   alarm_handler(SIGVTALRM, NULL, NULL);

Is it already fixed?

Marco
