Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
	<410FF1C3.9060509@enterasys.com>
From: Tom Hughes <thh@cyberscience.com>
In-Reply-To: <410FF1C3.9060509@enterasys.com> (D. Bahi's message of "Tue, 03
	Aug 2004 16:12:51 -0400")
Message-ID: <yek7jsftkdl.fsf@audi.uk.cyberscience.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 04 Aug 2004 08:47:34 +0100
To: "D. Bahi" <dbahi@enterasys.com>
Cc: Jeff Dike <jdike@addtoit.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

In message <410FF1C3.9060509@enterasys.com>
        D. Bahi <dbahi@enterasys.com> wrote:

> alright, i don't read assembly (head hung low) but
> valgrind 2.1.2/coregrind/vg_syscall.S has something
> that makes me ask why i'm getting the 'clone() not
> supported message'

You're not getting as far as any code in vg_syscall.S though. Don't
get confused by VG_(clone) as that has nothing to do with implementing
clone in the client program - it's used by valgrind to start the
background threads that it uses for handling blocking system calls.

> does this need some kind of tie-in code in vg_syscalls.c?

Not exactly. The message you are getting comes from vg_syscalls.c
but the point is that clone is not like other system calls where
you can trivially implement it - it would require a substantial
amount of work throughout valgrind.

Tom

-- 
Tom Hughes (thh@cyberscience.com)
Software Engineer, Cyberscience Corporation
http://www.cyberscience.com/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
