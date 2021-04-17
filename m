Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ciao.gmane.io ([116.202.254.214])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXpJg-005uTS-6L
 for linux-um@lists.infradead.org; Sat, 17 Apr 2021 18:05:15 +0000
Received: from list by ciao.gmane.io with local (Exim 4.92)
 (envelope-from <glud-user-mode-linux-devel@m.gmane-mx.org>)
 id 1lXpJW-00071U-ER
 for linux-um@lists.infradead.org; Sat, 17 Apr 2021 20:05:02 +0200
From: sbaugh@catern.com
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
Date: Sat, 17 Apr 2021 12:28:16 -0400
Message-ID: <87sg3oub8f.fsf@catern.com>
References: <20210414055217.543246-1-avagin@gmail.com>
Mime-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org


Just to add to the list of use cases for PROCESS_VM_EXEC_SYSCALL,
another use case is initializing a process from the "outside", instead
of from the "inside" as fork requires.  This can be much easier to work
with.  http://catern.com/rsys21.pdf goes into this use case in some
depth.

It relies heavily on a remote syscall primitive:
https://github.com/catern/rsyscall.  The PROCESS_VM_EXEC_SYSCALL API
proposed in this patch would be a great replacement for the current
implementation, which relies on running code inside the target process.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

