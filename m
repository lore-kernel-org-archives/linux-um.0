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
	<yek3c33tk5o.fsf@audi.uk.cyberscience.com>
	<20040804153541.GA7237@ccure.user-mode-linux.org>
From: Tom Hughes <thh@cyberscience.com>
In-Reply-To: <20040804153541.GA7237@ccure.user-mode-linux.org> (Jeff Dike's
	message of "Wed, 4 Aug 2004 11:35:41 -0400")
Message-ID: <yekacxbrlvi.fsf@audi.uk.cyberscience.com>
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
Date: Wed, 04 Aug 2004 15:58:09 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, Nicholas Nethercote <njn25@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

In message <20040804153541.GA7237@ccure.user-mode-linux.org>
        Jeff Dike <jdike@addtoit.com> wrote:

>> But how did you cope with the fact that valgrind doesn't protect it's
>> internal data structures in any way? You would have all sorts of
>> problems with two threads trying to access the same data.
>
> I think I was mistaken about this firing off another valgrind thread, for
> two reasons.  
>
> I remember being concerned about whether the process data was still
> present in its normal, not running under valgrind, form.  This would
> only be a problem if you were planning on running a non-valgrind
> thread in the same address space.

Even doing that (if it's still possible) is quite dangerous as
that thread could accidentally damage valgrind's environment.

> Second, the patch above looks like it extracts the client IP from
> valigrind's state and branches to it.  This would make the new
> thread a non-valgrind one.

That would imply that the newly created thread was left to run on
the real CPU rather than the simulated CPU. If that's the case then
I'm not that it is possible anymore - I know we had to take out the
stuff that allowed valgrind to switch back to the real CPU after
running a specified number of basic blocks because it could no longer
be made to work.

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
