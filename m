Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYN0m-00GHkg-6h
 for linux-um@lists.infradead.org; Thu, 07 Oct 2021 06:36:13 +0000
Received: by mail-qv1-xf32.google.com with SMTP id jo30so3535296qvb.3
 for <linux-um@lists.infradead.org>; Wed, 06 Oct 2021 23:36:08 -0700 (PDT)
Received: from crass-HP-ZBook-15-G2 ([37.218.244.251])
 by smtp.gmail.com with ESMTPSA id t17sm14973692qtq.56.2021.10.06.23.36.06
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 23:36:06 -0700 (PDT)
Date: Thu, 7 Oct 2021 01:36:01 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Using GDB to debug a user space process in UML
Message-ID: <20211007013601.45fa8947@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

I'm trying to debug a crash in busybox while it is the init process in
a UML instance. I'm having trouble breaking on the entry point of the
busybox binary. I'm pretty new to this space, so I'm proceeding from a
lot of ignorance, please correct me where I'm wrong and help me clear
up some things.

Based on the tracing and debugging sections of the UML howto[1] and
other potentially out-of-date mailinglist comments, I understand that
the architecture of UML is that there is one kernel thread, a SIGIO
thread, a UBD thread, and some other threads for MMU emulation. One
thing that is unclear to me is where the user-space processes fir in to
this. In some old mailinglist emails, I've seen things that lead me to
belief that all user-space processes are in the kernel thread. I've
also seen things suggesting that each user space process has its own
thread, perhaps this was only with SKAS(3) mode. My guess is that they
are all in the one kernel thread.

When I break on start_thread, I can see its being called with an EIP
that is the value of the entry point of the busybox binary. But when I
set a break point (software or hardware), it never gets hit. My guess
is that that address, which is virtual for the UML, must get translated
to the real virtual address of the UML process/host kernel. If so, how
do I do that translation?

I've also tried to step into the busybox from the kernel by stepping
through instructions after breaking on switch_threads. This doesn't
seem to ever step through non-kernel space. Am I correct that the
UML_LONGJMP is the part of the code that would jump into user space?

Also, I may be confused about TT (thread tracing) vs SKAS (separate
kernel address space) modes. My understanding is that the mainline has
what's called SKAS0, which was called TT mode. And what was called SKAS
mode, also called SKAS3, was never merged into mainline. Is this
correct?

I've seen the question of debugging user space in UML pop up on the old
mailing list, but haven't really seen much in the way of an answer. Is
there currently a way to do this? If the UML user space process's
address space is remapped in the UML process, it seems like gdb could
theoretically be able remap the debug symbols to the right place.

Any help would be much appreciated,
Glenn

[1]
https://www.kernel.org/doc/html/v5.14/virt/uml/user_mode_linux_howto_v2.html#tracing-uml


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

