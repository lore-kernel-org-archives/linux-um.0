Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1761160AbZCSXee@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: [patch] fix uml slowness caused by ptrace preemption bug on host
In-Reply-To: Miklos Szeredi's message of  Thursday, 19 March 2009 23:23:50 +0100 <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
References: <E1LkQeU-00020Z-Be@pomaz-ex.szeredi.hu>
Message-Id: <20090319233311.8B26BFC381@magilla.sf.frob.com>
Date: Thu, 19 Mar 2009 16:33:11 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: peterz@infradead.org, efault@gmx.de, rjw@sisk.pl, jdike@addtoit.com, mingo@elte.hu, Oleg Nesterov <oleg@redhat.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I'm no scheduler expert and I don't know whether the exact placement in
your change is the optimal one.  But it's certainly fine from a ptrace
perspective.


Thanks,
Roland
